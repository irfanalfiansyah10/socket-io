import { Socket, Namespace } from 'socket.io';
import ApiRepository from '../../network/request/ApiRepository';
import ChatEventEmitter from './emitter';
import BaseEventHandler from '../../parents/BaseEventHandler';
import ChatBroadcaster from './broadcaster';
import { Encrypt, Decrypt } from '../../global/global';
import { classToPlain } from 'class-transformer';

/**
 * Class that handle event retrieved from App
 * in /chat namespace
 */
export default class ChatEventReceiver extends BaseEventHandler{
    api: ApiRepository;
    emitter: ChatEventEmitter;
    broadcaster: ChatBroadcaster;
    
    constructor(socket: Socket, server: Namespace){
        super(socket, server);
        
        this.api = new ApiRepository();
        this.emitter = new ChatEventEmitter(socket, server);
        this.broadcaster = new ChatBroadcaster(socket, server);
    }

    /**
     * Update online status
     * 
     * Called when user connected
     * 
     * Joining room with same school ID
     * 
     * Storing socket id to Connected Cache
     * 
     * Remove socket from Inactive Cache
     */
    onConnect(): void {
        if(this.isAnonymous()) return;

        let params = {
            'id_user_url' : this.userUid,
            'school_uid' : this.schoolUid,
            'socket_id' : this.socket.id,
        };

        this.api.online(params, (_) => {
            this.socket.join(this.schoolUid);
            this.broadcaster.broadcastOnline();
            this.storeConnectedUser(this.key(), this.socket.id);
            this.removeInactiveUser(this.key());
        });
    }

    /**
     * Similar as @see onConnect()
     * but with different cache storing, and not joining room
     * in @see onConnect() we store user to Connected Cache
     * but in @see onForeground() we remove user from Inactive Cache
     */
    onForeground(): void {
        if(this.isAnonymous()) return;

        let params = {
            'id_user_url' : this.userUid,
            'school_uid' : this.schoolUid,
            'socket_id' : this.socket.id,
        };

        this.api.online(params, (_) => {
            this.broadcaster.broadcastOnline();
            this.removeInactiveUser(this.key());
        });
    }

    /**
     * Similar as @see onDisconnect()
     * but with different cache storing, and not leaving room
     * in @see onDisconnect() we remove user from Connected Cache
     * but in @see onBackground() we store user to Inactive Cache
     */
    onBackground(): void {
        if(this.isAnonymous()) return;
        
        let params = {
            'id_user_url' : this.userUid,
            'school_uid' : this.schoolUid,
            'socket_id' : this.socket.id,
        };
        this.api.offline(params, (res) => {
            this.broadcaster.broadcastOffline(res);
            this.storeInactiveUser(this.key(), this.socket.id);
        });
    }

    /**
     * Notify to interlocutor that user is typing
     * Then app change status to "Typing..."
     * @param data, which contains
     * @var target_url_id => Interlocutor id,
     */
    onTyping(data: any): void {
        if(this.isAnonymous()) return;

        this.emitter.onUserSendTypingNotif(data);
    }

    /**
     * User sends chat
     * @param data chat data, which contains
     * @var conversation_id => Unique ID generated from App
     * @var conversation => Message
     * @var send_at => Time when user trying to send the message, cause maybe there will be 
     * a delay either no internet connection, so sender cannot send that message at that time,
     * app should check periodically and send message automatically when internet connection established
     * @var target_url_id => Receiver Id
     * 
     * @param callback callback that chat has retrieved by server, so the UI
     * change chat status to "SENT" or one checklist like in WhatsApp, contains parameter
     * @var conversation_id => Unique ID generated from App
     * @var received_by_server_at => Datetime yyyy-MM-dd HH:mm:ss
     */
    onSendChat(data: any, callback: (data: any) => void): void {
        if(this.isAnonymous()) return;
        
        let params = {
            'conversation_id' : data.conversation_id,
            'sender_url_id' : this.userUid,
            'receiver_url_id' : data.target_url_id,
            'conversation' : Encrypt((data.conversation as string).trim()),
            'send_at' : data.send_at
        };

        this.api.insertConversation(params, this.schoolUid, (r) => {
            let emitData = {
                'conversation_id' : data.conversation_id,
                'sender_url_id' : this.userUid,
                'receiver_url_id' : data.target_url_id,
                'conversation' : (data.conversation as string).trim(),
                'received_by_server_at' : r.received_by_server_at,
                'sender' : {
                    'display_name' : r.display_name,
                    'display_foto' : r.display_foto
                }
            };
            callback({
                'conversation_id' : data.conversation_id,
                'received_by_server_at' : r.received_by_server_at
            });

            this.emitter.onServerSendChat(emitData);
        });
    }

    /**
     * User receive chat, so server can send notification to sender that 
     * this user was receive the message and app change status to "RECEIVED" or 
     * double checklist like in WhatsApp
     * @param data chat data, which contains
     * @var conversation_id => Id of conversation / message
     * @var sender_id => Id of sender the conversation message
     */
    onReceiveChat(data: any): void {
        if(this.isAnonymous()) return;

        let params = { 
            'conversation_id' : data.conversation_id
        }

        this.api.receiveMessage(params, this.schoolUid, (_) => {
            this.emitter.onServerNotifyMessageReceived(data);
        });
    }

    /**
     * User read all chat sent from sender, then
     * server can send notification to sender that this user was read the message
     * and app change status to "READ" or double checklist blue like in WhatsApp
     * 
     * @param data chat data, which contains
     * @var sender_id => Id of message sender
     */
    onReadChat(data: any): void {
        if(this.isAnonymous()) return;

        let readAt = this.millisecondSinceEpoch();
        let params = {
            'sender_id' : data.sender_id,
            'receiver_id' : this.userUid,
            'read_at' : readAt,
        };

        this.api.readAllMessage(params, this.schoolUid, (r) => {
            this.emitter.onServerNotifyMessageRead(params);
        });
    }

    /**
     * Get undelivered message to this user, this may happens when sender sends message
     * while this user offline
     * 
     * @param callback, called with parameter
     *  @param data => List of undelivered message
     */
    onAskingForDelayedMessage(callback: (data: any) => void): void {
        if(this.isAnonymous()) return;

        this.api.askForDelayedMessage(this.schoolUid, this.userUid, (r) => {
            r.data.forEach((it) => {
                it.conversation = Decrypt(it.conversation);

                let emitData = {
                    'sender_url_id' : it.sender_url_id,
                    'conversation_id' : it.id_conversation,
                    'received_by_target_at' : it.received_by_target_at
                };
                this.emitter.onServerNotifyDelayedMessageReceived(emitData);
            });

            if(r.data.length > 0){
                callback(classToPlain(r));
            }
        });
    }

    /**
     * Get latest message status which sent from this user,
     * cause maybe the receiver has received / read messages when this user
     * goes offline
     * 
     * @param data => List of message that want to see latest status of the message, which contains
     * @var data => Object of list, which contains
     *  @var conversation_id => Id of message
     * 
     * @param callback, called with parameter
     *  @param data => List of message with latest status, which contains
     *  @var conversation_id => Id of message
     *  @var status => Status of message (SENT / READ), then the UI will update with the latest status
     *  @var sent_at => Time when receiver get the message, value as Milliseconds since epoch
     *  @var read_at => Time when receiver read the message, value as Milliseconds since epoch
     */
    onAskingForLatestReportMessage(data: any, callback: (data: any) => void): void {
        if(this.isAnonymous()) return;

        this.api.askForLatestStatusMessage(data, this.schoolUid, (r) => {
            callback(r);
        });
    }
    
    /**
     * Update offline status
     * 
     * Called when user log out 
     * or app closed
     * 
     * Leaving school room
     * 
     * Remove from Connected Cache 
     * 
     * Store to Inactive Cache
     * 
     */
    onDisconnect(): void{
        if(this.isAnonymous()) return;
        
        let params = {
            'id_user_url' : this.userUid,
            'school_uid' : this.schoolUid,
            'socket_id' : this.socket.id,
        };
        this.api.offline(params, (res) => {
            this.socket.leave(this.schoolUid);
            this.broadcaster.broadcastOffline(res);
            this.removeConnectedUser(this.key());
            this.storeInactiveUser(this.key(), this.socket.id);
        });
    }
}