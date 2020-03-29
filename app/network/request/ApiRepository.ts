import BaseRepository from './../../parents/BaseRepository';
import BaseResponse from '../../parents/BaseResponse';
import InsertConversationResponse from '../response/InsertConversationResponse';
import ExitChatResponse from '../response/ExitChatResponse';
import { AskForDelayedMessageResponse } from '../response/AskForDelayedMessageResponse';
import AskForLatestStatusResponse from '../response/AskForLatestStatusResponse';


export default class ApiRepository extends BaseRepository{
    /**
     * Update status online in db
     * @param params => Parameter to process in API
     * @param callback => Callback of success
     */
    online(params: {}, callback: (response: BaseResponse) => void): void{
        this.post(BaseResponse, 'chat/joinchat', params, callback);
    }

    /**
     * Update status offline in db
     * @param params => Parameter to process in API
     * @param callback => Callback of success
     */
    offline(params: {}, callback: (response: ExitChatResponse) => void): void {
        this.post(ExitChatResponse, 'chat/exitchat', params, callback);
    }

    /**
     * Insert message to db and 
     * Get information of sender (id, name, photo) that will be send to receiver
     * @param params => Parameter to process in API, which contains 
     * @var conversation_id => Unique ID generated from App
     * @var sender_url_id => Id of sender user
     * @var receiver_url_id => Id of receiver user
     * @var conversation => Encrypted Message
     * @var send_at => Time when user trying to send the message, cause maybe there will be 
     * a delay either no internet connection, so sender cannot send that message at that time,
     * app should check periodically and send message automatically when internet connection established
     * @var target_url_id => Receiver Id
     * 
     * @param schoolUid => Id of school
     * @param callback => Callback of success
     */
    insertConversation(params: {}, schoolUid: string, 
        callback: (response: InsertConversationResponse) => void): void {
        this.post(InsertConversationResponse, `chat/conversation/send/${schoolUid}`, params, callback);
    }

    /**
     * Update conversation status to 2 (RECEIVED)
     * @param params => Parameter to process in API, which contains
     * @var conversation_id => Id of conversation / message
     * 
     * @param schoolUid => Id of school
     * @param callback => Callback of success
     */
    receiveMessage(params: {}, schoolUid: string, callback: (response: BaseResponse) => void): void {
        this.post(BaseResponse, `chat/conversation/received/${schoolUid}`, params, callback);
    }

    /**
     * Update conversation status to 2 (RECEIVED)
     * @param params => Parameter to process in API, which contains
     * @var sender_id => Id of message sender
     * @var receiver_id => Id of receiver (current user)
     * @var read_at => Date Time yyyy-MM-dd HH:mm:ss / This server time
     * 
     * @param schoolUid => Id of school
     * @param callback => Callback of success
     */
    readAllMessage(params: {}, schoolUid: string, callback: (response: BaseResponse) => void): void {
        this.post(BaseResponse, `chat/conversation/read/${schoolUid}`, params, callback);
    }

    /**
     * Get delayed message from API for this user
     * @param schoolUid => School ID
     * @param receiverId => Receiver ID, in this case this user ID
     * @param callback => Callback of success
     */
    askForDelayedMessage(schoolUid: string, receiverId: string, callback: (response: AskForDelayedMessageResponse) => void): void {
        this.post(AskForDelayedMessageResponse, `chat/delayed/message/${schoolUid}/${receiverId}`, undefined, callback);
    }

    /**
     * Get latest status message from API which sent by this user
     * @param params => Parameter to process in API, which contains
     * @var data => Object of list, which contains
     *  @var conversation_id => Id of message
     * 
     * @param schoolUid => School ID
     * @param callback => Callback of success
     */
    askForLatestStatusMessage(params: {}, schoolUid: string, callback: (response: AskForLatestStatusResponse) => void): void {
        this.post(AskForLatestStatusResponse, `chat/latest/status/${schoolUid}`, { 'messages' : JSON.stringify(params) }, callback);
    }
}