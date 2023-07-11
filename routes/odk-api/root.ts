"use strict";

import { FastifyInstance } from "fastify";

export default async function (fastify: FastifyInstance) {
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  fastify.get("/item", async function (request, reply) {
    return {
      success: true,
      application: "biodiv-odk"
    };
  });
}
