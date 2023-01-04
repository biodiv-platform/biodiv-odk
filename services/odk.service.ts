// @ts-check
import { OdkUserInterface } from "../controller/odk.controller";
import { ODK_OPTS, ODK_USER_CREDENTIALS, REQ_OPTS } from "../static/constants";
import http from "../utils/http";

export const axGetAppUserByEmail = async (
  email: string,
  projectId: number,
  canCreate: boolean,
  xmlFormId?: number
) => {
  const res = await http.get(`${ODK_OPTS.URL}v1/projects/${projectId}/app-users`, REQ_OPTS);

  // Creates app user if not exist
  let appUser = res.data.find((au: any) => au.token && au.displayName === email);
  if (!appUser && canCreate) {
    appUser = await axCreateAppUser(email, projectId);
  }

  if (canCreate && xmlFormId) {
    // Add permission if not exist
    await axAssignUserToForm(projectId, xmlFormId, appUser.id);
  }

  const projectName = await axGetProjectName(projectId);

  return { ...appUser, projectName };
};

export const axGetWebUserByEmail = async (email: string) => {
  const res = await http.get(`${ODK_OPTS.URL}v1/users?`, REQ_OPTS);
  let data = res.data;
  if (email) {
    data = data.filter((item: any) => item.email == email);
  }
  return data;
};

export const axGetllAppUser = async () => {
  const res = await http.get(`${ODK_OPTS.URL}v1/projects/1/app-users`, REQ_OPTS);

  return res.data;
};

export const axGetllUser = async () => {
  const res = await http.get(`${ODK_OPTS.URL}v1/users`, REQ_OPTS);

  return res.data;
};

export const axCreateWebUser = async (payload: OdkUserInterface) => {
  const res = await http.post(
    `${ODK_OPTS.URL}v1/users`,
    { email: payload.email, password: ODK_USER_CREDENTIALS.PASSWORD },
    REQ_OPTS
  );

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

export const axRemoveWebUser = async (userId: string) => {
  return await http.delete(`${ODK_OPTS.URL}v1/users/${userId}`, REQ_OPTS);
};

export const axRemoveAppUser = async (userId: string, projectId: string) => {
  return await http.delete(`${ODK_OPTS.URL}v1/projects/${projectId}/app-users/${userId}`, REQ_OPTS);
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
