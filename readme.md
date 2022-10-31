# Deployment of bushido.guide

# Scripts
Automatise application deploy. Pull services, create the bundle, configure the environments of each service and more
- **init.sh**: Pull repositories and add its own environment variables. Environment files to edit:
  - app/config.constants.ts
  - bushido_db/.env
  - bushido_web_server/config/environment/**wished_env.yml** *(for example: production.yml)*
  - bushido_web_server/config/external_connections.ts (for example: production.yml)
  - bushido_web_server/.env ( the environment name has to be the same name of yml but without extension)
  - library/config/environment/**wished_env.yml** *(for example: production.yml)*
  - library/.env  ( the environment name has to be the same name of yml but without extension)
- **update.sh**: Create the bundles and move to the containers location to spin up the application
- **color.sh**: Terminal coloring helper function
- **path.sh**: Path constants helper

# OS
Which packages needs that deployment to run in some VPS

# Docker
The application containers. After init all the scripts, we run these commands
```bash
# Build all the images
DOCKER_BUILDKIT=1 docker-compose build
# Spin up the container
docker-compose up
```