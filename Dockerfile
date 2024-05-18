# Use the specified base image from NVIDIA
FROM nvidia/cuda:12.4.1-cudnn-runtime-ubuntu22.04

# Metadata
LABEL maintainer="Nacho Alvarez docker@nachoalvarez.dev"
LABEL description="GPU accelerated container with SSH support"
LABEL version="1.0.3"

# Environment variables
ENV NVIDIA_DRIVER_CAPABILITIES=all
ENV NVIDIA_VISIBLE_DEVICES=all

# Install SSH and clean up in one layer
RUN apt-get update && apt-get install -y openssh-server && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/run/sshd \
    && echo "PermitRootLogin prohibit-password" >> /etc/ssh/sshd_config \
    && echo "PasswordAuthentication no" >> /etc/ssh/sshd_config \
    && mkdir -p /root/.ssh

# Expose SSH port
EXPOSE 22

# Entry point to handle authorized keys and start sshd
ENTRYPOINT ["/bin/sh", "-c", "if [ ! -z \"$AUTHORIZED_KEYS\" ]; then echo \"$AUTHORIZED_KEYS\" > /root/.ssh/authorized_keys && chmod 600 /root/.ssh/authorized_keys && chmod 700 /root/.ssh; fi; exec /usr/sbin/sshd -D"]
