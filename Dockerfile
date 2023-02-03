FROM tomcat:8
COPY target/*.war /usr/local/tomcat/webapps/
Run echo "Jenkins Docker Build and Publish" > /var/www/html/index.html
