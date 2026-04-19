Elementrix Platform – Installation & Operations Guide
Document Version: 1.1
Audience: DevOps, Infrastructure, Security, Operations
Deployment Models: Standalone (Docker Compose) and Kubernetes

## Overview
Elementrix is a Data Hub & Marketplace platform, that leverages the concept of federated data mesh, where different teams collaborates together to provide 360 business driven data products, the products provided by the platform is discoverable, reachable, self-serviceable, available for immediate consumption by different applications / Platforms, supports economy of data , data democracy and governance of data access & distribution
Moreover, every access to any of the data products is centralized, which is subject to governance, auditing ,spike arresting and access patterns detections.

##Supported Technology Stack
| Component | Supported Versions | Notes |
| :--- | :--- | :--- |
| PostgreSQL | 14.x, 15.x, 16.x | External DB required for production |
| Kafka | 3.5+, 3.6+ | KRaft mode supported and recommended |
| Keycloak | 22.x – 26.x | Production mode with external DB |
| Elasticsearch | 8.5.x – 8.12.x | Dedicated data nodes recommended |
| Kibana | 8.5.x – 8.12.x | Must match Elasticsearch version |
| Java | 17, 21 (LTS) | Java 21 preferred |
| Docker Engine | 24.x+ | Compose v2 required |
| Kubernetes | 1.24 – 1.30 | containerd runtime recommended |


### Docker Installation (Ubuntu)

If you have not installed Docker yet, follow these steps to set up the repository and install Docker Engine on Ubuntu:

```bash
# Install Docker using the official convenience script
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

### Installation Troubleshooting

If you encounter `404 Not Found` or `Unable to fetch some archives` errors during installation, try updating the package list and fixing missing dependencies manually:

```bash
# Update package list again
sudo apt-get update

# Try to fix broken installs
sudo apt-get install --fix-missing
sudo apt  install docker.io docker-compose-plugin
```

#### Containerd

To install `containerd`, refer to the official documentation:
- [Containerd Installation Guide](https://github.com/containerd/containerd/blob/main/docs/getting-started.md)
- [Docker's Containerd Guide](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository) (often installed alongside Docker)

#### Podman

To install `podman`, refer to the official installation instructions:
- [Podman Installation Instructions](https://podman.io/docs/installation)

### Post-installation Steps

Manage Docker as a non-root user and verify installation:

```bash
# Add your user to the docker group
sudo usermod -aG docker $USER

# Apply the new group membership
newgrp docker

# Verify that you can run docker commands without sudo
docker ps
```

## Directory Structure

Ensure the following files and directories are present in your deployment directory:

- `services-docker-compose.yml`: Infrastructure services (Kafka, Postgres, Redis, etc.)
- `microservices-docker-compose.yml`: Application microservices.
Important this file has to be modified before init the scripts
- `.env`: Environment variables configuration.
DATA_ELEMENT_PORTAL_URL=http://localhost change localhost to your machine ip
- `init.sql`: Initialization script for PostgreSQL (mapped in `services-docker-compose.yml`).
- `realm-import/`: Keycloak realm import data (mapped in `services-docker-compose.yml`).
- `nginx.conf`: Nginx configuration file for reverse proxy.
Important this file has to be modified before init the scripts
- `.env.frontend`: it contain the web-portal url and has to be change from 127.0.0.1 to your local machine ip.

## Deployment Steps

## ▶️ Deployment Instructions

Clone the platform commponant via 

git clone https://digitalforrest@dev.azure.com/digitalforrest/Elementrix/_git/elementrix.io

once clone done run 

cd elementrix-setup

###  Make the startup script executable

```bash
chmod +x elementrix-install.sh
```
## Run the platform

```bash
./elementrix-install.sh
```


## Access Points

After successful deployment, you can access the various components at the following endpoints:

| Service | URL | Description | USERNAME | PASSWORD |
|---------|-----|-------------|----------|----------|
| **Elementrix Web Portal** | [http://your machine ip](http://localhost) | Main User Interface | sysowner@digitalforrest-me.com | 1 |
| **Keycloak** | [http://your machine ip:8080](http://localhost:8080) | Identity & Access Management | admin | admin |


## ▶️ Cleanup Instructions

### 1️⃣ Make the startup script executable

```bash
chmod +x elementrix-clean.sh
```

##Run the platform
```bash
./elementrix-clean.sh
```

## Impoertant Notes
Please note you need license to run this platform please contact us for more information. please visit https://elementrix.io/elementrix/
