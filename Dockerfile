FROM jenkins/jenkins:2.366-jdk11

USER root

# install docker
RUN set -o pipefail \
 && apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends ca-certificates curl gnupg lsb-release \
 && mkdir -p /etc/apt/keyrings \
 && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io docker-compose-plugin \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && /usr/sbin/groupmod --gid 412 docker \
 && /usr/sbin/usermod --append --groups docker jenkins 
# host の docker group の GID が 412 という前提で jenkins ユーザーが
# /var/run/docker.sock にアクセスできるようにする

USER jenkins
