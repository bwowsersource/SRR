// import client from "./redis.js";

async function query(req, reply) {
  const { key } = req.params;
  const value = req.query;
  // const rawData = await redisClient.getAsync(key);
  // return JSON.parse(rawData);
  return { hello: "World!!" };
}

export async function routes(fastify, options) {
  fastify.get("/:lat-:long/get-:limit", query);
  fastify.get("/:lat-:long/get-:limit-from:from", query);
}
