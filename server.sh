echo "try nstall apache2 and curl"
apt install apache2
apt install curl
sleep 2
echo "try ufw rules"
ufw app list

ufw allow in "Apache"

ufw status

sleep 2

IP=$(ip addr show virt0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//')

echo "$IP /n"

echo "try install MySQL Server"
apt install mysql-server

echo "WARNING"
echo "now run $> sudo mysql and write this: ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';"
sleep 4

apt install php libapache2-mod-php php-mysql

echo "install complite to libapache2-mod-php and php-mysql"

cp ./etc/apache2/mods-enabled/dir.conf /etc/apache2/mods-enabled/
echo "cp /etc/apache2/mods-enabled/dir.conf"

systemctl restart apache2
echo "reload.."
sleep 2

apt install php-cli
echo "install php-cli"
sleep 1
echo "install complite to php-cli"

mkdir /var/www/rasa.link
echo "create /var/www/rasa.link"

chown -R work:work /var/www/rasa.link
echo "chown complite"
sleep 2
#cp ./.htaccess /var/www/rasa.link/

cp ./etc/apache2/sites-available/rasa.link.conf /etc/apache2/sites-available/
echo "cp /etc/apache2/sites-avalible/rasa.conf"
sleep 1
a2ensite rasa.link
echo "turn on site"
sleep 1
a2dissite 000-default
echo "turn off def site"
sleep 1
apache2ctl configtest
echo "configtest complite"
sleep 1 
echo "try first reload"
systemctl reload apache2
echo "first reload resulted"

sleep 1

cp ./etc/apache2/mods-enabled/dir.conf /etc/apache2/mods-enabled/
echo "cp /etc/apache2/mods-enabled/dir.conf"
cp ./etc/apache2/apache2.conf /etc/apache2/
echo "cp /etc/apache2/apache2.conf"
cp ./etc/php/7.4/apache2/php.ini /etc/php/7.4/apache2/
echo "cp /etc/php/7.4/apache2/php.ini"
sleep 1
a2enmod rewrite
echo "turn on rewrite module"
a2enmod ssl
echo "turn on ssl module"
sleep 2
mkdir /etc/apache2/ssl
echo "create /etc/apache2/ssl"
cd /etc/apache2/ssl/
echo "cd /etc/aache2/ssl"
echo "try openssl"
openssl req -new -x509 -days 1461 -nodes -out cert.pem -keyout cert.key -subj "/C=RU/ST=SPb/L=SPb/O=Global Security/OU=IT Department/CN=test.dmosk.local/CN=test"
sleep 2
echo "openssl resulted"
sleep 2
echo "try reload"
systemctl reload apache2
echo "reload resulted"
sleep 2
echo "install server complite"
