// @ts-check
import { FastifyInstance, FastifyRequest } from "fastify";

import {
  createOdkUser,
  deleteOdkAppUser,
  deleteOdkWebUser,
  getAllOdkUser,
  OdkUserInterface
} from "../../../../controller/odk.controller";
import { axGetAppUserByEmail } from "../../../../services/odk.service";
import getVerifiedUser from "../../../../utils/jwt";
import getQRSVG from "../../../../utils/qrcode";

export default async function (fastify: FastifyInstance) {
  fastify.get("/all", async function (request, reply) {
    try {
      const user = await getAllOdkUser();
      reply.code(200).send(user);
    } catch (e) {
      console.error("My error code is", e);
      reply.code(500).send({ success: false });
    }
  });

  fastify.get(
    "/create/user",
    async function (request: FastifyRequest<{ Body: OdkUserInterface }>, reply) {
      const { authorization } = request.headers;
      if (!authorization) reply.code(500).send({ success: false });
      const token = authorization?.split(" ")[1] || "";

      const { roles }: any = getVerifiedUser(token);

      if (!roles.includes("ROLE_ADMIN")) reply.code(500).send({ success: false });
      try {
        const payload: OdkUserInterface = request.body;

        const user = await createOdkUser(payload);
        reply.code(200).send(user);
      } catch (e) {
        console.error("My error code is", e);
        reply.code(500).send({ success: false });
      }
    }
  );

  fastify.get("/", async function (request: any, reply) {
    const { xmlFormId, projectId = 1, BAToken } = request.query;
    const user: any = getVerifiedUser(request.cookies.BAToken || BAToken);

    try {
      if (user.email && xmlFormId) {
        const appUser = await axGetAppUserByEmail(user.email, projectId, true, xmlFormId);

        reply.header("Content-Type", "image/svg+xml");
        reply.send(getQRSVG(appUser));
      }
    } catch (e) {
      console.error(e);
      reply.code(500).send({ success: false });
    }
  });

  fastify.delete("/remove/web-user/:id", async function (request, reply) {
    const { authorization } = request.headers;
    if (!authorization) reply.code(500).send({ success: false });
    const token = authorization?.split(" ")[1] || "";

    const { roles }: any = getVerifiedUser(token);

    if (!roles.includes("ROLE_ADMIN")) reply.code(500).send({ success: false });

    try {
      const { id, email }: any = request.params;

      const user = await deleteOdkWebUser(id, email);
      reply.code(200).send(user);
    } catch (e) {
      console.error("My error code is", e);
      reply.code(500).send({ success: false });
    }
  });

  fastify.delete("/remove/app-user/:userName/:projetcId", async function (request, reply) {
    const { authorization } = request.headers;
    if (!authorization) reply.code(500).send({ success: false });
    const token = authorization?.split(" ")[1] || "";

    const { roles }: any = getVerifiedUser(token);

    if (!roles.includes("ROLE_ADMIN")) reply.code(500).send({ success: false });

    try {
      const { userName, projetcId }: any = request.params;
      const user = await deleteOdkAppUser(userName, projetcId);
      reply.code(200).send(user);
    } catch (e) {
      console.error("My error code is", e);
      reply.code(500).send({ success: false });
    }
  });
}
