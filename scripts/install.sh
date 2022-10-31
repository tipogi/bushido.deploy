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
  npm install "${BUSHIDO_GUIDE_PATH}"
  printInsideBlockOutput "bushido.guide node_modules installed!"
  # Install bushido web server node modules
  npm install "${BUSHIDO_BACKEND_PATH}"
  printInsideBlockOutput "bushido.backend node_modules installed!"
  # Install bushido web server node modules
  npm install "${BUSHIDO_LIBRARY_ROOT_PATH}"
  printInsideBlockOutput "bushido.library node_modules installed!"
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