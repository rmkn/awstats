#!/bin/sh

sed -i -e 's/ServerTokens OS/ServerTokens Prod/' /etc/httpd/conf/httpd.conf
sed -i -e 's/ServerSignature On/ServerSignature Off/' /etc/httpd/conf/httpd.conf
sed -i -e 's/AddDefaultCharset UTF-8/AddDefaultCharset Off/' /etc/httpd/conf/httpd.conf
sed -i -e 's/Options Indexes/Options/' /etc/httpd/conf/httpd.conf

cat <<EOT > /etc/httpd/conf.d/security.conf
TraceEnable Off
Header always add X-Frame-Options SAMEORIGIN
FileETag MTime Size
EOT
