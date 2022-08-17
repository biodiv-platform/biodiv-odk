// @ts-check
const { ODK_OPTS, REQ_OPTS } = require("../static/constants");
const { http } = require("../utils/http");

const axGetAppUserByEmail = async (email, xmlFormId, projectId) => {
  const res = await http.get(
    `${ODK_OPTS.URL}v1/projects/${projectId}/app-users`,
    REQ_OPTS
  );

  // Creates app user if not exist
  let appUser = res.data.find((au) => au.token && au.displayName === email);
  if (!appUser) {
    appUser = await axCreateAppUser(email, projectId);
  }

  // Add permission if not exist
  await axAssignUserToForm(projectId, xmlFormId, appUser.id);

  const projectName = await axGetProjectName(projectId);

  return { ...appUser, projectName };
};

const axCreateAppUser = async (displayName, projectId) => {
  const res = await http.post(
    `${ODK_OPTS.URL}v1/projects/${projectId}/app-users`,
    { displayName },
    REQ_OPTS
  );

  return res.data;
};

const axAssignUserToForm = async (projectId, xmlFormId, appUserId) => {
  const formAccessList = await http.get(
    `${ODK_OPTS.URL}v1/projects/${projectId}/assignments/forms/app-user`,
    REQ_OPTS
  );

  const hasAccess = formAccessList.data.some(
    (access) => access.xmlFormId === xmlFormId && access.actorId === appUserId
  );

  if (!hasAccess) {
    await http.post(
      `${ODK_OPTS.URL}v1/projects/${projectId}/forms/${xmlFormId}/assignments/2/${appUserId}`,
      {},
      REQ_OPTS
    );
  }
};

const axGetProjectName = async (projectId) => {
  const res = await http.get(
    `${ODK_OPTS.URL}v1/projects/${projectId}`,
    REQ_OPTS
  );

  return res.data.name;
};

module.exports = {
  axAssignUserToForm,
  axCreateAppUser,
  axGetAppUserByEmail,
  axGetProjectName,
};
