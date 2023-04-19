FROM ubuntu:latest

WORKDIR /app

USER root

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y wget git python3 python3-venv ffmpeg libsm6 libxext6
RUN wget -O /app/webui.sh https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh

# Set user and group
ARG user=appuser
ARG group=appuser
ARG uid=1000
ARG gid=1000
RUN groupadd -g ${gid} ${group}
RUN useradd -u ${uid} -g ${group} -s /bin/sh -m ${user} # <--- the '-m' create a user home directory

# Switch to user
USER ${uid}:${gid}

EXPOSE 80

ENTRYPOINT bash webui.sh --skip-torch-cuda-test
