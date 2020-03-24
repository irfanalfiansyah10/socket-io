import Cfg from './config.json';
import { createLogger, format, transports } from 'winston';
import DailyFile from 'winston-daily-rotate-file';
import Fs from 'fs';
import Path from 'path';
import NodeCache from "node-cache";
import crypto from 'crypto';
require('dotenv').config();

const environment: string = process.env.ENVIRONMENT || '';
export const Config: any = environment == 'development' ? 
  Cfg['development'] : environment == 'staging' ? 
  Cfg['staging'] : Cfg['production'];

const logPath: string = `${process.env.PWD}/${Config['log_path']}`;

if(!Fs.existsSync(logPath)){
    Fs.mkdirSync(logPath);
}

export const Logger = createLogger({
    level: Config['log_level'],
    format: format.combine(
        format.timestamp({
          format: 'YYYY-MM-DD HH:mm:ss'
        }),
        format.printf(info => `${info.timestamp} ${info.level}: ${info.message}`)
      ),
      transports: [
        new transports.Console({
          level: Config['log_level'],
          format: format.combine(
            format.colorize(),
            format.printf(
              info => `${info.timestamp} ${info.level}: ${info.message}`
            )
          )
        }),
        new DailyFile({
          filename: Path.join(logPath, '%DATE% '+Config['log_filename']),
          datePattern: 'YYYY-MM-DD-HH',
        })
      ]
});

export const Cache = new NodeCache({stdTTL: 24 * 60 * 60, checkperiod: 24 * 60 * 60});

export function Encrypt(text: string) {
  let iv = crypto.randomBytes(16);
  let cipher = crypto.createCipheriv(process.env.ENCRYPTION_ALGORITHM || '', 
    Buffer.from(process.env.ENCRYPTION_KEY || ''), iv);
  let encrypted = cipher.update(text);
 
  encrypted = Buffer.concat([encrypted, cipher.final()]);
 
  return iv.toString('hex') + '/' + encrypted.toString('hex');
}

export function Decrypt(text: string) {
  let textParts = text.split(':');
  let iv = Buffer.from(textParts[0], 'hex');
  let encryptedText = Buffer.from(textParts[1], 'hex');
  let decipher = crypto.createDecipheriv(process.env.ENCRYPTION_ALGORITHM || '', 
    Buffer.from(process.env.ENCRYPTION_KEY || ''), iv);
  let decrypted = decipher.update(encryptedText);
 
  decrypted = Buffer.concat([decrypted, decipher.final()]);
 
  return decrypted.toString();
 }
 
 