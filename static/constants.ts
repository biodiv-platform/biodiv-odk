// @ts-check

export const REQ_OPTS = {
  auth: {
    username: process.env.ODK_ADMIN_USERNAME || "",
    password: process.env.ODK_ADMIN_PASSWORD || ""
  }
};

export const ODK_OPTS = {
  URL: process.env.ODK_URL
};
