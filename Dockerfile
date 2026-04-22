FROM nginx:alpine
COPY Docs/ /usr/share/nginx/html/
EXPOSE 80
# Triggering CI/CD pipeline for Lab 06
# Validation Lab 06 - Hugues
