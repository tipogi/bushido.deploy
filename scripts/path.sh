# We have to set up the user home directory because when we run as a root
# the home directory is the root one
HOME_DIRECTORY=/home/bushido

# Application layers
BUSHIDO_PATH="${HOME_DIRECTORY}"/www/bushido.guide
BUSHIDO_CLIENT_PATH="${SDS_PATH}/app"
BUSHIDO_SERVER_PATH="${SDS_PATH}/server"
BUSHIDO_MARKET_PATH="${SDS_PATH}/market"
BUSHIDO_LIBRARY_PATH="${SDS_PATH}/library"

# Container services
WWW_PATH=/var/www
CONTAINER_FOLDER_NAME=bushido
DOCKER_CONTAINER_PATH="${WWW_PATH}/${CONTAINER_FOLDER_NAME}"
APP_FOLDER=app
SERVER_FOLDER=server/nestJS
MARKET_FOLDER=bushido.market
LIBRARY_FOLDER=bushido.library

# Environment path
ENV_PATH="${BUSHIDO_PATH}"/env
# Client - app
CLIENT_ENV=app/src/constants
# Server - backend
SERVER_ENV=server/nestJS/src/config
# Bookmarks
LIBRARY_ENV=library/cli/src/config/environment
# Docker
DOCKER_CONTAINER_EN=docker/.env