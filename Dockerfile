FROM alpine:3.20

# Minimal non-root container serving a placeholder page
RUN adduser -D -h /home/developer developer \
    && mkdir -p /var/www \
    && echo "VDEL placeholder OK" > /var/www/index.html

EXPOSE 8080
USER developer

# Busybox httpd is built into Alpine's busybox
CMD ["busybox", "httpd", "-f", "-p", "0.0.0.0:8080", "-h", "/var/www"]

