FROM ubuntu:16.04
MAINTAINER Matt Pascoe <matt@opennetadmin.com>

RUN apt-get update && \
    apt-get -y install apache2 php-gmp php-mysql libapache2-mod-php php-mbstring php-xml composer unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN git -C /opt clone https://github.com/opennetadmin/ona-core.git -b dev
RUN cd /opt/ona-core && composer -vv install

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN /usr/sbin/a2ensite default-ssl
RUN /usr/sbin/a2enmod ssl

RUN php /opt/ona-core/install/install.php --database_name=default --admin_passwd=my-secret-pw --database_host=mysql --admin_login=root --sys_login=ona_sys --sys_passwd=changeme --default_domain=example.com

COPY database_settings.inc.php /opt/ona-core/etc/database_settings.inc.php
COPY default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf
COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf

#EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
