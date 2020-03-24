import BaseResponse from "../../parents/BaseResponse";

/**
 @var received_by_server_at => Time when server received the message
 */
export default class InsertConversationResponse extends BaseResponse {
    display_name: string = "";
    display_foto: string = "";
    display_id_url: string = "";
    received_by_server_at: string = "";
}