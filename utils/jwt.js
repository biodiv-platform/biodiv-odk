const jwt = require("jsonwebtoken");

const getVerifiedUser = (token) => {
  const decodedToken = jwt.verify(token, process.env.JWT_SALT);
  return decodedToken;
};

module.exports = { getVerifiedUser };
