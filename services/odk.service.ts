// @ts-check
import { ODK_OPTS, REQ_OPTS } from "../static/constants";
import http from "../utils/http";

export const axGetAppUserByEmail = async (email: string, xmlFormId: number, projectId: number) => {
  const res = await http.get(`${ODK_OPTS.URL}v1/projects/${projectId}/app-users`, REQ_OPTS);

  // Creates app user if not exist
  let appUser = res.data.find((au: any) => au.token && au.displayName === email);
  if (!appUser) {
    appUser = await axCreateAppUser(email, projectId);
  }

  // Add permission if not exist
  await axAssignUserToForm(projectId, xmlFormId, appUser.id);

  const projectName = await axGetProjectName(projectId);

  return { ...appUser, projectName };
};

export const axGetllAppUser = async () => {
  const res = await http.get(`${ODK_OPTS.URL}v1/projects/1/app-users`, REQ_OPTS);

  return res.data;
};

export const axCreateAppUser = async (displayName: string, projectId: number) => {
  const res = await http.post(
    `${ODK_OPTS.URL}v1/projects/${projectId}/app-users`,
    { displayName },
    REQ_OPTS
  );

  return res.data;
};

export const axAssignUserToForm = async (
  projectId: number,
  xmlFormId: number,
  appUserId: number
) => {
  const formAccessList = await http.get(
    `${ODK_OPTS.URL}v1/projects/${projectId}/assignments/forms/app-user`,
    REQ_OPTS
  );

  const hasAccess = formAccessList.data.some(
    (access: any) => access.xmlFormId === xmlFormId && access.actorId === appUserId
  );

  if (!hasAccess) {
    await http.post(
      `${ODK_OPTS.URL}v1/projects/${projectId}/forms/${xmlFormId}/assignments/2/${appUserId}`,
      {},
      REQ_OPTS
    );
  }
};

export const axGetProjectName = async (projectId: number) => {
  const res = await http.get(`${ODK_OPTS.URL}v1/projects/${projectId}`, REQ_OPTS);

  return res.data.name;
};
