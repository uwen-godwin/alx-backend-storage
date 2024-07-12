# Use Ubuntu 18.04 as base image
FROM ubuntu:18.04

# Update packages and install necessary tools
RUN apt-get update \
    && apt-get install -y \
       python3.7 \
       python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set Python 3.7 as the default python version
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1

# Print Python and pip versions
RUN python3 --version && pip3 --version

# Set working directory
WORKDIR /app
