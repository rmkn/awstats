#!/bin/sh

sed -i -e 's/ServerTokens OS/ServerTokens Prod/' /etc/httpd/conf/httpd.conf
sed -i -e 's/ServerSignature On/ServerSignature Off/' /etc/httpd/conf/httpd.conf
sed -i -e 's/AddDefaultCharset UTF-8/AddDefaultCharset Off/' /etc/httpd/conf/httpd.conf
sed -i -e 's/Options Indexes/Options/' /etc/httpd/conf/httpd.conf

cat <<EOT > /etc/httpd/conf.d/security.conf
TraceEnable Off
FileETag MTime Size
RequestHeader unset Proxy
Header always set X-XSS-Protection "1; mode=block"
Header always set X-Frame-Options SAMEORIGIN
Header always set X-Content-Type-Options nosniff
Header always set Content-Security-Policy "default-src 'self'"
EOT
