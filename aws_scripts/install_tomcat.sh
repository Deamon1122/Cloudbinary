#!/bin/bash
yum clean all
amazon-linux-extras install tomcat8.5=8.5.50
alternatives --set java  /usr/lib/jvm/java-11-amazon-corretto.x86_64/bin/java
mv /home/ec2-user/javaapp/ROOT.war /var/lib/tomcat/webapps/


# tomcat server

#!/bin/bash

# Install apache
yum -y install httpd-2.4.52

# Set up proxy for Tomcat server
cat <<EOT >> /etc/httpd/conf/httpd.conf
LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_http_module modules/mod_proxy_http.so

ProxyRequests Off
ProxyPass / http://localhost:8080/
ProxyPassReverse / http://localhost:8080/

<Location "/">
  Order allow,deny
  Allow from all
</Location>
EOT

