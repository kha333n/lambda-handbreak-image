# Define function directory
ARG FUNCTION_DIR="/var/task"

FROM node:20-buster as build-image

# Install build dependencies (optional, adjust based on your needs)
RUN apt-get update -qq && apt-get install -y \
    software-properties-common \
    build-essential \
    libssl-dev \
    g++ \
        make \
        cmake \
        unzip \
        libcurl4-openssl-dev \
    handbrake-cli

ENV NPM_CONFIG_CACHE=/tmp/.npm
ARG FUNCTION_DIR
# Copy function code
WORKDIR ${FUNCTION_DIR}
COPY . ${FUNCTION_DIR}

# Install Node.js dependencies (including handbrake-cli)
RUN npm install
RUN npm install aws-lambda-ric

# Set entrypoint to execute index.js
ENTRYPOINT ["/usr/local/bin/npx", "aws-lambda-ric"]

# Optional: Set custom command argument (if needed)
CMD ["index.handler"]
