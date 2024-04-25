# Define function directory
ARG FUNCTION_DIR="/var/task"

FROM node:20-slim as builder

# Install build dependencies (optional, adjust based on your needs)
RUN apt-get update -qq && apt-get install -y \
    software-properties-common \
    build-essential \
    libssl-dev \
    handbrake-cli

# Copy function code
WORKDIR ${FUNCTION_DIR}
COPY . ${FUNCTION_DIR}

# Install Node.js dependencies (including handbrake-cli)
RUN npm install

# Set entrypoint to execute index.js
ENTRYPOINT ["node", "index.js"]

# Optional: Set custom command argument (if needed)
# CMD ["argument1", "argument2"]
