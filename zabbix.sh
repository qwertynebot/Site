sudo apt update && sudo apt upgrade -y

wget https://repo.zabbix.com/zabbix/6.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.2-4%2Bubuntu22.04_all.deb

sudo dpkg -i zabbix-release_6.2-4+ubuntu22.04_all.deb

sudo apt update

sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

sudo apt install software-properties-common -y

curl -LsS -O https://downloads.mariadb.com/MariaDB/mariadb_repo_setup

sudo bash mariadb_repo_setup --mariadb-server-version=10.6

sudo apt update

sudo apt -y install mariadb-common mariadb-server-10.6 mariadb-client-10.6

sudo systemctl start mariadb

sudo systemctl enable mariadb

sudo mysql -uroot -p'rootDBpass' -e "create database zabbix character set utf8mb4 collate utf8mb4_bin;"

sudo mysql -uroot -p'rootDBpass' -e "grant all privileges on zabbix.* to zabbix@localhost identified by 'pam';"

sudo zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix

sudo mysql

set global log_bin_trust_function_creators = 0;

quit;

sudo systemctl restart zabbix-server

echo "Add database password: DBPassword=test"

sudo vim /etc/zabbix/zabbix_server.conf

ufw allow 10050/tcp

ufw allow 10051/tcp

ufw allow 80/tcp

ufw reload

sudo systemctl restart zabbix-server zabbix-agent apache2

sudo systemctl enable zabbix-server zabbix-agent apache2
