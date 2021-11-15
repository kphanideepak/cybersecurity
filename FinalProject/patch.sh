!/bin/bash

# set variables
wp_location="/var/www/html/wordpress"
stevens_ip="192.168.1.136" #picked a random one for the example 

##############################
# Fix for Weak Authntication #
##############################

# backup the files
cp -f /etc/pam.d/common-password /etc/pam.d/common-password.bak 
cp -f /etc/login.defs /etc/login.defs.bak

# create the updated stream
cat /etc/pam.d/common-password | sed -E 's/pam_unix.so obscure sha512/am_unix.so obscure sha512 minlen=8/g' | sed -E 's/pam_permit.so/pam_permit.so minlen=12 lcredit=1 ucredit=1 dcredit=2 ocredit=1/g' > /etc/pam.d/common-password.new
# cat /etc/login.defs | sed -E 's/PASS_MAX_DAYS */PASS_MAX_DAYS 100 /g' > /etc/login.defs.new

sed -i -e '/PASS_MAX_DAYS/s/99999/90/' /etc/login.defs

# replace the originals
mv -f /etc/pam.d/common-password.new /etc/pam.d/common-password
#mv -f /etc/login.defs.new /etc/login.defs


##############################
# Fix for SSH Authentication #
##############################

# Change SSH deamon settings
sed -i -e '/ChallengeResponseAuthentication/s/yes/no/' /etc/ssh/ssd_config
sed -i -e '/PasswordAuthentication/s/yes/no/' /etc/ssh/ssd_config
sed -i -e '/UsePAM/s/yes/no/' /etc/ssh/ssd_config
sed -i -e '/PermitRootLogin/s/yes/no/' /etc/ssh/ssd_config
#sed -i -e '/PermitRootLogin/s//no/' /etc/ssh/ssd_config

# Configure UFW rules
sudo ufw allow from $stevens_ip proto tcp to any port 22

######################################
# Fix for wp-config file permissions #
######################################

chmod 400  $wp_location/wp-config.php
