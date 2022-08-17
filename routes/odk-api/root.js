"use strict";

module.exports = async function (fastify, opts) {
  fastify.get("/", async function (request, reply) {
    return {
      success: true,
      application: "biodiv-odk",
    };
  });
};
