FROM centos:6
MAINTAINER rmkn
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8 && sed -i -e "s/en_US.UTF-8/ja_JP.UTF-8/" /etc/sysconfig/i18n
RUN cp -p /usr/share/zoneinfo/Japan /etc/localtime && echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock
RUN yum -y update
RUN yum -y install httpd perl unzip

RUN curl -o /tmp/awstats.zip -SL "http://downloads.sourceforge.net/project/awstats/AWStats/7.5/awstats-7.5.zip?r=&ts=1479712548&use_mirror=jaist" \
	&& unzip /tmp/awstats.zip -d /usr/local/ \
	&& ln -s /usr/local/awstats-7.5 /usr/local/awstats \
	&& mkdir /usr/local/awstats/data \
	&& chmod 777 /usr/local/awstats/data

COPY awstats.conf /usr/local/awstats/wwwroot/cgi-bin/
COPY vhosts.conf /etc/httpd/conf.d/
COPY security.sh /tmp/
RUN /tmp/security.sh

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

