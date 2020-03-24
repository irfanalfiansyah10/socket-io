import BaseResponse from "../../parents/BaseResponse";

/**
 * @var last_logout => User Last Logout
 */
export default class ExitChatResponse extends BaseResponse {
    last_logout: string = "";
}