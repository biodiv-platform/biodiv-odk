"use strict";

import { FastifyInstance } from "fastify";

export default async function (fastify: FastifyInstance) {
  fastify.get("/item", async function (request, reply) {
    return {
      success: true,
      application: "biodiv-odk"
    };
  });
}
