# BUSHIDO.GUIDE DEPLOYMENT

# SCRIPTS
Automatise application deploy. Pull services, create the bundle, configure the environments of each service and more
- **init.sh**: Pull repositories and add its own environment variables
- **update.sh**: Create the bundles and move to the containers location to spin up the application
- **color.sh**: Terminal coloring helper function
- **path.sh**: Path constants helper

# OS
Which packages needs that deployment to run in some VPS

# DOCKER
The application containers. After init all the scripts, we run these commands
```bash
# Build all the images
DOCKER_BUILDKIT=1 docker-compose build
# Spin up the container
docker-compose up
```