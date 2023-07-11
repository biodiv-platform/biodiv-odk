import { buildJsonSchemas } from "fastify-zod";
import { z } from "zod";

const userOdkMappingCore = {
  id: z.number().optional(),
  s_user_id: z.number(),
  app_user_id: z.number().optional(),
  project_id: z.number().optional(),
  web_user_id: z.number().optional()
};
const userOdkMapping = z.object({
  ...userOdkMappingCore
});

export type UserOdkMappingInterface = z.infer<typeof userOdkMapping>;

export const { schemas: userSchemas, $ref } = buildJsonSchemas({
  userOdkMapping
});
