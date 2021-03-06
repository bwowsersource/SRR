// ESM
import Fastify from 'fastify'
import {routes} from './routes.js'
const fastify = Fastify({
  logger: true
})

fastify.register(routes)

fastify.listen(process.env.PORT||3000, function (err, address) {
  if (err) {
    fastify.log.error(err)
    process.exit(1)
  }
  // Server is now listening on ${address}
})