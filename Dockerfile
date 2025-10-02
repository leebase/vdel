FROM alpine:3.20

# Minimal non-root container serving a placeholder page via darkhttpd
RUN adduser -D -h /home/developer developer \
    && mkdir -p /var/www \
    && echo "VDEL placeholder OK" > /var/www/index.html \
    && apk add --no-cache darkhttpd curl

EXPOSE 8080
USER developer

CMD ["darkhttpd", "/var/www", "--port", "8080", "--addr", "0.0.0.0", "--no-listing"]
