import BaseEventHandler from "../../parents/BaseEventHandler";
import { ChatAction } from "..";
import { Logger } from "../../global/global";

export default class ChatEventEmitter extends BaseEventHandler{
    
    /**
     * Server sends chat to target
     * @param data, data retrieved from API after successful insertion, which contains
     * @var conversation_id => ID of conversation
     * @var sender_url_id => Sender ID
     * @var receiver_url_id => Receiver ID
     * @var conversation => The message
     * @var received_by_server_at => Time when message retrieved by server
     * @var sender.display_id_url => Url Id of sender
     * @var sender.display_name => Name of sender
     * @var sender.display_foto => Photo of sender
     * 
     * @emits event @see ChatAction.SOMEONE_SEND_MESSAGE as Event name
     * @emits data => @param data
     */
    onServerSendChat(data: any): void{
        if(!this.isConnected(this.otherUserKey(data.receiver_url_id))) return;

        var receiverSocket = this.getConnectedSocket(this.otherUserKey(data.receiver_url_id));

        this.server.to(receiverSocket).emit(ChatAction.SOMEONE_SEND_MESSAGE, data);
    }

    /**
     * Server sends received notification to sender
     * Then sender apps change message status to "RECEIVED" or double checklist like WhatsApp
     * 
     * @param data, which contains
     * @var sender_url_id => Sender Id
     * @var conversation_id => Id of message / conversation
     * 
     * @emits event @see ChatAction.TARGET_RECEIVE_MESSAGE as Event name
     * @emits conversation_id => @param data.conversation_id
     * @emits received_by_target_at => Milliseconds since epoch
     */
    onServerNotifyMessageReceived(data: any): void {
        if(!this.isConnected(this.otherUserKey(data.sender_url_id))) return;

        var senderSocket = this.getConnectedSocket(this.otherUserKey(data.sender_url_id));

        this.server.to(senderSocket).emit(ChatAction.TARGET_RECEIVE_MESSAGE, { 
            'conversation_id' : data.conversation_id,
            'received_by_target_at' : this.millisecondSinceEpoch(),
        });
    }

    /**
     * Server sends received notification to sender that their messages already received
     * when receiver online
     * Then sender apps change message status to "RECEIVED" or double checklist like WhatsApp
     * 
     * @param data, which contains
     * @var sender_url_id => Sender Id
     * @var conversation_id => Id of message / conversation
     * @var received_by_target_at => Datetime when target receive the message
     * 
     * @emits event @see ChatAction.TARGET_RECEIVE_DELAYED_MESSAGE as Event name
     * @emits conversation_id => Id of message / conversation
     * @emits received_by_target_at => Datetime when target receive the message
     */
    onServerNotifyDelayedMessageReceived(data: any): void {
        if(!this.isConnected(this.otherUserKey(data.sender_url_id))) return;

        var senderSocket = this.getConnectedSocket(this.otherUserKey(data.sender_url_id));

        this.server.to(senderSocket)
            .emit(ChatAction.TARGET_RECEIVE_DELAYED_MESSAGE, { 
                'conversation_id' : data.conversation_id,
                'received_by_target_at' : data.received_by_target_at,
            });
    }

    /**
     * This user send typing notification to interlocutor
     * @param data, data passed from @see ChatEventReceiver_onTyping() which contains
     * @var target_url_id => Interlocutor id,
     * 
     * @emits event @see ChatAction.SOMEONE_TYPING as Event name
     * @emits data to target which contains 
     * @var from_url_id => Current User Id
     */
    onUserSendTypingNotif(data: any){
        if(!this.isConnected(this.otherUserKey(data.target_url_id))) return;

        var targetSocketId = this.getConnectedSocket(this.otherUserKey(data.target_url_id));
        Logger.debug(`Target Socket Id ${targetSocketId}`);

        this.socket.to(targetSocketId).emit(ChatAction.SOMEONE_TYPING, {
            'from_url_id' : this.userUid,
        });
    }

    /**
     * Server sends read notification to sender
     * Then sender apps change message status to "READ" or double checklist blue like WhatsApp
     * 
     * @param data, which contains
     * @var sender_id => Sender Id
     * @var receiver_id => Receiver Id
     * @var read_at => Milliseconds since epoch
     * 
     * @emits event @see ChatAction.TARGET_READ_MESSAGE as Event name
     * @emits receiver_id => Receiver Id / This User Id
     * @emits read_at => Milliseconds since epoch
     */
    onServerNotifyMessageRead(data: any): void {
        if(!this.isConnected(this.otherUserKey(data.sender_id))) return;

        var senderSocketId = this.getConnectedSocket(this.otherUserKey(data.sender_id));

        this.server.to(senderSocketId).emit(ChatAction.TARGET_READ_MESSAGE, {
            'receiver_id' : data.receiver_id,
            'read_at' : data.read_at
        });
    }
}