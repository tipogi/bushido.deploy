FROM node:16.17.0-alpine3.16 as development

# Install tini
RUN apk add --no-cache tini

# Install globally some libraries to fix the errors that throws pm2 while is installing
#RUN npm install uuid fsevents@latest -f -g --save-optional
# Install package manager to manage the core
RUN npm install uuid fsevents@latest pm2 -f --save-optional -g

# set working directory
WORKDIR /app
# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# Install node modules
COPY core /app

# Install all the service node dependencies
RUN npm install

COPY init.sh /app/

## Docker health check
HEALTHCHECK --interval=300s --timeout=15s --start-period=20s --retries=3 \
            CMD curl http://bushido-api:4000/api/healthcheck

# Control the SIGTERM of the process with tini
# INFO: It will wait for it to exit all the while 
# reaping zombies and performing signal forwarding.
ENTRYPOINT ["/sbin/tini", "--"]
# Execute the script which will launch the application. That command will exec inside the container
CMD ["/bin/sh", "init.sh"]