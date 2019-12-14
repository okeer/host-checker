import * as net from "net";

const TIMEOUT = 500;

export interface CheckerResult {
    reached: boolean,
    message: string
}

export class CheckerResultFactory {
    static buildResult(reached: boolean, message: string): CheckerResult {
        return {
            reached: reached,
            message: `${message}`
        }
    }
}

export default class TCPPortChecker {
    public async executeCheck(port: number, host: string): Promise<CheckerResult> {
        return new Promise((resolve) => {
            const client = net.connect(port, host)
                .setTimeout(TIMEOUT)
                .on('connect', () => {
                    client.destroy();
                    resolve(CheckerResultFactory
                        .buildResult(true, `Connected to ${host}:${port}`));
                })
                .on('timeout', () => {
                    client.destroy();
                    resolve(CheckerResultFactory
                        .buildResult(false, `Failed to connect to ${host}:${port}: timed out`));
                })
                .on('error', (e) => {
                    client.destroy();
                    resolve(CheckerResultFactory
                        .buildResult(false, `Failed to connect to ${host}:${port}: ${e.message}`));
                });
        });
    }
}
