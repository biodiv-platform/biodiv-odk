import 'dotenv/config'

import { FastifyInstance } from "fastify";

import createServer from "./server";

async function run() {
  process.on("unhandledRejection", (err) => {
    console.error(err);
    process.exit(1);
  });

  // eslint-disable-next-line @typescript-eslint/no-unsafe-call, @typescript-eslint/no-var-requires
  const app = require("fastify")({
    logger: true
  }) as FastifyInstance;
  void app.register(createServer);

  await app.listen({ port: 3003 }, (err) => {
    if (err) {
      console.error(err)
      process.exit(1)
    }
  })
}

void run();
