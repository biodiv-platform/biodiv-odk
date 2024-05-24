// @ts-check
import { DOMParser } from "xmldom"; // Importing DOMParser from xmldom

import { OdkUserInterface } from "../controller/odk.controller";
import { ODK_OPTS, REQ_OPTS } from "../static/constants";
import http from "../utils/http";

export const axGetAppUserByEmail = async (
  userName: string,
  projectId: number,
  canCreate: boolean,
  xmlFormId?: number
) => {
  const res = await http.get(`${ODK_OPTS.URL}v1/projects/${projectId}/app-users`, REQ_OPTS);

  // Creates app user if not exist
  let appUser = res.data.find((au: any) => au.token && au.displayName === userName);
  if (!appUser && canCreate) {
    appUser = await axCreateAppUser(userName, projectId);
  }

  if (canCreate && xmlFormId) {
    // Add permission if not exist
    await axAssignUserToForm(projectId, xmlFormId, appUser.id);
  }

  const projectName = await axGetProjectName(projectId);

  return { ...appUser, projectName };
};

export const axGetWebUserByEmail = async (userName: string) => {
  const res = await http.get(`${ODK_OPTS.URL}v1/users?`, REQ_OPTS);
  let data = res.data;
  if (userName) {
    data = data.filter((item: any) => item.displayName == userName);
  }
  return data;
};

export const axGetllAppUser = async () => {
  const res = await http.get(`${ODK_OPTS.URL}v1/projects/1/app-users`, REQ_OPTS);

  return res.data;
};

export const axGetAllProjects = async () => {
  const res = await http.get(`${ODK_OPTS.URL}v1/projects`, REQ_OPTS);
  return res.data;
};

export const axGetllUser = async () => {
  const res = await http.get(`${ODK_OPTS.URL}v1/users`, REQ_OPTS);

  return res.data;
};

export const axCreateWebUser = async (payload: OdkUserInterface) => {
  const res = await http.post(
    `${ODK_OPTS.URL}v1/users`,
    { email: payload.email, password: payload.password },
    REQ_OPTS
  );

  return res.data;
};

export const axUpdateWebUserDisplayName = async (webUserId: string, payload: OdkUserInterface) => {
  const { sUserId, username } = payload;
  const res = await http.patch(
    `${ODK_OPTS.URL}v1/users/${webUserId}`,
    { email: payload.email, displayName: `${username}-suser${sUserId}` },
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

export const axGetAllSubmissionsByForm = async (
  projectId: number,
  formName: string,
  isDraft?: boolean,
  gtDate?: string,
  geDate?: string,
  ltDate?: string,
  leDate?: string,
  reviewState?: string
) => {
  const filters = [];

  if (gtDate) filters.push(`__system/submissionDate gt ${gtDate}`);
  if (geDate) filters.push(`__system/submissionDate ge ${geDate}`);
  if (ltDate) filters.push(`__system/submissionDate lt ${ltDate}`);
  if (leDate) filters.push(`__system/submissionDate le ${leDate}`);
  reviewState
    ? filters.push(`__system/reviewState eq ${reviewState}`)
    : filters.push(`__system/reviewState ne 'rejected'`);

  const filterString = filters.join(" and ");

  const res = isDraft
    ? await http.get(
        `${ODK_OPTS.URL}v1/projects/${projectId}/forms/${formName}/draft.svc/Submissions`,
        REQ_OPTS
      )
    : await http.get(
        `${ODK_OPTS.URL}v1/projects/${projectId}/forms/${formName}.svc/Submissions${
          filterString ? `?$filter=${filterString}` : ""
        }`,
        REQ_OPTS
      );

  return res.data;
};

export const axGetAttachmentsByForm = async (
  projectId: number,
  xmlFormId: string,
  instanceId?: string,
  filename?: string
) => {
  const response = await http.get(
    `${ODK_OPTS.URL}v1/projects/${projectId}/forms/${xmlFormId}/submissions/${instanceId}/attachments/${filename}`,
    {
      ...REQ_OPTS,
      responseType: "arraybuffer"
    }
  );
  return response;
};

export const axGetEntitiesMetaData = async (projectId: number, name: string) => {
  const res = await http.get(
    `${ODK_OPTS.URL}v1/projects/${projectId}/datasets/${name}.svc/entities`,
    REQ_OPTS
  );
  return res.data;
};

export const axGetCreateEntityData = async (projectId: number, name: string, payload: any) => {
  const res = await http.post(
    `${ODK_OPTS.URL}v1/projects/${projectId}/datasets/${name}/entities`,
    payload,
    REQ_OPTS
  );
  return res.data;
};

export const axPatchSubmissionData = async (
  projectId: number,
  xmlFormId: string,
  instanceId: string,
  payload: any
) => {
  const res = await http.patch(
    `${ODK_OPTS.URL}v1/projects/${projectId}/forms/${xmlFormId}/submissions/${instanceId}`,
    payload,
    REQ_OPTS
  );
  return res.data;
};

interface GeoJSON {
  type: string;
  coordinates: number[][][];
}

export const axgetSubmissionLocationData = async (
  projectId: number,
  xmlFormId: string,
  instanceId: string
) => {
  const res = await http.get(
    `${ODK_OPTS.URL}v1/projects/${projectId}/forms/${xmlFormId}/submissions/${instanceId}.xml`,
    REQ_OPTS
  );

  const xmlData = res.data;
  const parser = new DOMParser();
  const xmlDoc = parser.parseFromString(xmlData, "application/xml");

  const farmPlots = xmlDoc.getElementsByTagName("farm_plot");

  const locations: GeoJSON = {
    type: "Polygon",
    coordinates: []
  };

  for (let i = 0; i < farmPlots.length; i++) {
    const locationString = farmPlots[i].getElementsByTagName("location")[0].textContent;
    if (locationString) {
      const coordinates = locationString.split(";").map((coords) => {
        const [lat, lon] = coords.split(" ");
        return [parseFloat(lon), parseFloat(lat)];
      });

      if (
        coordinates.length > 0 &&
        (coordinates[0][0] !== coordinates[coordinates.length - 1][0] ||
          coordinates[0][1] !== coordinates[coordinates.length - 1][1])
      ) {
        coordinates.push(coordinates[0]);
      }

      locations.coordinates.push(coordinates);
    }
  }

  return locations;
};
