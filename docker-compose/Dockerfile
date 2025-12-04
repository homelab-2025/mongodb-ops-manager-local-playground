# Dockerfile for MongoDB Ops Manager
FROM ubuntu:24.04

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    curl \
    lsb-release \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

# COPY Ops Manager .deb package and configuration file
COPY mongodb-mms-*.deb /tmp/

# Start MongoDB and install Ops Manager
RUN dpkg -i /tmp/mongodb-mms-*.deb && \
    apt-get install -f -y && \
    rm /tmp/mongodb-mms-*.deb

# Copy configuration file
COPY conf-mms.properties /opt/mongodb/mms/conf/conf-mms.properties

# Add entrypoint script to start mongod and Ops Manager automatically
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]