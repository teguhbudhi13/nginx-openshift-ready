FROM nginx:1.27-alpine

WORKDIR /usr/share/nginx/html
RUN rm -f index.html
COPY index.html .

COPY nginx.conf /etc/nginx/nginx.conf

# Guaranteed OpenShift permission fix (create and chmod recursively)
RUN mkdir -p /var/cache/nginx/client_temp && \
    chmod -R 777 /var/cache/nginx /var/run /var/log/nginx

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
