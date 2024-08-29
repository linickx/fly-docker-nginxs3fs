FROM nginx:alpine-slim

# Custom Packages
RUN apk update
RUN apk add --no-cache openssl s3fs-fuse

# NGINX Config
RUN mkdir /etc/nginx/templates
COPY etc/nginx/templates/default.conf.template /etc/nginx/templates/default.conf.template

# Trigris (S3) Bucket
COPY docker-entrypoint.d/40-s3fs.sh /docker-entrypoint.d/40-s3fs.sh
RUN chmod 755 /docker-entrypoint.d/40-s3fs.sh
