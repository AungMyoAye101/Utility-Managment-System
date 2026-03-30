import { format } from 'date-fns';
import { v4 as uuid } from 'uuid';
import fs from 'fs';
import fsPromises from 'fs/promises';
import path from 'path';
import { Request, Response, NextFunction } from 'express';

/** CWD-based so bundled CJS (no import.meta) and tsx dev both resolve logs reliably. */
const logsDir = path.join(process.cwd(), 'logs');

export const logEvents = async (message: string, logFileName: string) => {
  const dateTime = format(new Date(), 'yyyyMMdd\tHH:mm:ss');
  const logItem = `${dateTime}\t${uuid()}\t${message}\n`;

  try {
    if (!fs.existsSync(logsDir)) {
      await fsPromises.mkdir(logsDir, { recursive: true });
    }
    await fsPromises.appendFile(path.join(logsDir, logFileName),
      logItem
    );
  } catch (err) {
    console.log(err);
  }
};

export function customLogger(loggerName: string) {
  return function (req: Request, _res: Response, next: NextFunction) {
    logEvents(`${req.method}\t${req.url}\t${req.headers.origin}`, 'reqLog.log');
    console.log(loggerName, `${req.method} ${req.path}`);
    next();
  };
}
