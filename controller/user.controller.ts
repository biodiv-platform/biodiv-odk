import { FastifyReply, FastifyRequest } from "fastify";

import { UserOdkMappingInterface } from "../schema/suser-odk-mapping.schema";
import { axGetllAppUser, axGetllUser } from "../services/odk.service";

interface OdkUserInterface {
  createdAt: string;
  displayName: string;
  id: number;
  type: string;
  updatedAt: string;
  deletedAt?: string;
  email: string;
}
interface OdkAppUser extends OdkUserInterface {
  projectId: string;
  token: string;
}

// TODO:need to add global error handling
// TODO:complete the mirgation to use prisma client
// https://www.prisma.io/docs/getting-started/setup-prisma/add-to-existing-project/relational-databases/introspection-typescript-postgres
// TODO:SONAR cloud

export const createOdkUser = async () => {
  // check userexsist not in mapping table and user table
  // create user if appuser else web user
  // create mapping odk user
  // return usr data
  return;
};

export const getAllOdkUser = async () => {
  try {
    const appUser: OdkUserInterface[] = await axGetllAppUser();
    const webUser: OdkAppUser[] = await axGetllUser();
    return [...webUser, ...appUser];
  } catch (error) {
    console.error("Unble to get all user", error);
    throw new Error("Unbale to get all users");
  }
};

export const deleteOdkUser = async () => {
  return;
};
export const getAppUserQrCodeByProjectId = async () => {
  return;
};
