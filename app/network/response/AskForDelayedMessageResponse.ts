import BaseResponse from "../../parents/BaseResponse";

export class AskForDelayedMessageResponse extends BaseResponse {
    data: DelayedMessagedata[] = [];
}

class DelayedMessagedata {
    id_conversation: string = "";
    conversation: string = "";
    sender_url_id: string = "";
    receiver_url_id: string = "";
    received_by_target_at: string = "";
    sender: SenderDelayedMessage = new SenderDelayedMessage();
}

class SenderDelayedMessage {
    display_name: string = "";
    display_foto: string = "";
}