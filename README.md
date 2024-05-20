## cuda-ssh

<img src="https://github.com/nachoaIvarez/cuda-ssh/assets/7253814/e293ccae-6994-41a8-b153-efea5fdaba79" width="128"></img>

## Purpose

This container is designed to leverage NVIDIA GPU acceleration for computing purposes while enabling secure remote access through SSH. It's suitable for environments requiring GPU resources for computational tasks and secure, remote management without direct login credentials.

I use this to run containers for my friends who need GPU acceleration for AI purposes. They give me their public SSH key and I provide them with an SSH connection string.

## Prerequisites

- Docker installed on your system
- NVIDIA GPU with CUDA support
- NVIDIA Docker runtime setup

## Quick Start

1. **Run Container:**

   To start the container with SSH access, specify an open port and your SSH public key via an environment variable:

   ```sh
   docker run ghcr.io/nachoaivarez/cuda-ssh:latest -p <some open port>:22 -e AUTHORIZED_KEYS="<pub key of whoever is accessing this>"
   ```

2. **Connect via SSH:**

   Once the container is running, the owner of the SSH keypair can SSH into it using:

   ```sh
   ssh root@<ip of the host machine running the container> -p <the open port>
   ```

## Considerations

- **Security:** By default, root login is disabled and password authentication is turned off. Only key-based authentication is permitted.
- **NVIDIA Drivers:** Ensure your host system's NVIDIA drivers are compatible with the CUDA version of the container. See the base image.
- **Networking:** The container exposes port 22 for SSH. Adjust firewall settings if necessary to allow SSH traffic.
