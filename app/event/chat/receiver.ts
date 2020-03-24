import { Socket, Namespace } from 'socket.io';
import ApiRepository from '../../network/request/ApiRepository';
import ChatEventEmitter from './emitter';
import BaseEventHandler from '../../parents/BaseEventHandler';
import ChatBroadcaster from './broadcaster';
import { Cache, Logger, Encrypt, Decrypt } from '../../global/global';

class ChatEventReceiver extends BaseEventHandler{
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
     * Called when user logged in 
     * or app in foreground
     */
    onConnect(): void{
        if(this.isAnonymous()) return;

        let params = {
            'id_user_url' : this.userUid,
            'school_uid' : this.schoolUid,
            'socket_id' : this.socket.id,
        };

        this.api.online(params, (_) => {
            this.socket.join(this.schoolUid);
            this.broadcaster.broadcastOnline();
            Cache.set<string>(this.userUid, this.socket.id);
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
     * @var written_at => Time when user write and send the message, cause maybe there will be 
     * a delay either no internet connection, so sender cannot send that message at that time,
     * app should check periodically and send message automatically when internet connection established
     * @var target_url_id => Receiver Id
     * 
     * @param callback callback that chat has retrieved by server, so the UI
     * change chat status to "SENT" or one checklist like in WhatsApp, contains parameter
     * @var conversationId => Unique ID generated from App
     */
    onSendChat(data: any, callback: (conversationId: string) => void): void {
        if(this.isAnonymous()) return;
        
        let params = {
            'conversation_id' : data.conversation_id,
            'sender_url_id' : this.userUid,
            'receiver_url_id' : data.target_url_id,
            'conversation' : Encrypt(data.conversation),
            'written_at' : data.written_at
        };

        this.api.insertConversation(params, this.schoolUid, (r) => {
            let emitData = {
                'conversation_id' : data.conversation_id,
                'sender_url_id' : this.userUid,
                'receiver_url_id' : data.target_url_id,
                'conversation' : data.conversation,
                'received_by_server_at' : r.received_by_server_at,
                'sender_user' : {
                    'display_id_url' : r.display_id_url,
                    'display_name' : r.display_name,
                    'display_foto' : r.display_foto
                }
            };

            this.emitter.onServerSendChat(emitData);
        });
    }

    /**
     * User receive chat
     * @param data chat data, which contains
     * @var conversation_id => Id of conversation / message
     * @var from_url_id => Id of interlocutor
     * @var receive_at => Time when user read the message, so 
     * server can send notification to interlocutor that this user was read the message
     * and app change status to "RECEIVED" or double checklist like in WhatsApp
     */
    onReceiveChat(data: any): void {
        
    }

    /**
     * User read chat
     * @param data chat data, 
     * {
     * 'conversation_id':'text', => Id of conversation / message
     * 'from_url_id':'unique user id', => Id of interlocutor
     * 'read_at' : datetime, => Time when user read the message, so 
     * server can send notification to interlocutor that this user was read the message
     * and app change status to "READ" or double checklist blue like in WhatsApp
     * }
     */
    onReadChat(data: any): void {
        if(this.isAnonymous()) return;
        
        let conversationId = data.conversation_id;

        console.log('Chat Retrieved '+conversationId);
    }
    
    /**
     * Update offline status
     * 
     * Called when user log out 
     * or app closed
     * or app in background
     */
    onDisconnect(): void{
        if(this.isAnonymous()) return;
        
        let params = {
            'id_user_url' : this.userUid,
            'school_uid' : this.schoolUid,
            'socket_id' : this.socket.id,
        };
        this.api.offline(params, (res) => {
            this.socket.join(this.schoolUid);
            this.broadcaster.broadcastOffline(res);
            Cache.del(this.userUid);
        });
    }
}

export default function registerChatEventHandler(socket: Socket, server: Namespace): ChatEventReceiver{
    return new ChatEventReceiver(socket, server);
}