import { UserOdkMappingInterface } from "../schema/suser-odk-mapping.schema";
import prisma from "../utils/prisma";

export const createOdkUserMapping = async (payload: UserOdkMappingInterface) => {
  return prisma.suserOdkMapping.create({
    data: { ...payload }
  });
};

export function getAllOdkUserMappings() {
  return prisma.suserOdkMapping.findMany();
}

export const getOdkWebUserMappingsBySuserId = async (userId: number) => {
  const data = await prisma.suserOdkMapping.findMany({
    where: {
      s_user_id: BigInt(userId),
      project_id: null
    }
  });
  return data;
};

export const getOdkAppUserMappingsBySuserId = async (appUserId: number, projectId: number) => {
  const data = await prisma.suserOdkMapping.findMany({
    where: {
      app_user_id: BigInt(appUserId),
      project_id: BigInt(projectId)
    }
  });
  return data;
};

export const deleteOdkAppUserMappings = async (odkMappingId: number) => {
  return await prisma.suserOdkMapping.delete({
    where: {
      id: odkMappingId
    }
  });
};

export const deleteOdkWebUserMappings = async (userId: any) => {
  try {
    return await prisma.suserOdkMapping.delete({
      where: {
        id: Number(userId)
      }
    });
  } catch (error) {
    return { error: `Mapping with ID ${userId} does not exist` };
  }
};
