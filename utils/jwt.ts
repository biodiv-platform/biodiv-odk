import jwt from "jsonwebtoken";

const salt: any = process.env.JWT_SALT || "";
const getVerifiedUser = (token: string) => {
  const decodedToken = jwt.verify(token, salt);
  return decodedToken;
};

export default getVerifiedUser;
