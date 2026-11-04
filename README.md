# End-to-End Cloud Deployment using AWS and DevOps

A beginner-friendly sample project that packages a static website in Docker, builds and publishes the image with GitHub Actions, and deploys it to an Ubuntu EC2 instance.

## Architecture

Developer -> GitHub repository -> GitHub Actions -> Docker Hub -> SSH -> AWS EC2 -> Docker container -> Nginx website

## Repository structure

```text
aws-devops-project/
├── .github/
│   └── workflows/
│       └── deploy.yml
├── .dockerignore
├── Dockerfile
├── docker-compose.yml
├── index.html
└── README.md
```

## 1. Run locally with Docker

Requirements: Docker Engine or Docker Desktop.

```bash
docker build -t aws-devops-web .
docker run -d --name aws-devops-web -p 8080:80 aws-devops-web
```

Open http://localhost:8080.

To stop and remove the container:

```bash
docker rm -f aws-devops-web
```

Alternatively, use Docker Compose:

```bash
docker compose up -d --build
docker compose down
```

## 2. Create the AWS EC2 server

1. Create an Ubuntu Server EC2 instance.
2. Create/download a key pair and keep the private key safe. Never commit it to GitHub.
3. Attach a security group that allows HTTP (TCP 80) from the internet.
4. Allow SSH (TCP 22) only from a trusted source where possible. GitHub-hosted runner IPs can change; for a production setup, prefer a self-hosted runner with restricted networking or AWS Systems Manager instead of exposing SSH broadly.
5. Connect to the instance:

```bash
chmod 400 your-key.pem
ssh -i your-key.pem ubuntu@YOUR_EC2_PUBLIC_IP
```

Install and start Docker on Ubuntu:

```bash
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker ubuntu
```

Log out and reconnect so the Docker group membership takes effect. Verify:

```bash
docker --version
docker ps
```

The deployment workflow connects as the `ubuntu` user and runs Docker commands. If Docker reports a permission error, reconnect after the group change or use an appropriately configured deployment user.

## 3. Create a Docker Hub repository

1. Create/sign in to a Docker Hub account.
2. Create a repository named `aws-devops-web`.
3. Set it to **Public** for this learning project so EC2 can pull the image without Docker Hub credentials.
4. Create a Docker Hub access token. Use the token, not your account password, in GitHub Actions.

## 4. Add GitHub repository secrets

In your GitHub repository, open **Settings -> Secrets and variables -> Actions -> New repository secret**.

Create these five secrets:

| Secret name | Value |
|---|---|
| `DOCKERHUB_USERNAME` | Your Docker Hub username |
| `DOCKERHUB_TOKEN` | Docker Hub access token |
| `EC2_HOST` | EC2 public IPv4 address or DNS name |
| `EC2_USER` | `ubuntu` for Ubuntu EC2 |
| `EC2_SSH_KEY` | Full private key contents, including BEGIN/END lines |

Do not put credentials, private keys, tokens, or `.pem` files in the repository. Never share your secrets with a friend or publish them in screenshots.

## 5. Push the project to GitHub

Create a repository and push these files to its `main` branch:

```bash
git init
git add .
git commit -m "Add AWS DevOps deployment project"
git branch -M main
git remote add origin https://github.com/YOUR_GITHUB_USERNAME/YOUR_REPOSITORY.git
git push -u origin main
```

After the required secrets are configured, every push to `main` starts the workflow in `.github/workflows/deploy.yml`. You can view its progress under the repository's **Actions** tab.

When the workflow succeeds, open:

```text
http://YOUR_EC2_PUBLIC_IP
```

## 6. How the CI/CD workflow works

1. GitHub Actions checks out the repository.
2. It authenticates to Docker Hub using repository secrets.
3. It builds the Docker image.
4. It pushes both `latest` and the commit-specific image tag to Docker Hub.
5. It connects to EC2 over SSH.
6. EC2 pulls the exact image built for that commit, replaces the old container, and starts the new one.

## 7. Troubleshooting

- **Workflow says a secret is missing:** Check all five secret names and values. Secret names are case-sensitive.
- **SSH connection fails:** Check `EC2_HOST`, `EC2_USER`, private key format, instance status, and inbound SSH rules.
- **Permission denied on Docker:** Reconnect after adding `ubuntu` to the Docker group, or configure the deployment user correctly.
- **Website does not open:** Check that EC2 security group allows TCP 80 and that the container is running with `docker ps`.
- **Image pull fails:** Confirm the Docker Hub repository name and that the repository is public.
- **Workflow does not start:** Confirm the workflow file is at `.github/workflows/deploy.yml` and the branch is named `main`.

## Notes and limitations

- This is a learning/demo deployment, not a production-hardened setup.
- The workflow uses SSH for deployment. Production environments should consider AWS Systems Manager or a self-hosted runner with restricted access, least-privilege IAM, HTTPS, monitoring, and a controlled rollback strategy.
- AWS may charge for EC2, storage, data transfer, and related resources. Review the AWS pricing for your selected region and instance type, and stop/delete resources when they are no longer needed.
- This repository does not create AWS infrastructure automatically. EC2 setup and GitHub/Docker Hub secrets are required before cloud deployment.
- A friend can clone and run the project locally with Docker. To deploy it to their own AWS account, they must create their own EC2 instance, Docker Hub repository, and GitHub secrets. Your private keys and tokens must not be shared.
