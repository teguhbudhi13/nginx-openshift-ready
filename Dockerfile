FROM nginx:1.27-alpine

WORKDIR /usr/share/nginx/html

RUN rm -f index.html
COPY index.html .

COPY nginx.conf /etc/nginx/nginx.conf

# Remove user directive from nginx.conf (very important)
# Fix permissions for ALL runtime-writable nginx dirs for any UID (including OpenShift random UIDs)
RUN chmod -R 777 /var/cache/nginx /var/run /var/log/nginx

# Optionally, for *all* non-root, random UID OpenShift compatibility, make html readable by all
RUN chmod -R 644 /usr/share/nginx/html

# No need for USER line at all (let OpenShift assign any UID)
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
