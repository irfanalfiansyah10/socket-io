import { Socket, Namespace } from "socket.io";
import ChatEventReceiver from './chat/receiver';

export class ChatAction {
    public static readonly SOMEONE_ONLINE = "someone online";
    public static readonly SOMEONE_OFFLINE = "someone offline";
    public static readonly SOMEONE_SEND_MESSAGE = "someone send you message";
    public static readonly TARGET_RECEIVE_MESSAGE = "target receive your message";
    public static readonly TARGET_RECEIVE_DELAYED_MESSAGE = "target receive your delayed message";
    public static readonly TARGET_READ_MESSAGE = "target read your message";
    public static readonly SOMEONE_TYPING = "someone typing";
}

export class ChatEvent {
    public static readonly CONNECTED = 'connection';
    public static readonly TYPING = 'i\'m typing';
    public static readonly SENDING_MESSAGE = 'i\'m sending message';
    public static readonly RECEIVING_MESSAGE = 'i\'m receiving message';
    public static readonly ASK_FOR_DELAYED_MESSAGE = 'give me my delayed message';
    public static readonly ASK_FOR_UPDATED_MESSAGE_REPORT = 'give me my latest report message message';
    public static readonly READING_MESSAGE = 'i\'m reading message';
    public static readonly GO_TO_FOREGROUND = 'i\'m going to foreground';
    public static readonly GO_TO_BACKGROUND = 'i\'m going to background';
    public static readonly DISCONNECTED = 'disconnect';
}

export function registerChatEventHandler(socket: Socket, server: Namespace): ChatEventReceiver{
    return new ChatEventReceiver(socket, server);
}