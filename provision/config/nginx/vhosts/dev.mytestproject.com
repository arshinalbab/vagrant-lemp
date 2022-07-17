# Virtual Host configuration for main website
#
# You can move that to a different file under sites-available/ and symlink that
# to sites-enabled/ to enable it.

server {
	listen 80;
	listen [::]:80;

	include snippets/phpmyadmin.conf;

	server_name dev.mytestproject.com;
	
	access_log /var/log/nginx/dev.mytestproject.com.log;
	error_log  /var/log/nginx/dev.mytestproject.com.log error;

	root /var/www/html;
	index index.php index.html ;

	location / {
		try_files $uri $uri/ =404;
	}
	# pass PHP scripts to FastCGI server
	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
	
		# With php-fpm (or other unix sockets):
		fastcgi_pass unix:/var/run/php/php7.3-fpm.sock;
		# With php-cgi (or other tcp sockets):
		#fastcgi_pass 127.0.0.1:9000;
	}

	# Prevents caching of css/less/js/images, only use this in development
	location ~* \.(css|less|js|jpg|png|gif)$ {
		add_header Cache-Control "no-cache, no-store, must-revalidate"; 
		add_header Pragma "no-cache";
		expires 0;
	}
}
