FROM nginx:1.19

COPY index.html /usr/share/nginx/html/

COPY image.PNG /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
