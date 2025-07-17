FROM nginx:1.21.6

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]