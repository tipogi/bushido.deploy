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

# Installation scripts
echo "- Update all the repositories (1)"
echo "- Install npm packages and build the projects (2)"
echo "- Move the bundles to the right folders (3)"
read -p "Which option do you want to execute? " x

if [[ "$x" = "1" &&  $EUID -ne 0 ]]; then
  updateAllRepositories
elif [[ "$x" = "2" &&  $EUID -ne 0 ]]; then
  installNodeDependencies
else
  printImportantMessage "That option does not exist"
fi