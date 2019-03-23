
#!/bin/bash
#clear
#
#                                             [HM-NETWORK]
#
#                                Title   [    install-banners.sh      ]
#                                Date    [ 16 - Mar - 2019            ]
#                                Authors [ Sean Murphy,               ]

# Check if run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Depend's
apt install wget -y

# Setup working dir
mkdir /tmp/banners
cd /tmp/banners

# Get files
wget https://raw.githubusercontent.com/m99t/m9MoTD/master/issue.net
wget https://raw.githubusercontent.com/m99t/m9MoTD/master/motd.sh

# Install MOTD
chmod -x /etc/update-motd.d/*
chmod +x /tmp/banners/motd.sh
rm -rf /etc/profile.d/motd.sh
mv /tmp/banners/motd.sh /etc/profile.d/motd.sh

# Install SSHD Banner
rm -rf /etc/issue.net
mv /tmp/banners/issue.net /etc/issue.net
echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config
service sshd restart

# Cleanup
rm -rf /tmp/banners

echo "Install complete!"
