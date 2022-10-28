#!/bin/bash

source color.sh
source path.sh

#if [ "$#" -eq 2 ]; then
#    echo $1
#    echo $2
#    read -p "Would you like to init SecureDocumentSearch application? (Y or N): " x
#else
#    printBlockErrort "That script needs two arguments"
#    exit 1
#fi


createAllTheFolders() 
{
    echo ">> Create the folder to clone the projects and to compile the builds <<"
    mkdir -p "$BUSHIDO_HOME_PATH"
    mkdir -p "$APP_FOLDER"
}

cloneRepositories()
{
    printBlockStartOutput "Clone application layer repositories"
    # Access to bushido working directory and clone the deployment repository
    cd "$BUSHIDO_HOME_PATH"
    git clone "$BUSHIDO_DEPLOY_GITHUB"
    printInsideBlockOutput "bushido.deploy clonned!"
    # Access to services folder and clone and delete all github 
    cd "$BUSHIDO_DOCKER_PATH"
    git clone "$BUSHIDO_GUIDE_GITHUB"
    git clone "$BUSHIDO_BACKEND_GITHUB"
    # Change name to bushido backend repository
    mv bushido-backend bushido.backend
    mkdir -p "${BUSHIDO_WEB_SERVER_PATH}" 
    mkdir -p "${BUSHIDO_DDBB_PATH}"
    git clone "$BUSHIDO_MARKET_GITHUB"
    git clone "$BUSHIDO_LIBRARY_GITHUB"
    printInsideBlockOutput "bushido services clonned!"
    mkdir -p $(echo "${DOCKER_CONTAINER_PATH}/${APP_FOLDER}")
    printBlockFinishOutput "Repositories cloned in its path"
}

copyTheServicesParameters() 
{
    printBlockStartOutput "Copy environment or Dockerfiles files for each service"
    # Import client (app) environment files
    printInsideBlockOutput "copy client environment files..."
    cp -v $(echo "${APP_PARAM_PATH}/config.constants.ts") $(echo "${BUSHIDO_GUIDE_PATH}/src/constants")
    # Import ddbb (app) environment files
    printInsideBlockOutput "copy ddbb environment files..."
    cp -v $(echo "${DB_PARAM_PATH}/neo4j") $(echo "${BUSHIDO_DDBB_PATH}/")
    cp -v $(echo "${DB_PARAM_PATH}/.env") $(echo "${BUSHIDO_DDBB_PATH}/")
    # Import ddbb (app) environment files
    printInsideBlockOutput "copy bushido web server files..."
    cp -v $(echo "${WEB_SERVER_PARAM_PATH}/config") $(echo "${BUSHIDO_WEB_SERVER_PATH}/")
    printImportantMessage "DO NOT FORGET TO IMPORT .env, Dockerfile and init.sh after bundle creation"
    # Import bushido.library environment file
    printInsideBlockOutput "copy bushido.library environment files..."
    cp -v $(echo "${LIBRARY_PARAM_PATH}/config") $(echo "${BUSHIDO_LIBRARY_PATH}/")
     # Import bushido.market docker files
    printInsideBlockOutput "copy bushido.library docker files..."
    cp -v $(echo "${NOKYC_PARAM_PATH}/Dockerfile") $(echo "${BUSHIDO_MARKET_PATH}/etc/fastapi")
    cp -v $(echo "${TOR_PARAM_PATH}/Dockerfile") $(echo "${BUSHIDO_MARKET_PATH}/etc/tor")
    printBlockFinishOutput "Environment variables imported"
}

# Start building 
read -p "Would you like to init bushido.guide application? (Y or N): " x

if [[ "$x" = "y" &&  $EUID -ne 0 ]]; then
    highlightOutput $(whoami) ${EUID} "running the script and its id is"
    read -p "Do you want to clone or copy environment files? (clone or env): 
        NOTE: If you decide to copy environment files, first edit all the files acording the environment that you want to setdo not edit the environment files" y
    if [[ "$y" = "clone" &&  $EUID -ne 0 ]]; then
        createAllTheFolders
        cloneRepositories
    if [[ "$y" = "env" &&  $EUID -ne 0 ]]; then
        copyTheServicesParameters
else
    echo "- Check the file path constants (path.sh)"
    echo "- There is not any prior configuration just the pop-up to enter repository password"
    exit 1
fi