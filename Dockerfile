# Use the Ubuntu 16:04 base image
FROM ubuntu:22.04

USER root

WORKDIR /app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DOCKER 1
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get -y install net-tools && \
    apt install iputils-ping -y     && \
    apt-get install -y software-properties-common && \
    apt-get install -y build-essential && \
    apt-get install -y wget && \
    apt-get install -y curl && \
    apt-get install -y python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get upgrade -y
RUN apt-get -y install net-tools
RUN apt install iputils-ping -y

# openssh
RUN apt-get update && apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    echo 'root:root123' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "PermitRootLogin no" >> /etc/ssh/sshd_config

EXPOSE 22

# for 2FA
RUN apt-get install libpam-google-authenticator -y 
# && \
# echo "auth required pam_google_authenticator.so" >> /etc/pam.d/sshd && \
# echo "ChallengeResponseAuthentication yes" >> /etc/ssh/sshd_config && \
# echo "UsePAM yes" >> /etc/ssh/sshd_config

RUN apt install nano -y
RUN apt install -y sudo



# Update packages and install SSH server
RUN apt-get update && \
    apt install -y ubuntu-desktop 

RUN sudo apt install -y \ 
    tightvncserver \
    gnome-panel \ 
    gnome-settings-daemon \ 
    metacity \ 
    nautilus \ 
    gnome-terminal

# Expose the SSH port
EXPOSE 22
EXPOSE 1
EXPOSE 5901

CMD ["/usr/sbin/sshd", "-D"]




