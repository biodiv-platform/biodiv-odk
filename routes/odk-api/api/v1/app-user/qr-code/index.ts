// @ts-check
import { FastifyInstance } from "fastify";

import { getAllOdkUser } from "../../../../../../controller/user.controller";
import { axGetAppUserByEmail } from "../../../../../../services/odk.service";
import getVerifiedUser from "../../../../../../utils/jwt";
import getQRSVG from "../../../../../../utils/qrcode";

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

  fastify.get("/", async function (request: any, reply) {
    const { xmlFormId, projectId = 1, BAToken } = request.query;
    const user: any = getVerifiedUser(request.cookies.BAToken || BAToken);

    try {
      if (user.email && xmlFormId) {
        const appUser = await axGetAppUserByEmail(user.email, xmlFormId, projectId);

        reply.header("Content-Type", "image/svg+xml");
        reply.send(getQRSVG(appUser));
      }
    } catch (e) {
      console.error(e);
      reply.code(500).send({ success: false });
    }
  });
}
