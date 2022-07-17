#!/bin/bash
sudo apt-get install software-properties-common

# Remove the default installed php
sudo apt-get purge php7.*
sudo apt-get autoclean
sudo apt-get autoremove

sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install -y php7.3-fpm php7.3-bcmath php7.3-bz2 php7.3-cli php7.3-curl php7.3-intl php7.3-json php7.3-mbstring php7.3-opcache php7.3-soap php7.3-xml php7.3-xsl php7.3-zip php7.3-mysql composer

# Make changes to php.ini files1111
sed -i 's/max_execution_time = .*/max_execution_time = 60/' /etc/php/7.3/fpm/php.ini
sed -i 's/max_input_time = .*/max_input_time = 360/' /etc/php/7.3/fpm/php.ini
sed -i 's/max_input_vars = .*/max_input_vars = 5000/' /etc/php/7.3/fpm/php.ini
sed -i 's/memory_limit = .*/memory_limit = 512M/' /etc/php/7.3/fpm/php.ini
sed -i 's/cgi.fix_pathinfo = .*/cgi.fix_pathinfo = 0/' /etc/php/7.3/fpm/php.ini
sed -i 's/post_max_size = .*/post_max_size = 1G/' /etc/php/7.3/fpm/php.ini
sed -i 's/upload_max_filesize = .*/upload_max_filesize = 1G/' /etc/php/7.3/fpm/php.ini
sed -i 's/allow_url_fopen = .*/allow_url_fopen = On/' /etc/php/7.3/fpm/php.ini

php-fpm7.3 -t
service  php7.3-fpm restart
service nginx restart