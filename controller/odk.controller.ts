import { UserOdkMappingInterface } from "../schema/suser-odk-mapping.schema";
import {
  axCreateAppUser,
  axCreateWebUser,
  axGetAppUserByEmail,
  axGetllAppUser,
  axGetllUser,
  axGetWebUserByEmail,
  axRemoveAppUser,
  axRemoveWebUser
} from "../services/odk.service";
import {
  createOdkUserMapping,
  deleteOdkAppUserMappings,
  getOdkAppUserMappingsBySuserId,
  getOdkWebUserMappingsBySuserId
} from "../services/suser-odk-mapping.service";
import getQRSVG from "../utils/qrcode";

export interface OdkUserInterface {
  sUserId: number;
  email: string;
  username: string;
  projectId?: string;
}

// TODO:need to add global error handling
// TODO:complete the mirgation to use prisma client
// https://www.prisma.io/docs/getting-started/setup-prisma/add-to-existing-project/relational-databases/introspection-typescript-postgres
// TODO:SONAR cloud

export const createOdkUser = async (createOdkUser: OdkUserInterface) => {
  const { email, projectId, sUserId } = createOdkUser;
  if (projectId) {
    let user = await axGetAppUserByEmail(email, Number(projectId), false);
    if (user) {
      throw new Error(`User already present for ${email} and projectId ${projectId}`);
    }

    user = await axCreateAppUser(email, Number(projectId));

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
    let user = await axGetWebUserByEmail(email);
    if (user) {
      throw new Error(`User already present for username ${email}`);
    }

    user = await axCreateWebUser(email);

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

export const getAllOdkUser = async () => {
  try {
    const appUser: OdkUserInterface[] = await axGetllAppUser();
    const webUser = await axGetllUser();
    return [...webUser, ...appUser];
  } catch (error) {
    console.error("Unble to get all user", error);
    throw new Error("Unbale to get all users");
  }
};

export const deleteOdkWebUser = async (sUserId: number, email: string) => {
  try {
    const user = await axGetWebUserByEmail(email);
    const userOdkMapping = await getOdkWebUserMappingsBySuserId(sUserId);
    if (!user && userOdkMapping && !userOdkMapping.id) throw new Error("Web user does not exsist");
    const isDeleted = await axRemoveWebUser(user.id);

    if (isDeleted) {
      return await deleteOdkAppUserMappings(Number(userOdkMapping.id));
    } else {
      throw new Error("Unbale to delete web users");
    }
  } catch (error) {
    throw new Error("Unbale to delete web users");
  }
};

export const deleteOdkAppUser = async (userName: string, projectId: string) => {
  try {
    const user = await axGetAppUserByEmail(userName, Number(projectId), false);
    const appUserOdkMapping = await getOdkAppUserMappingsBySuserId(user.id, Number(projectId));

    if (!user && appUserOdkMapping && appUserOdkMapping.id)
      throw new Error("App User does not exsist");
    const isDeleted = await axRemoveAppUser(user.id, projectId);

    if (isDeleted) {
      return await deleteOdkAppUserMappings(Number(appUserOdkMapping.id));
    } else {
      throw new Error("Unbale to delete web users");
    }
  } catch (error) {
    throw new Error("Unbale to delete app users");
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
    throw new Error("Unbale to delete app users");
  }
};
