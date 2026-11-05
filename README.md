# AWS DevOps Deployment Project

## Project Overview
This project demonstrates a Docker-based web application deployment workflow using GitHub, GitHub Actions, and Docker Hub.

## Technologies Used
- Linux (Ubuntu)
- Git and GitHub
- Docker
- Nginx
- GitHub Actions
- Docker Hub

## Project Workflow
1. Created a simple web application using Nginx.
2. Managed source code using Git and GitHub.
3. Created a Dockerfile to containerize the application.
4. Configured GitHub Actions to build and push Docker images to Docker Hub.
5. Pulled the Docker image from Docker Hub.
6. Ran the container locally and verified the website in a browser.

## Architecture

GitHub → GitHub Actions → Build Docker Image → Docker Hub → Pull Image → Run Docker Container

## Docker Hub
Docker Image: `lobiya/aws-devops-web:latest`

## How to Run

Pull the image:

```bash
docker pull lobiya/aws-devops-web:latest
```

Run the container:

```bash
docker run -d --name aws-devops-web -p 8080:80 lobiya/aws-devops-web:latest
```

Open in browser:

`http://localhost:8080`

## Project Outcome
Successfully containerized an Nginx web application and verified it locally using a Docker image pulled from Docker Hub.

**Note:** Automated EC2 deployment is not currently configured in this workflow.
