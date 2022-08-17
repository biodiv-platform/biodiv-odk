// @ts-check

const { getVerifiedUser } = require("../../../../../../utils/jwt");
const { axGetAppUserByEmail } = require("../../../../../../services/odk.service");
const { getQRSVG } = require("../../../../../../utils/qrcode");

module.exports = async function (fastify, opts) {
  fastify.get("/", async function (request, reply) {
    const { xmlFormId, projectId = 1, BAToken } = request.query;
    const user = getVerifiedUser(request.cookies.BAToken || BAToken);

    try {
      if (user.email && xmlFormId) {
        const appUser = await axGetAppUserByEmail(
          user.email,
          xmlFormId,
          projectId
        );

        reply.header("Content-Type", "image/svg+xml");
        reply.send(getQRSVG(appUser));
      }
    } catch (e) {
      console.error(e);
      reply.code(500).send({ success: false });
    }
  });
};
