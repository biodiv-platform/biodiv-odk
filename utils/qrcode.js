// @ts-check

const pako = require("pako");
const QRCode = require("qrcode-svg");
const { ODK_OPTS } = require("../static/constants");

const getQRSVG = ({ token, projectId, projectName }) => {
  const QRPayload = {
    general: {
      server_url: `${ODK_OPTS.URL}v1/key/${token}/projects/${projectId}`,
      form_update_mode: "match_exactly",
      autosend: "wifi_and_cellular",
    },
    project: { name: projectName },
    admin: {},
  };

  const qr = Buffer.from(
    String.fromCharCode(...pako.deflate(JSON.stringify(QRPayload))),
    "binary"
  ).toString("base64");

  return new QRCode(qr).svg();
};

module.exports = { getQRSVG };
