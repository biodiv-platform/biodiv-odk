// @ts-check

import pako from "pako";
import QRCode from "qrcode-svg";

import { ODK_OPTS } from "../static/constants";

export const getQRSVG = ({ token, projectId, projectName }: any) => {
  const QRPayload = {
    general: {
      server_url: `${ODK_OPTS.URL}v1/key/${token}/projects/${projectId}`,
      form_update_mode: "match_exactly",
      autosend: "wifi_and_cellular"
    },
    project: { name: projectName },
    admin: {}
  };

  const qr = Buffer.from(
    String.fromCharCode(...pako.deflate(JSON.stringify(QRPayload))),
    "binary"
  ).toString("base64");

  return new QRCode(qr).svg();
};

export default getQRSVG;
