"use strict";
import AutoLoad from "@fastify/autoload";
import fastifyCookie from "@fastify/cookie";
// import dotenv from "dotenv";
import { FastifyInstance } from "fastify";
import path from "path";

export default async function (fastify: FastifyInstance, opts: any) {
  // Place here your custom code!
  fastify.register(fastifyCookie, {
    parseOptions: {} // options for parsing cookies
  });

  // Do not touch the following lines

  // This loads all plugins defined in plugins
  // those should be support plugins that are reused
  // through your application
  fastify.register(AutoLoad, {
    dir: path.join(__dirname, "plugins"),
    options: Object.assign({}, opts)
  });

  // This loads all plugins defined in routes
  // define your routes in one of these
  fastify.register(AutoLoad, {
    dir: path.join(__dirname, "routes"),
    options: Object.assign({}, opts)
  });
}
