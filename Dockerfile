FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive \
    PATH=/home/developer/.local/bin:$PATH

# Create non-root user and placeholder page
RUN useradd -m -u 1000 -s /bin/bash developer \
    && mkdir -p /var/www \
    && echo "VDEL placeholder OK" > /var/www/index.html

# Copy requirements and installer
COPY requirements.txt /opt/requirements.txt
COPY scripts/install_data_tools.sh /opt/install_data_tools.sh

# Install system + Python tools
RUN bash /opt/install_data_tools.sh

EXPOSE 8080 8888
USER developer

# Serve placeholder page; Jupyter runs on demand via make target
CMD ["python3", "-m", "http.server", "8080", "-d", "/var/www"]
