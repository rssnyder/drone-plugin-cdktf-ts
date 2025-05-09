ARG TOFU="1.9.0"
ARG NODE="24"
ARG CDKTF="v0.20.12"

FROM ghcr.io/opentofu/opentofu:${TOFU} as tf

FROM node:${NODE}

ARG CDKTF

COPY --from=tf /usr/local/bin/tofu /usr/local/bin/tofu

RUN npm install --global cdktf-cli@${CDKTF}

COPY plugin.sh /usr/local/bin/plugin.sh

RUN chmod +x /usr/local/bin/plugin.sh

ENTRYPOINT ["/usr/local/bin/plugin.sh"]