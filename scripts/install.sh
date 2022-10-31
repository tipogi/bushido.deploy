#!/bin/bash

source color.sh
source path.sh

updateAllRepositories()
{
  printBlockStartOutput "Update application layer repositories"
  # Access to services folder and clone and delete all github 
  cd "$BUSHIDO_GUIDE_PATH"
  git pull "$BUSHIDO_GUIDE_GITHUB"
  printInsideBlockOutput "bushido.guide updated!"
  cd "$BUSHIDO_BACKEND_PATH"
  git pull "$BUSHIDO_BACKEND_GITHUB"
  printInsideBlockOutput "bushido.backend updated!"
  cd "$BUSHIDO_MARKET_PATH"
  git pull "$BUSHIDO_MARKET_GITHUB"
  printInsideBlockOutput "bushido.market updated!"
  cd "$BUSHIDO_LIBRARY_REPO_PATH"
  git pull "$BUSHIDO_LIBRARY_GITHUB"
  printInsideBlockOutput "bushido.library updated!"
}

installNodeDependencies() 
{
  printBlockStartOutput "Install some repositories node libraries to run the application"
  # Install client node modules
  cd "$BUSHIDO_GUIDE_PATH"
  npm install
  printInsideBlockOutput "bushido.guide node_modules installed!"
  npm run build
  printBlockFinishOutput "bushido.guide production build created!"
  # Install bushido web server node modules
  cd "$BUSHIDO_WEB_SERVER_PATH"
  npm install
  printInsideBlockOutput "bushido.backend node_modules installed!"
  npm run build
  printBlockFinishOutput "bushido.backend production build created!"
  # Install bushido web server node modules
  cd "$BUSHIDO_LIBRARY_ROOT_PATH"
  npm install
  printInsideBlockOutput "bushido.library node_modules installed!"
  npm run build
  printBlockFinishOutput "bushido.backend production build created!"
}

manageClientAppBundle() 
{
  highlightOutput $(whoami) ${EUID} "running the script and its id is"
  cd "$BUSHIDO_GUIDE_PATH"
  mv dist app
  mkdir -p "$APP_FOLDER"
  cp -r -v app /var/www/bushido/
  printBlockFinishOutput "bushido.guide application moved to www folder!"
}

manageCreatedBundles() 
{
  printInsideBlockOutput "Configure bushido web server container"
  cd "$BUSHIDO_BACKEND_PATH"
  # Create a folder to spin up the container
  mkdir deploy
  mv dist core
  mv -v core deploy/
  cp -v $(echo "${WEB_SERVER_PARAM_PATH}/.env") $(echo "${BUSHIDO_DEPLOY_WEB_SERVER_PATH}/core/") 
  cp -v $(echo "${WEB_SERVER_PARAM_PATH}/Dockerfile") $(echo "${BUSHIDO_DEPLOY_WEB_SERVER_PATH}/") 
  cp -v $(echo "${WEB_SERVER_PARAM_PATH}/init.sh") $(echo "${BUSHIDO_DEPLOY_WEB_SERVER_PATH}/")
  printBlockFinishOutput "bushido web server ready to spin up as container!"
}

# Installation scripts
printImportantMessage "In /var/www it has to be created bushido folder, if not we will not create app folder"
echo "- Update all the repositories (1)"
echo "- Install npm packages and build the projects (2)"
printImportantListPoint "Move client app the bundle. Attention: Here you have to run as a root user (3)"
echo "- Move the web server bundle (4)"
read -p "Which option do you want to execute? " x

if [[ "$x" = "1" &&  $EUID -ne 0 ]]; then
  updateAllRepositories
elif [[ "$x" = "2" &&  $EUID -ne 0 ]]; then
  installNodeDependencies
elif [[ "$x" = "3" &&  $EUID -ne 0 ]]; then
  manageClientAppBundle
elif [[ "$x" = "4" &&  $EUID -ne 0 ]]; then
  manageWebServerBundle
else
  printImportantMessage "That option does not exist"
fi