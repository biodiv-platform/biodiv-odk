// @ts-check

const REQ_OPTS = {
  auth: {
    username: process.env.ODK_ADMIN_USERNAME,
    password: process.env.ODK_ADMIN_PASSWORD,
  },
};

const ODK_OPTS = {
  URL: process.env.ODK_URL,
};

module.exports = { REQ_OPTS, ODK_OPTS };
