import BaseResponse from "../../parents/BaseResponse";

export default class AskForLatestStatusResponse extends BaseResponse {
    data: AskForLatestStatusData[] = [];
}

class AskForLatestStatusData {
    id_conversation: string = "";
    status: string = "";
    sent_at?: number;
    read_at?: number;
}