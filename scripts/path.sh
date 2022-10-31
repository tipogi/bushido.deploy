# We have to set up the user home directory because when we run as a root
# the home directory is the root one
HOME_DIRECTORY=/home/bushido

# CLIENT path
WWW_PATH=/var/www
APP_FOLDER="${WWW_PATH}/bushido"

BUSHIDO_DEPLOY_GITHUB=https://github.com/tipogi/bushido.deploy.git
BUSHIDO_GUIDE_GITHUB=https://github.com/tipogi/bushido.guide.git
BUSHIDO_BACKEND_GITHUB=https://github.com/tipogi/bushido-backend.git
BUSHIDO_MARKET_GITHUB=https://github.com/tipogi/bushido.market.git
BUSHIDO_LIBRARY_GITHUB=https://github.com/tipogi/bushido.library.git

# DEPLOY path
BUSHIDO_HOME_PATH="${HOME_DIRECTORY}/www/bushido"
DEPLOY_PATH="${BUSHIDO_HOME_PATH}/bushido.deploy"

# FOLDERS
BUSHIDO_DOCKER_PATH="${DEPLOY_PATH}/docker"
BUSHIDO_SERVICES_PATH="${DEPLOY_PATH}/services"

# SERVICE paramethers
APP_PARAM_PATH="${BUSHIDO_SERVICES_PATH}/app"
DB_PARAM_PATH="${BUSHIDO_SERVICES_PATH}/bushido_db"
WEB_SERVER_PARAM_PATH="${BUSHIDO_SERVICES_PATH}/bushido_web_server"
LIBRARY_PARAM_PATH="${BUSHIDO_SERVICES_PATH}/library"
NOKYC_PARAM_PATH="${BUSHIDO_SERVICES_PATH}/noKYC_web_server"
TOR_PARAM_PATH="${BUSHIDO_SERVICES_PATH}/tor_proxy"

# CONTAINER layers
BUSHIDO_GUIDE_PATH="${BUSHIDO_DOCKER_PATH}/bushido.guide"
BUSHIDO_BACKEND_PATH="${BUSHIDO_DOCKER_PATH}/bushido.backend"
BUSHIDO_DDBB_PATH="${BUSHIDO_DOCKER_PATH}/bushido.backend/database"
BUSHIDO_WEB_SERVER_PATH="${BUSHIDO_DOCKER_PATH}/bushido.backend/src"
BUSHIDO_DEPLOY_WEB_SERVER_PATH="${BUSHIDO_DOCKER_PATH}/bushido.backend/deploy"
BUSHIDO_LIBRARY_REPO_PATH="${BUSHIDO_DOCKER_PATH}/bushido.library"
BUSHIDO_LIBRARY_ROOT_PATH="${BUSHIDO_DOCKER_PATH}/bushido.library/cli"
BUSHIDO_LIBRARY_PATH="${BUSHIDO_DOCKER_PATH}/bushido.library/cli/src"
BUSHIDO_MARKET_PATH="${BUSHIDO_DOCKER_PATH}/bushido.market"