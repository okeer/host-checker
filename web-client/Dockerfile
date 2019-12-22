FROM node:10.16.3 AS builder

RUN mkdir /app
WORKDIR /app

COPY . ./
RUN npm install && yarn build

FROM nginx:stable-alpine as web

COPY --from=builder --chown=root:root /app/build /usr/share/nginx/html