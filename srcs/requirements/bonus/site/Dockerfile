FROM nginx:bullseye

RUN apt update && apt upgrade -y

COPY tools/site.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
