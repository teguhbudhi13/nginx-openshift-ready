FROM nginx:1.27-alpine

WORKDIR /usr/share/nginx/html

# Remove default index.html and add our own
RUN rm -f index.html
COPY index.html .

# Custom nginx config for port 8080
COPY nginx.conf /etc/nginx/nginx.conf

# Ensure random OpenShift UID can write everywhere needed
RUN chmod -R 777 /var/cache/nginx /var/run /var/log/nginx \
 && chmod -R 644 /usr/share/nginx/html \
 && chown -R 1001:0 /usr/share/nginx/html

USER 1001

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
