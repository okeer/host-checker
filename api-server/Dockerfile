ARG NODE_ENV=production

FROM node:10.16.3 AS dev-modules

RUN mkdir -p /app
WORKDIR /app

COPY package.json ./

RUN npm install --quiet

FROM node:10.16.3 AS prod-modules

ARG NODE_ENV

RUN mkdir -p /app
WORKDIR /app

COPY package.json ./

RUN npm install --quiet

FROM node:10.16.3 AS builder

WORKDIR /app
COPY --from=dev-modules /app/node_modules ./node_modules
COPY . ./

RUN mkdir -p ./build && npm run build

FROM node:10.16.3-slim AS production

ARG NODE_ENV
ENV NODE_ENV=${NODE_ENV}

EXPOSE 3000

USER node
WORKDIR /app

COPY --from=prod-modules --chown=root:root /app/node_modules ./node_modules
COPY --from=builder --chown=root:root /app/build ./build
COPY package.json ./

CMD npm run dev
