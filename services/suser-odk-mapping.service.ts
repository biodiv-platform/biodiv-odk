import { UserOdkMappingInterface } from "../schema/suser-odk-mapping.schema";
import prisma from "../utils/prisma";

export const createOdkUserMapping = async (data: UserOdkMappingInterface) => {
  return prisma.suserOdkMapping.create({
    data
  });
};

export function getAllOdkUserMappings() {
  return prisma.suserOdkMapping.findMany();
}

export const getOdkUserMappingsBySuserId = async (userId: any) => {
  try {
    return await prisma.suserOdkMapping.findUnique({
      where: { id: Number(userId) }
    });
  } catch (error) {
    return { error: `Mapping with ID ${userId} does not exist` };
  }
};

export const deleteOdkUserMappings = async (userId: any) => {
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
