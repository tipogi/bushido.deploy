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
    mkdir -p "$BUSHIDO_PATH"
}

cloneRepositories()
{
    printBlockStartOutput "Clone application layer repositories"
    cd "$BUSHIDO_PATH"
    git clone https://github.com/tipogi/bushido.guide.git
    git clone https://github.com/tipogi/bushido-backend.git
    git clone https://github.com/tipogi/bushido.market.git
    git clone https://github.com/tipogi/bushido.library.git
    printBlockStartOutput "Application containers spin up folder, we will run here docker-compose"
    # Clone application container
    cd "$WWW_PATH"
    git clone https://IkusiMakusi@bitbucket.org/IkusiMakusi/bushido_docker.git
    mv bushido_docker "$CONTAINER_FOLDER_NAME"
    mkdir -p $(echo "${DOCKER_CONTAINER_PATH}/${SERVER_FOLDER}")
    printBlockFinishOutput "Repositories cloned in its path"
}

copyTheEnvironmentVariables() 
{
    printBlockStartOutput "Copy environment variables for each service"
    # Import client (app) environment files
    printInsideBlockOutput "copy frontend environment files..."
    mkdir -p $(echo "${BUSHIDO_PATH}/${CLIENT_ENV}") && cp -v -r $(echo "${ENV_PATH}/${CLIENT_ENV}/*") $(echo "${BUSHIDO_PATH}/${CLIENT_ENV}/")
    # Import backend environment files
    printInsideBlockOutput "copy backend environment files..."
    cp -v $(echo "${ENV_PATH}/${SERVER_ENV}/*") $(echo "${BUSHIDO_PATH}/${SERVER_ENV}/")
    # Import library environment files
    printInsideBlockOutput "copy library environment files..."
    cp -v $(echo "${ENV_PATH}/${LIBRARY_ENV}/*") $(echo "${BUSHIDO_PATH}/${LIBRARY_ENV}/")
    # Import in the container the environment files
    #printInsideBlockOutput "copy docker container environment files..."
    #mkdir -p $(echo "${DOCKER_CONTAINER_PATH}/${CORE_FOLDER}/") && cp -v $(echo "${ENV_PATH}/${BACKEND_FILE}/.env") $(echo "${DOCKER_CONTAINER_PATH}/${CORE_FOLDER}/")
    #cp -v $(echo "${ENV_PATH}/${APP_CONTAINER}") $(echo "${DOCKER_CONTAINER_PATH}/")
    printBlockFinishOutput "Environment variables imported"
}

# Start building 
read -p "Would you like to init bushido.guide application? (Y or N): " x

if [[ "$x" = "y" &&  $EUID -ne 0 ]]; then
    highlightOutput $(whoami) ${EUID} "running the script and its id is"
    createAllTheFolders
    cloneRepositories
    copyTheEnvironmentVariables
else
    echo "- Check the file path constants (path.sh)"
    echo "- There is not any prior configuration just the pop-up to enter repository password"
    exit 1
fi