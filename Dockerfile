FROM nginx:1.27-alpine

# Prevent /docker-entrypoint.sh from launching redundant background jobs
ENV NGINX_ENTRYPOINT_QUIET_LOGS=1
ENV NGINX_ENVSUBST_TEMPLATE_DIR=/dev/null

WORKDIR /usr/share/nginx/html
RUN rm -f index.html
COPY index.html .
COPY nginx.conf /etc/nginx/nginx.conf

# Make cache dirs writable for any UID (OpenShift)
RUN mkdir -p /var/cache/nginx/client_temp /var/run /var/log/nginx && \
    chmod -R 777 /var/cache/nginx /var/run /var/log/nginx

# Make HTML files/directories readable/traversable for any UID
RUN chmod -R 755 /usr/share/nginx && \
    chmod -R 755 /usr/share/nginx/html && \
    chmod -R 644 /usr/share/nginx/html/*

EXPOSE 8080

# Explicitly override ENTRYPOINT to bypass /docker-entrypoint.sh completely
ENTRYPOINT ["nginx", "-g", "daemon off;"]
