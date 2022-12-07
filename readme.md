# Overview
Automatise bushido.guide deployment in a VPS

# Motivation
When we spin up the docker file (`docker-compose`), it builds four different containers: database (neo4j), [`bushido web server`](https://github.com/tipogi/bushido-backend) and market server and tor proxy from [bushido.market](https://github.com/tipogi/bushido.market)

![architecture](./docs/assets/arch.png)

The only container that external actors can access is `bushido web server` as a API endpoint and the rest of the containers access is restricted to the local docker network.

Also, it has another two services outside of the containers which have different responsabilities:
- `bushido.guide`: It is the client of the application and nginx delivers that files to the end-user
- [`bushido.library`](https://github.com/tipogi/bushido.library): Feeds the graph database with topics and domains

> When we want to use `bushido.library`, we have to open the Neo4J ports to localhost because by default the ports are open inside of the container

## Folders
The repository has different folders with some utility in the process of deploying the application
- `configuration`: All the constant files that has to be edited before spin up the container
- `docker`: All the containers directory. At the beginning empty but with the execution of the script, it will start populating
- `images`: Each service has its own environment and these images describe when to do each edition
- `os`: Depending which operating system you have in the VPS, it describes how to do the initial configuration
- `scripts`: Automatise application deploy:
  - *init.sh*: Pull repositories and add its own environment variables
  - *install.sh*: Create the bundles and move to the containers location to spin up the application
  - *color.sh*: Terminal coloring helper function
  - *path.sh*: Path constants helper

## Docker
After execute all the scripts, it is time to build our container and run it
```bash
# Build all the images. Experimental feature to build in parallel
DOCKER_BUILDKIT=1 docker compose build
# Spin up the container
docker compose up
```
> Once we create a neo4j container, the credentials will not change even we change the `.env` file. We need to delete the container to add new environment variables