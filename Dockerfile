# FROM node:lts-slim as builder

# LABEL version="2.0.0"
# LABEL description="Example Fastify (Node.js) webapp Docker Image"
# LABEL maintainer="Sandro Martini <sandro.martini@gmail.com>"

# # update packages, to reduce risk of vulnerabilities
# RUN apt-get update && apt-get upgrade -y && apt-get autoclean -y && apt-get autoremove -y

# # set a non privileged user to use when running this image
# RUN groupadd -r nodejs && useradd -g nodejs -s /bin/bash -d /home/nodejs -m nodejs
# USER nodejs
# # set right (secure) folder permissions
# RUN mkdir -p /home/nodejs/app/node_modules
# RUN chown -R nodejs:nodejs /home/nodejs/app

# WORKDIR /home/nodejs/app

# # set default node env
# ARG NODE_ENV=development
# # ARG NODE_ENV=production
# # to be able to run tests (for example in CI), do not set production as environment
# ENV NODE_ENV=${NODE_ENV}

# ENV NPM_CONFIG_LOGLEVEL=warn

# # copy project definition/dependencies files, for better reuse of layers
# COPY package*.json ./

# # copy stuff required by prepublish (postinstall)
# COPY .snyk ./

# # install dependencies here, for better reuse of layers
# RUN npm ci && npm cache clean --force

# # copy all sources in the container (exclusions in .dockerignore file)
# COPY --chown=nodejs:nodejs . .

# # build/pack binaries from sources

# # This results in a single layer image
# # FROM node:lts-alpine AS release
# # COPY --from=builder /dist /dist

# # exposed port/s
# EXPOSE ${PORT}

# # # add an healthcheck, useful
# # # healthcheck with curl, but not recommended
# # # HEALTHCHECK CMD curl --fail http://localhost:8000/health || exit 1
# # # healthcheck by calling the additional script exposed by the plugin
# # HEALTHCHECK --interval=30s --timeout=10s --start-period=5s CMD npm run healthcheck-manual

# # ENTRYPOINT [ "node" ]
# # CMD [ "npm", "start" ]
# CMD [ "node", "./src/index" ]

# # end.


FROM node:14


# add user to run server
# RUN addgroup -g 1001 -S nodejs
# RUN adduser -S apiserver -u 1001

# Create Directory for the Container
WORKDIR /usr/src/app
# Only copy the package.json file to work directory
COPY package.json .
# Install all Packages
RUN npm install
# Copy all other source code to work directory
COPY . .
# # TypeScript
# RUN npm run compile


# Start
CMD [ "npm", "run", "start" ]

# USER apiserver
EXPOSE ${PORT}