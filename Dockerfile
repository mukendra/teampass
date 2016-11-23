FROM ubuntu:14.04
maintainer mukki
RUN apt-get update
RUN apt-get install -y apache2 php5 unzip wget
WORKDIR /opt
RUN wget https://github.com/nilsteampassnet/TeamPass/archive/fix_2.1.24.zip
RUN unzip fix_2.1.24.zip
RUN ln -s /opt/TeamPass-fix_2.1.24  /var/www/html/teampass2
RUN apt-get -y install php5-mcrypt
WORKDIR /home
RUN wget  https://github.com/mukendra/teampass/blob/master/php.ini 
RUN cp /home/php.ini /etc/php5/apache2/php.ini
RUN php5enmod mcrypt
RUN chown -R www-data:www-data /var/www/html/teampass2
RUN chmod 777 /var/www/html/teampass2/*
RUN chmod 777 /var/www/html/teampass2/includes/*
RUN mkdir /var/www/html/teampass2/keys
RUN chmod 777 /var/www/html/teampass2/keys 
RUN a2enmod ssl
RUN a2ensite default-ssl
RUN apt-get install php5-mysqlnd -y
ENTRYPOINT service apache2 restart && sleep 3600
