systemctl stop mafia-game-server
systemctl stop mafia-game-client

cd game/
git stash
git pull --rebase

cd game/server
cargo build

cd ../client
npm install

systemctl start mafia-game-server
systemctl start mafia-game-client
