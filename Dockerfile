# Use the specified base image from NVIDIA
FROM nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

# Metadata
LABEL maintainer="Nacho Alvarez docker@nachoalvarez.dev"
LABEL description="GPU accelerated container with SSH support"
LABEL version="1.0.0"

ENV NVIDIA_DRIVER_CAPABILITIES=all
ENV NVIDIA_VISIBLE_DEVICES=all

# Install required packages and set up SSH
RUN apt-get update \
    && apt-get install -y openssh-server \
    && mkdir -p /root/.ssh \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
    && mkdir /var/run/sshd

# Expose the SSH port
EXPOSE 22

# Command to run SSH daemon in the foreground
CMD ["/usr/sbin/sshd", "-D"]
