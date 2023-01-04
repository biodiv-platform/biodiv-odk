import JWTDecode from "jwt-decode";

const getVerifiedUser = (token: string) => {
  const decodedToken: any = JWTDecode(token);
  return decodedToken;
};

export default getVerifiedUser;
