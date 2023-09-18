import { UserOdkMappingInterface } from "../schema/suser-odk-mapping.schema";
import {
  axCreateAppUser,
  axCreateWebUser,
  axGetAllProjects,
  axGetAllSubmissionsByForm,
  axGetAppUserByEmail,
  axGetllAppUser,
  axGetllUser,
  axGetWebUserByEmail,
  axRemoveAppUser,
  axRemoveWebUser,
  axUpdateWebUserDisplayName} from "../services/odk.service";
import {
  createOdkUserMapping,
  deleteOdkAppUserMappings,
  deleteOdkWebUserMappings,
  getAllAppUserBySuserId,
  getOdkAppUserMappingsBySuserId,
  getOdkWebUserMappingsBySuserId
} from "../services/suser-odk-mapping.service";
import getQRSVG from "../utils/qrcode";

export interface OdkUserInterface {
  sUserId: number;
  email: string;
  username: string;
  projectId?: string;
  password: string;
}

export interface OdkProjectInterface {
  id: number;
  name: string;
  description: string;
  keyId: number;
  archived: boolean;
}

// TODO:need to add global error handling
// TODO:complete the mirgation to use prisma client
// https://www.prisma.io/docs/getting-started/setup-prisma/add-to-existing-project/relational-databases/introspection-typescript-postgres
// TODO:SONAR cloud

export const createOdkUser = async (createOdkUser: OdkUserInterface) => {
  const { email, projectId, sUserId, username } = createOdkUser;
  if (projectId) {
    let user = await axGetAppUserByEmail(`${username}-suser${sUserId}`, Number(projectId), false);
    // check with mapping table as well if suserID has has the project mapped
    if (user?.token) {
      throw new Error(`User already present for ${email} and projectId ${projectId}`);
    }

    user = await axCreateAppUser(`${username}-suser${sUserId}`, Number(projectId));

    if (user) {
      const payload: UserOdkMappingInterface = {
        s_user_id: sUserId,
        app_user_id: user.id,
        project_id: Number(projectId)
      };
      const mapping = await createOdkUserMapping(payload);
      if (mapping) return user;
    }
  } else {
    let user = await axGetWebUserByEmail(`${username}-suser${sUserId}`);

    if (user && user.length > 0) {
      throw new Error(`User already present for username ${email}`);
    }

    user = await axCreateWebUser(createOdkUser);
    user = await axUpdateWebUserDisplayName(user.id, createOdkUser);

    if (user) {
      const payload = {
        s_user_id: sUserId,
        web_user_id: user.id
      };
      const mapping = await createOdkUserMapping(payload);
      if (mapping) return user;
    }
    return;
  }
};

export const getIsWebUer = async (sUserId: string) => {
  const userOdkMapping = await getOdkWebUserMappingsBySuserId(Number(sUserId));

  return userOdkMapping?.length > 0 ? true : false;
};

export const getAllOdkUser = async () => {
  try {
    const appUser: OdkUserInterface[] = await axGetllAppUser();
    const webUser = await axGetllUser();
    return [...webUser, ...appUser];
  } catch (error) {
    console.error("Unable to get all user", error);
    throw new Error("Unable to get all users");
  }
};

export const deleteOdkWebUser = async (sUserId: number, userName: string) => {
  try {
    const user = await axGetWebUserByEmail(userName);

    const userOdkMapping = await getOdkWebUserMappingsBySuserId(sUserId);
    if (user?.length <= 0 && userOdkMapping.length <= 0) {
      throw new Error("Web user does not exsist");
    }
    const isDeleted = await axRemoveWebUser(user[0].id);

    if (isDeleted) {
      const data = await deleteOdkWebUserMappings(userOdkMapping[0].id);
      if (data) {
        // eslint-disable-next-line @typescript-eslint/no-unused-vars
        const { token, ...responsePayload } = user[0];
        return { ...responsePayload };
      }
    } else {
      throw new Error("Unable to delete web users");
    }
  } catch (error) {
    throw new Error(`Unable to delete web users`);
  }
};

export const deleteOdkAppUser = async (userName: string, projectId: string) => {
  try {
    const user = await axGetAppUserByEmail(userName, Number(projectId), false);
    const appUserOdkMapping: any[] = await getOdkAppUserMappingsBySuserId(
      user.id,
      Number(projectId)
    );

    if (user?.length <= 0 && appUserOdkMapping?.length <= 0)
      throw new Error("App User does not exsist");
    const isDeleted = await axRemoveAppUser(user.id, projectId);

    if (isDeleted) {
      const data = await deleteOdkAppUserMappings(Number(appUserOdkMapping[0].id));

      if (data) {
        // eslint-disable-next-line @typescript-eslint/no-unused-vars
        const { token, ...responsePayload } = user;
        return { ...responsePayload };
      }
    } else {
      throw new Error("Unable to delete app users");
    }
  } catch (error) {
    throw new Error("Unable to delete app users");
  }
};

export const getAppUserQrCodeByProjectId = async (
  email: string,
  projectId: number,
  xmlFormId: number
) => {
  try {
    const appUser = await axGetAppUserByEmail(email, projectId, true, xmlFormId);
    return getQRSVG(appUser);
  } catch (error) {
    throw new Error("Unable to get app users qr code");
  }
};

export const getAllProjects = async () => {
  try {
    const projects = await axGetAllProjects();
    return projects;
  } catch (error) {
    throw new Error("Unable to get all projects");
  }
};

export const getProjectListByAppUser = async (suserId: string) => {
  try {
    const odkUserMapping = await getAllAppUserBySuserId(Number(suserId));
    const projectList: OdkProjectInterface[] = await axGetAllProjects();
    if (odkUserMapping?.length && projectList?.length) {
      const results = projectList.filter((project: OdkProjectInterface) =>
        odkUserMapping.some((item) => Number(item.project_id) == project.id)
      );
      return results;
    } else {
      throw new Error(`Project not found for the given user id ${suserId}`);
    }
  } catch (error) {
    throw new Error(`Project not found for the given user id ${suserId}`);
  }
};

export const getAllSubmissionByForm = async (
  projectId: string,
  formName: string,
  isDraft?: boolean
) => {
  try {
    const submissions = await axGetAllSubmissionsByForm(Number(projectId), formName, isDraft);
    return submissions;
  } catch (error) {
    throw new Error("Unable to get all projects");
  }
};
