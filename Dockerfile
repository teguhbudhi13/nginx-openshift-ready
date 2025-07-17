FROM nginx:1.21.6

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/

USER root
RUN chmod -R 777 /var/cache/nginx \
    && chmod 777 /tmp \
    && mkdir -p /var/run && chmod 777 /var/run

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
