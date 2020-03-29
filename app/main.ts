import express from 'express';
import socket, { Socket } from 'socket.io';
import _http from 'http';
import { registerChatEventHandler, ChatEvent } from './event/index';
import { Logger } from './global/global';

//set global sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

let app = express();
let http = _http.createServer(app);
let io = socket(http, {
    pingTimeout: 15000,
    pingInterval: 15000,
});

/**
 * Namespace of chat server
 * user will join to this server if specifically using this namespace
 * example : socket.connect('url:port/namespace')
 */
let chatServer = io.of('/chat');

/**
 * Middleware Chat Server
 * 
 * throw Authentication Error when no headers with
 * x-halokes-user-url or x-halokes-user-role or x-halokes-school-uid found
 */
chatServer.use((socket, next) => {
    let userUid = socket.handshake.headers['x-halokes-user-url'];
    let userRole = socket.handshake.headers['x-halokes-user-role'];
    let schoolUid = socket.handshake.headers['x-halokes-school-uid'];

    if(userUid != null && userRole != null && schoolUid != null){
        return next();
    }

    return next(new Error('Authentication Error, User and School must be defined'));
});

/**
 * Automatically called when user connected to socket with namespace /chat
 */
chatServer.on(ChatEvent.CONNECTED, function(socket: Socket){
    let event = registerChatEventHandler(socket, chatServer);

    socket.on(ChatEvent.TYPING, (data) => event.onTyping(data));
    socket.on(ChatEvent.SENDING_MESSAGE, (data, callback) => event.onSendChat(data, callback));
    socket.on(ChatEvent.RECEIVING_MESSAGE, (data) => event.onReceiveChat(data));
    socket.on(ChatEvent.ASK_FOR_DELAYED_MESSAGE, (_, callback) => event.onAskingForDelayedMessage(callback));
    socket.on(ChatEvent.ASK_FOR_UPDATED_MESSAGE_REPORT, (data, callback) => event.onAskingForLatestReportMessage(data, callback));
    socket.on(ChatEvent.READING_MESSAGE, (data) => event.onReadChat(data));
    socket.on(ChatEvent.GO_TO_FOREGROUND, () => event.onForeground());
    socket.on(ChatEvent.GO_TO_BACKGROUND, () => event.onBackground());
    socket.on(ChatEvent.DISCONNECTED, () => event.onDisconnect());

    event.onConnect(); 
}); 

/**
 * Register socket to port :3000
 */
http.listen(3000, () => Logger.info('Connection Established'));