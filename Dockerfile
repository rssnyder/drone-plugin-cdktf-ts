ARG NODE="24"

FROM node:${NODE}

ARG CDKTF="v0.20.12"

RUN npm install --global cdktf-cli@${CDKTF}

COPY plugin.sh /usr/local/bin/plugin.sh

RUN chmod +x /usr/local/bin/plugin.sh

ENTRYPOINT ["/usr/local/bin/plugin.sh"]