FROM nginx:bullseye

RUN apt update && apt upgrade -y && mkdir -p /usr/share/nginx/html

COPY tools/site.html /usr/share/nginx/html/index.html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
