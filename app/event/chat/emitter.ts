import BaseEventHandler from "../../parents/BaseEventHandler";

export default class ChatEventEmitter extends BaseEventHandler{
    
    /**
     * Server sends chat to target
     * @param data, data retrieved from API after successful insertion, which contains
     * @var conversation_id => ID of conversation
     * @var sender_url_id => Sender ID
     * @var receiver_url_id => Receiver ID
     * @var conversation => The message
     * @var received_by_server_at => Time when message retrieved by server
     * 
     * @emits data retrieved from API
     */
    onServerSendChat(data: any): void{
        if(!this.isCacheExists(data.receiver_url_id)) return;

        var targetSocketId = this.getString(data.receiver_url_id);

        this.server.to(targetSocketId).emit('someone send you message', data);
    }

    /**
     * This user send typing notification to interlocutor
     * @param data, data passed from @see ChatEventReceiver_onTyping() which contains
     * @var target_url_id => Interlocutor id,
     * 
     * @emits data to target which contains 
     * @var from_url_id => Current User Id
     */
    onUserSendTypingNotif(data: any){
        if(!this.isCacheExists(data.target_url_id)) return;

        var targetSocketId = this.getString(data.target_url_id);

        this.socket.to(targetSocketId).emit('someone typing', {
            'from_url_id' : this.userUid,
        });
    }
}