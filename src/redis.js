// redis-client.js
import redis from 'redis';
import {promisify} from 'util';
const client = redis.createClient(process.env.REDIS_URL);
export default client;

export const getAsync= promisify(client.get).bind(client);
export const setAsync= promisify(client.set).bind(client);
export const keysAsync= promisify(client.keys).bind(client);

