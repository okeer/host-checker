import TCPPortChecker from './checker';
import express from 'express';

const checker = new TCPPortChecker();

export async function api(request: express.Request, response: express.Response) {
    response.set('Access-Control-Allow-Origin', '*');
    response.removeHeader('x-powered-by');

    switch (request.method) {
        case 'GET':
            if (request.path.localeCompare('/check') === 0) {
                if (request.query.port && request.query.host) {
                    let result = await checker
                        .executeCheck(request.query.port, request.query.host);
                    console.log(`Checking port ${request.query.port} on ${request.query.host}`);
                    response.status(200).send(JSON.stringify(result));
                }
                else {
                    response.status(400).send(JSON.stringify({
                        error: '"host" and "port" query parameters are missing!'
                    }))
                }
            }
            else if (request.path.localeCompare('/healthz') === 0) {
                response.status(200).send();
            }
            else {
                response.status(404).send();
            }
            break;
        case 'OPTIONS':
            response.set('Access-Control-Allow-Methods', 'GET');
            response.set('Access-Control-Allow-Headers', 'Content-Type');
            response.set('Access-Control-Max-Age', '3600');
            response.status(204).send();
            break;
        default:
            response.status(404).send();
    }
}
