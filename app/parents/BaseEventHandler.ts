import { Socket, Namespace } from "socket.io";
import { ConnectedCache, InactiveCache, FireTokenCache } from '../global/global';

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
        this.userRole == null }

    /**
     * Key to use for cache
     * Should use this as Cache Key when storing data about this user
     */
    protected key(): string { return `${this.schoolUid}:${this.userUid}` }

    /**
     * Key to use for cache
     * Should use this as Cache Key when storing data about this user
     */
    protected otherUserKey(userUid: string): string { return `${this.schoolUid}:${userUid}` }
    
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
     * @param key => Key of stored data in Connected Cache
     * @return true if cache contains key
     */
    protected isConnected(key: string): boolean { return ConnectedCache.has(key) } 

    /**
     * Get Socket ID from Connected Cache
     * @param key => Key of stored data in Connected Cache
     * @return data stored in Connected Cache as string
     */
    protected getConnectedSocket(key: string): string { 
        if(this.isConnected(key)){
            return ConnectedCache.get(key) as string;
        }else {
            return "";
        }
    } 

    /**
     * Store data to Connected Cache
     * called when user connected
     * @param key => Key of stored data in cache
     */
    protected storeConnectedUser(key: string, socketId: string): void { ConnectedCache.set(this.key(), socketId) }

    /**
     * Delete data from Connected Cache
     * called when user disconnected
     * @param key => Key of stored data in cache
     */
    protected removeConnectedUser(key: string): void { ConnectedCache.del(key) }

    /**
     * @param key => Key of stored data in Inactive Cache
     * @return true if cache contains key
     */
    protected isInactive(key: string): boolean { return InactiveCache.has(key) } 

    /**
     * Get Socket ID from Inactive Cache
     * @param key => Key of stored data in Inactive Cache
     * @return data stored in Inactive Cache as string
     */
    protected getInactiveSocket(key: string): string { 
        if(this.isInactive(key)){
            return InactiveCache.get(key) as string;
        }else {
            return "";
        }
    } 

    /**
     * Store data to Inctive Cache
     * called when user goes to background
     * @param key => Key of stored data in cache
     */
    protected storeInactiveUser(key: string, socketId: string): void { InactiveCache.set(this.key(), socketId) }

    /**
     * Delete data from Inactive Cache
     * called when user goes to foreground
     * @param key => Key of stored data in cache
     */
    protected removeInactiveUser(key: string): void { InactiveCache.del(key) }

    /**
     * Store token to Firebase Token Cache
     * called when user connected
     * @param key => Key of stored data in cache
     */
    protected storeFireToken(key: string, socketId: string): void { FireTokenCache.set(this.key(), socketId) }

    /**
     * Get current date time
     * @return DateTime yyyy-MM-dd HH:mm:ss as String
     */
    protected currentDateTime(): string { 
        var today = new Date();
        var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
        var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();

        return date+' '+time;
    }

    /**
     * Get current millisecond since epoch
     * @return millisecond since epoch
     */
    protected millisecondSinceEpoch(): number {
        return new Date().valueOf();
    }
}