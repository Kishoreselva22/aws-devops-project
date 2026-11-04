FROM nginx:1.27-alpine

# Replace the default Nginx welcome page with our website.
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80
