systemctl stop mafia-game-server
systemctl stop mafia-game-client

rm -rf /mafia-app/game
git clone https://github.com/ItsSammyM/mafia-rust.git game
git pull origin production

cd game/server
cargo build

cd ../client
npm install

systemctl start mafia-game-server
systemctl start mafia-game-client