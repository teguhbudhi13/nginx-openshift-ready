FROM nginx:alpine

WORKDIR /usr/share/nginx/html
RUN rm -f index.html
COPY index.html .
RUN chmod -R 644 /usr/share/nginx/html && \
    chown -R 1001:0 /usr/share/nginx/html

# Add custom nginx.conf to use port 8080
COPY nginx.conf /etc/nginx/nginx.conf

USER 1001
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
