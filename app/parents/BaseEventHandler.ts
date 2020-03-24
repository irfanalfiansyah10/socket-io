import { Socket, Namespace } from "socket.io";
import { Cache } from '../global/global';

export default class BaseEventHandler {
    protected socket: Socket;
    protected server: Namespace;

    protected userUid: string;
    protected userRole: string;
    protected schoolUid: string;

    constructor(socket: Socket, server: Namespace){
        this.socket = socket;
        this.server = server;

        this.userUid = socket.handshake.headers['x-halokes-user-url'];
        this.userRole = socket.handshake.headers['x-halokes-user-role'];
        this.schoolUid = socket.handshake.headers['x-halokes-school-uid'];
    }

    /**
     * Check whether user is anonymous or not
     */
    protected isAnonymous(): boolean { return this.userUid == null || 
        this.schoolUid == null || 
        this.userRole == null}
    
    /**
     * @return true if user role is student
     */
    protected isStudent(): boolean { return this.userRole == 'student' }

    /**
     * @return true if user role is parent
     */
    protected isParent(): boolean { return this.userRole == 'parent' }

    /**
     * @return true if user role is teacher
     */
    protected isTeacher(): boolean { return this.userRole == 'teacher' }

    /**
     * @return true if cache contains key
     */
    protected isCacheExists(key: string): boolean { return Cache.has(key)} 

    /**
     * @return element stored in cache as string
     */
    protected getString(key: string): string { 
        if(this.isCacheExists(key)){
            return Cache.get(key) as string;
        }else {
            return "";
        }
    } 
}