import BaseRepository from './../../parents/BaseRepository';
import BaseResponse from '../../parents/BaseResponse';
import InsertConversationResponse from '../response/InsertConversationResponse';
import ExitChatResponse from '../response/ExitChatResponse';

export default class ApiRepository extends BaseRepository{
    constructor(){
        super();
    }

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
     * @param params => Parameter to process in API
     * @param schoolUid => Id of school
     * @param callback => Callback of success
     */
    insertConversation(params: {}, schoolUid: string, 
        callback: (response: InsertConversationResponse) => void): void {
        this.post(InsertConversationResponse, 'chat/conversation/send/'+schoolUid, params, callback);
    }
}