cd /
apt-get update
apt-get upgrade -y
apt-get install -y curl nano sudo git build-essential

mkdir /mafia-app
cd /mafia-app

curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


curl -O https://dl.google.com/go/go1.20.4.linux-amd64.tar.gz
tar xvf go1.20.4.linux-amd64.tar.gz
chown -R root:root ./go
mv go /usr/local
echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile

git clone https://github.com/jpdagostino/mafia-update-manager.git updater
cd updater

ln -s /mafia-app/updater/mafia-update-manager.service /etc/systemd/system/mafia-update-manager.service
ln -s /mafia-app/updater/mafia-game-client.service /etc/systemd/system/mafia-game-client.service
ln -s /mafia-app/updater/mafia-game-server.service /etc/systemd/system/mafia-game-server.service

cp mafia /etc/sudoers.d

adduser -disabled-password --gecos "" mafia
usermod -aG sudo mafia

chmod +x auth.sh

chown -R mafia:mafia /mafia-app
runuser -l mafia -c './auth.sh'


systemctl daemon-reload

systemctl enable mafia-update-manager
systemctl enable mafia-game-client
systemctl enable mafia-game-server

systemctl start mafia-update-manager
systemctl start mafia-game-client
systemctl start mafia-game-server