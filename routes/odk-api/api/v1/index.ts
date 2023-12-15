// @ts-check
import { FastifyInstance, FastifyRequest } from "fastify";

import {
  createEntityData,
  createOdkUser,
  deleteOdkAppUser,
  deleteOdkWebUser,
  getAllOdkUser,
  getAllProjects,
  getAllSubmissionByForm,
  getAttachements,
  getEntitiesMetaData,
  getIsWebUer,
  getProjectListByAppUser,
  OdkUserInterface,
  patchSubmissionMetaData
} from "../../../../controller/odk.controller";
import { axGetAppUserByEmail } from "../../../../services/odk.service";
import getVerifiedUser from "../../../../utils/jwt";
import { imageExtensions } from "../../../../utils/media";
import getQRSVG from "../../../../utils/qrcode";

export default async function (fastify: FastifyInstance) {
  fastify.get("/user/all", async function (request, reply) {
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
      const { sUserId }: any = request.params;

      const projectList = await getProjectListByAppUser(sUserId);
      reply.code(200).send(projectList);
    } catch (e) {
      console.error("My error code is", e);
      reply.code(500).send({ success: false });
    }
  });

  fastify.get("/is-web-user/:sUserId", async function (request, reply) {
    try {
      const { sUserId }: any = request.params;

      const projectList = await getIsWebUer(sUserId);
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

  fastify.get("/app-user/qr-code/:userName/:projectId", async function (request: any, reply) {
    const { userName, projectId }: any = request.params;

    try {
      if (userName && projectId) {
        const appUser = await axGetAppUserByEmail(userName, projectId, false);

        reply.header("Content-Type", "image/svg+xml");
        reply.send(getQRSVG(appUser));
      }
    } catch (e) {
      console.error(e);
      reply.code(500).send({ success: false });
    }
  });

  fastify.delete("/remove/web-user/:suserId/:userName", async function (request, reply) {
    const { authorization } = request.headers;
    if (!authorization) reply.code(500).send({ success: false });
    const token = authorization?.split(" ")[1] || "";

    const { roles }: any = getVerifiedUser(token);

    if (!roles.includes("ROLE_ADMIN")) reply.code(500).send({ success: false });

    try {
      const { suserId, userName }: any = request.params;

      const user = await deleteOdkWebUser(suserId, userName);
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

  fastify.get("/projects/:projectId/forms/:formName/submissions", async function (request, reply) {
    try {
      const { projectId, formName }: any = request.params;
      const { isDraft = false, gtDate, geDate, ltDate, leDate, reviewState }: any = request.query;

      const submissions = await getAllSubmissionByForm(
        projectId,
        formName,
        isDraft,
        gtDate,
        geDate,
        ltDate,
        leDate,
        reviewState
      );
      reply.code(200).send(submissions);
    } catch (e) {
      console.error("My error code is", e);
      reply.code(500).send({ success: false });
    }
  });

  fastify.get(
    "/projects/:projectId/forms/:xmlFormId/submissions/:instanceId/attachments/:filename",
    async function (request, reply) {
      try {
        const { projectId, xmlFormId, instanceId, filename }: any = request.params;
        const submissions = await getAttachements(projectId, xmlFormId, instanceId, filename);
        const fileExtension = filename.split(".").pop()?.toLowerCase();
        let contentType = "application/octet-stream";
        if (fileExtension && imageExtensions[fileExtension]) {
          contentType = imageExtensions[fileExtension];
        }
        reply.header("Content-Type", contentType);
        reply.code(200).send(submissions.data);
      } catch (e) {
        console.error("My error code is", e);
        reply.code(500).send({ success: false });
      }
    }
  );

  fastify.get("/projects/:projectId/entityData/:name", async function (request, reply) {
    try {
      const { projectId, name }: any = request.params;

      const entities = await getEntitiesMetaData(projectId, name);
      reply.code(200).send(entities);
    } catch (e) {
      console.error("My error code is", e);
      reply.code(500).send({ success: false });
    }
  });

  fastify.post("/projects/:projectId/create/entityData/:name", async function (request, reply) {
    try {
      const { projectId, name }: any = request.params;
      const payload = request.body;

      const entities = await createEntityData(projectId, name, payload);
      reply.code(200).send(entities);
    } catch (e) {
      console.error("My error code is", e);
      reply.code(500).send({ success: false });
    }
  });

  fastify.patch(
    "/projects/:projectId/forms/:xmlFormId/submissions/:instanceId",
    async function (request, reply) {
      try {
        const { projectId, xmlFormId, instanceId }: any = request.params;
        const payload = request.body;

        const submission = await patchSubmissionMetaData(projectId, xmlFormId, instanceId, payload);
        reply.code(200).send(submission);
      } catch (e) {
        console.error("My error code is", e);
        reply.code(500).send({ success: false });
      }
    }
  );
}
