sudo apt update && sudo apt upgrade -y

sudo apt install apache2 -y

sudo systemctl enable apache2

sudo apt install -y php php-{common,mysql,xml,xmlrpc,curl,gd,imagick,cli,dev,imap,mbstring,opcache,soap,zip,intl} -y

sudo apt install mariadb-server mariadb-client -y

sudo systemctl enable --now mariadb

mysql -u root -e "CREATE USER 'new_user'@'localhost' IDENTIFIED BY 'your_password';"

mysql -u root -e "CREATE DATABASE new_db;"

mysql -u root -e "GRANT ALL PRIVILEGES ON new_db.* TO 'new_user'@'localhost';"

mysql -u root -e "FLUSH PRIVILEGES;"

sudo apt install wget unzip -y

wget https://wordpress.org/latest.zip

sudo unzip latest.zip

sudo mv wordpress/ /var/www/html/

sudo rm latest.zip

sudo chown www-data:www-data -R /var/www/html/wordpress/

sudo chmod -R 755 /var/www/html/wordpress/

sudo /etc/apache2/sites-available/wordpress.conf > <VirtualHost *:80>

ServerAdmin admin@example.com

DocumentRoot /var/www/html/wordpress
ServerName example.com
ServerAlias www.example.com

<Directory /var/www/html/wordpress/>

Options FollowSymLinks
AllowOverride All
Require all granted

</Directory>

ErrorLog ${APACHE_LOG_DIR}/error.log
CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>

sudo a2ensite wordpress.conf

sudo a2enmod rewrite

sudo a2dissite 000-default.conf

sudo systemctl restart apache2
