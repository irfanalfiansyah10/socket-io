import express from 'express';
import socket, { Socket } from 'socket.io';
import _http from 'http';
import { registerChatEventHandler } from './event/index';
import { Logger } from './global/global';

//set global sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

let app = express();
let http = _http.createServer(app);
let io = socket(http);

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
chatServer.on('connection', function(socket: Socket){
    let event = registerChatEventHandler(socket, chatServer);

    socket.on('i\'m typing', (data) => event.onTyping(data));
    socket.on('i\'m sending message', (data, callback) => event.onSendChat(data, callback));
    socket.on('i\'m sending my delayed message', (data) => {});
    socket.on('i\'m receiving message', (data) => event.onReceiveChat(data));
    socket.on('i\'m receiving my delayed message', (data) => {});
    socket.on('i\'m reading message', (data) => event.onReadChat(data));
    socket.on('i\'m going to foreground', () => event.onConnect());
    socket.on('i\'m going to background', () => event.onDisconnect());
    socket.on('disconnect', () => event.onDisconnect());

    event.onConnect(); 
}); 

app.get('/guru_1', function(req, res){
    res.sendFile('/Users/apple/Documents/Node JS Project/Halokes Node Server/pages/guru_1.html');
});
app.get('/guru_2', function(req, res){
    res.sendFile('/Users/apple/Documents/Node JS Project/Halokes Node Server/pages/guru_2.html');
});
app.get('/guru_3', function(req, res){
    res.sendFile('/Users/apple/Documents/Node JS Project/Halokes Node Server/pages/guru_3.html');
});
app.get('/guru_4', function(req, res){
    res.sendFile('/Users/apple/Documents/Node JS Project/Halokes Node Server/pages/guru_4.html');
});
app.get('/guru_5', function(req, res){
    res.sendFile('/Users/apple/Documents/Node JS Project/Halokes Node Server/pages/guru_5.html');
});

/**
 * Register socket to port :3000
 */
http.listen(3000, () => Logger.info('Connection Established'));