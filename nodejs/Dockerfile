FROM node:18-alpine
WORKDIR /usr/src/app

## Node Modules
ADD app/package*.json .
RUN npm install

## Copy source code for dev use
ADD app/src src

ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

## Open port 3000
EXPOSE 3000

## Start server
ENTRYPOINT ["node", "src/index.js"]