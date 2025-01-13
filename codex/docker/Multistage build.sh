# docker, multi stage, multi-stage

# This is an example for a nextjs app

FROM node:23-bookwork-slim AS base

RUN <<EOF
    apt-get update -qq
    apt-get upgrade -qq &&
    apt-get install -qq -y --no-install-recommends sqlite3 make
EOF

RUN npm i -g pnpm


# --- image for installing node dependencies ----- #
FROM base AS dependencies

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm i --frozen-lockfile


# --- image for building app --------------------- #

FROM base AS build
WORKDIR /app
COPY --from=dependencies /app/node_modules ./node_modules
COPY . .

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1
RUN make


# --- final image -------------------------------- #

FROM base AS final
WORKDIR /app

LABEL maintainer="tony.fischetti@gmail.com"

ENV TERM=screen-256color
ENV LANG=C.UTF-8
ENV NODE_ENV=production
# ENV SHELL=/usr/bin/zsh

ARG USERNAME=marvin
ARG USER_UID=1001
ARG USER_GID=$USER_UID

# create non-root user
RUN <<EOF
    groupadd --gid $USER_GID $USERNAME &&
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME
EOF

RUN mkdir .next

COPY --from=build /app/public ./public
COPY --from=build /app/.next/standalone ./
COPY --from=build /app/.next/static ./.next/static

RUN chown -R $USERNAME:$USERNAME .next

USER $USERNAME
EXPOSE 3000

ENV NEXT_TELEMETRY_DISABLED=1

CMD HOSTNAME="0.0.0.0" node server.js
# CMD bash

