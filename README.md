# DevOps CI/CD Pipeline – Jenkins, Docker, AWS EC2

This repository contains a complete CI/CD pipeline using Jenkins, Docker, GitHub Webhooks, AWS EC2, and Nginx.  
It includes a sample Flask application, automated testing, Docker image build, Trivy security scanning, and automated deployment to a production EC2 server.

-------------------------------------------------------------------

## Features

- Fully automated CI/CD pipeline using Jenkins Declarative Pipeline
- Automatic build, test, image creation, security scan, and deployment
- Docker image pushed to DockerHub
- Deployment to AWS EC2 using docker-compose
- Webhook-based automatic CI/CD trigger
- Nginx reverse proxy support
- Shell script for production server deployment

-------------------------------------------------------------------

## Project Structure

devops-pipeline/
│
├─ app/
│  ├─ app.py
│  ├─ requirements.txt
│  └─ tests.py
│
├─ deploy/
│  ├─ deploy.sh
│  └─ docker-compose.prod.yml
│
├─ k8s/
│  ├─ deployment.yaml
│  └─ service.yaml
│
├─ Dockerfile
├─ docker-compose.yml
├─ Jenkinsfile
└─ README.md

-------------------------------------------------------------------

## Local Setup

Clone repository:

    git clone https://github.com/mrohitmishra/devops-pipeline.git
    cd devops-pipeline

Run locally:

    docker-compose up --build

Run tests:

    cd app
    pytest

-------------------------------------------------------------------

## DockerHub Setup

Create a repository:

    DOCKERHUB_USERNAME/devops-pipeline

Replace DockerHub username in:
- deploy/docker-compose.prod.yml
- deploy/deploy.sh
- Jenkinsfile

-------------------------------------------------------------------

## Jenkins Credentials Required

Create these credentials inside Jenkins:

1. DOCKERHUB_USER_CRED        (DockerHub username)
2. DOCKERHUB_PASS_CRED        (DockerHub password)
3. EC2_SSH_KEY_ID             (SSH private key for EC2)

-------------------------------------------------------------------

## AWS EC2 Server Setup

Install Docker and docker-compose:

    sudo apt update -y
    sudo apt install docker.io docker-compose -y
    sudo usermod -aG docker ubuntu

Add Jenkins public key to:

    ~/.ssh/authorized_keys

-------------------------------------------------------------------

## CI/CD Pipeline Flow (Jenkinsfile)

Pipeline performs:

1. Checkout source code
2. Run Python unit tests
3. Build Docker image
4. Run Trivy security scan
5. Push image to DockerHub
6. SSH into EC2
7. Pull latest image and restart docker-compose service

-------------------------------------------------------------------

## Deployment (Production Server)

deploy/deploy.sh:

- Pulls updated Docker image
- Restarts service with docker-compose
- Cleans unused images

Make script executable:

    chmod +x deploy.sh

-------------------------------------------------------------------

## Nginx Reverse Proxy (Optional)

Install:

    sudo apt install nginx -y

Basic config at /etc/nginx/sites-enabled/default:

    server {
        listen 80;
        location / {
            proxy_pass http://localhost:5000;
        }
    }

Restart Nginx:

    sudo systemctl restart nginx

-------------------------------------------------------------------

## Kubernetes Deployment (Optional)

Apply the manifests:

    kubectl apply -f k8s/

-------------------------------------------------------------------

## Trigger Pipeline

Push a commit:

    git add .
    git commit -m "Trigger CI/CD pipeline"
    git push

Jenkins will automatically start pipeline.

-------------------------------------------------------------------

## Output

Application will be deployed to:

    http://EC2_PUBLIC_IP

-------------------------------------------------------------------

## Author

Rohit Mishra  
DevOps Engineer | Security Researcher | Backend Developer  
GitHub: https://github.com/mrohitmishra  
Portfolio: https://rohitmishra.co.in  

-------------------------------------------------------------------
