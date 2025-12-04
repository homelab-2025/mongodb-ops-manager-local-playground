# mongodb-ops-manager-local-playground

This guide provides instructions to set up a local playground environment for MongoDB Ops Manager using Ubuntu 24.04 on wsl2.

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running with WSL2 backend.

## Getting Started

1. Download Ops Manager for Debian 11 / Ubuntu 22/04, 24.04 at the official MongoDB website:

https://www.mongodb.com/try/download/ops-manager

2. Place the downloaded `.deb` file in the `docker-compose` directory of this repository.

3. Open a terminal and navigate to the `docker-compose` directory.

4. Build and start the Docker containers using Docker Compose:

```bash
docker compose up --build -d
```

It should take a few minutes for the Ops Manager service to start completely.

5. Once started, access to Ops Manager on a web browser at `http://localhost:8080`. You should see the Ops Manager login page.

6. On this page create a New Admin User by click on Sign Up and filling the form with your details.

To deploy an instance, you need to install the agent on your target machine (can be your host). This agent will communicate with the Ops Manager server and allow to Automate, Monitor, and Backup your MongoDB deployments.

7. To do so you will need to create an API Key for the agent to communicate with Ops Manager.

Go to "Deployments" -> "Agents" -> "Agent API Keys" and click on "Generate". Give it a name and click on "Generate".
Note the API Key, you will need it later.

8. Then we need to install the agent on the target machine by following these steps:

Click on "Deployments" -> "Agents" -> "Download & Settings" -> "Select your operating system" and follow the instructions to install the automation agent on your target machine.

9. Finally, you can create a new deployment by going to "Deployments" -> "Processes" -> "Build New Deployment" and following the instructions.

## Clean Up

To remove everything including the data, run the following command in the `docker-compose` directory:

```bash
docker compose down -v
```
