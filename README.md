# End-to-End Cloud Deployment Using AWS and DevOps

## Project Overview

This project demonstrates a Docker-based application deployment workflow using DevOps tools and cloud computing concepts.

The application is containerized using Docker, and GitHub Actions is used to automate Docker image building and pushing to Docker Hub. The published image is then pulled and deployed locally for testing.

AWS EC2 was also used for hands-on Linux server and deployment practice during college placement training.

## Technologies Used

- **Cloud Platform:** AWS EC2 (hands-on training)
- **Operating System:** Ubuntu Linux
- **Version Control:** Git, GitHub
- **Containerization:** Docker
- **Web Server:** Nginx
- **CI/CD:** GitHub Actions
- **Container Registry:** Docker Hub

## Project Architecture

GitHub Repository  
↓  
GitHub Actions  
↓  
Build Docker Image  
↓  
Push Image to Docker Hub  
↓  
Pull Docker Image  
↓  
Run Docker Container  
↓  
Access Web Application

## Project Implementation

### 1. Source Code Management
- Created and maintained the project repository using GitHub.
- Used Git for version control and source code management.

### 2. Docker Containerization
- Created a Dockerfile for the Nginx web application.
- Built a Docker image to package the application and its required environment.
- Ran the application inside a Docker container.

### 3. CI/CD Automation
- Configured a GitHub Actions workflow.
- Automated Docker image building whenever code is pushed to the main branch.
- Configured Docker Hub authentication using GitHub repository secrets.
- Automated pushing of Docker images to Docker Hub.

### 4. Docker Hub Integration
- Published the Docker image to Docker Hub.
- Pulled the published image for deployment testing.

### 5. Application Deployment and Testing
- Ran the Docker container locally using the pulled image.
- Mapped the container's port 80 to the local port 8081 for testing.
- Verified that the Nginx web application was accessible through a web browser.

### 6. AWS EC2 Hands-on Practice
- Gained practical exposure to AWS EC2 during college placement training.
- Practised Linux server access and application deployment concepts.

## GitHub Actions Workflow

The CI workflow performs the following tasks:

1. Checks out the source code.
2. Sets up Docker Buildx.
3. Authenticates with Docker Hub.
4. Builds the Docker image.
5. Pushes the image to Docker Hub with `latest` and commit-based tags.

## Docker Hub Image

**Docker Hub Repository:**  
https://hub.docker.com/r/lobiya/aws-devops-web

**Image Name:**
`lobiya/aws-devops-web:latest`

## How to Run the Project

### Step 1: Pull the Docker Image

```bash
docker pull lobiya/aws-devops-web:latest
```

### Step 2: Run the Container

```bash
docker run -d --name aws-devops-web-container -p 8081:80 lobiya/aws-devops-web:latest
```

### Step 3: Verify the Running Container

```bash
docker ps
```

### Step 4: Access the Application

Open the following URL in your browser:

`http://localhost:8081`

## GitHub Repository

https://github.com/Kishoreselva22/aws-devops-project

## Key Learning Outcomes

- Practical experience with Linux and Docker.
- Understanding Git and GitHub version control.
- Hands-on experience with Docker image creation and container management.
- Understanding CI/CD automation using GitHub Actions.
- Experience
