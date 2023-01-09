// @ts-check
import { FastifyInstance, FastifyRequest } from "fastify";

import {
  createOdkUser,
  deleteOdkAppUser,
  deleteOdkWebUser,
  getAllOdkUser,
  getAllProjects,
  getProjectListByAppUser,
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

  fastify.get("/app-user/projects/:sUserId", async function (request, reply) {
    try {
      const {sUserId}: any = request.params;

      const projectList = await getProjectListByAppUser(sUserId);
      reply.code(200).send(projectList);
    } catch (e) {
      console.error("My error code is", e);
      reply.code(500).send({ success: false });
    }
  });

  fastify.get("/all/projects", async function (request, reply) {
    try {
      const projects = await getAllProjects();
      reply.code(200).send(projects);
    } catch (e) {
      console.error("My error code is", e);
      reply.code(500).send({ success: false });
    }
  });

  fastify.post(
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

  fastify.delete("/remove/web-user/:suserId/:email", async function (request, reply) {
    const { authorization } = request.headers;
    if (!authorization) reply.code(500).send({ success: false });
    const token = authorization?.split(" ")[1] || "";

    const { roles }: any = getVerifiedUser(token);

    if (!roles.includes("ROLE_ADMIN")) reply.code(500).send({ success: false });

    try {
      const { suserId, email }: any = request.params;

      const user = await deleteOdkWebUser(suserId, email);
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
