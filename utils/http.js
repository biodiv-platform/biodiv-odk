const axios = require("axios");

const defaultHeaders = {
  headers: {
    post: { "Content-Type": "application/json" },
    put: { "Content-Type": "application/json" },
  },
};

const http = axios.create(defaultHeaders);

module.exports = { http };
