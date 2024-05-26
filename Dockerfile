# create node 18 dockerfile with git, ansible,docker(latest version),
# docker-compose(latest-version),dev tools, yarn,terraform,sonar-scanner,
# Install required tools: ping, nslookup, telnet, dig,wget\

# Create layer from node18 Docker image (installed inside image)
FROM node:18-alpine

#ARG SONAR_SCANNER_VERSION=5.0.1.3006

#Install required dev tools and dependencies 
RUN set -eux \
    apk update && apk add --no-cache \
    wget \
    python3 \
    bind-tools \
    iputils \
    busybox-extras \
    ca-certificates \
    curl \
    unzip \
    libc6-compat \
    openjdk11 unzip

#installing softwares
RUN apk update && apk add --no-cache \
    git \ 
    --update docker openrc \
    docker-compose \ 
    yarn \
    terraform --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    ansible 

# Download and install SonarScanner
RUN mkdir -p /opt && cd /opt && \
    wget -O sonar-scanner-cli.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472.zip && \
    unzip sonar-scanner-cli.zip && \
    mv sonar-scanner-4.6.2.2472 sonar-scanner && \
    rm sonar-scanner-cli.zip

# Set environment path for sonar-scaner
ENV PATH="/opt/sonar-scanner/bin:$PATH"

# Create a working directory for app
WORKDIR /app

CMD ["sonar-scanner"]

# docker tag local-image:tagname new-repo:tagname
# docker push new-repo:tagname

#docker tag firstimage YOUR_DOCKERHUB_NAME/firstimage