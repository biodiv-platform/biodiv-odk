import axios from "axios";
import https from "https";

const httpsAgent = new https.Agent({
  rejectUnauthorized: false // (NOTE: this will disable client verification)
});
const defaultHeaders = {
  headers: {
    "Content-Type": "application/json"
  },
  httpsAgent
};

const http = axios.create(defaultHeaders);

export default http;
