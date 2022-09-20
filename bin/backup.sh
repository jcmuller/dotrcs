#!/bin/bash

set -euxo pipefail

REMOTE_HOST=jcmuller@192.168.20.3
NAME="$(hostname)"
REMOTE_PATH="/mnt/pool0/backups/$NAME"
BASE="${REMOTE_HOST}:${REMOTE_PATH}"
RESTORE_TEMPFILE_PATH=$(mktemp)

RESTORE_PATH="$BASE/restore.sh"

cat <<'EOF' >"$RESTORE_TEMPFILE_PATH"
#!/bin/bash -ex

VERSION=$(date +"%Y%m%d%H%M")
BASE=192.168.20.3:/mnt/pool0/backups/$(hostname)
ETC=$BASE/etc/$(ls -1 $BASE/etc/ | tail -1)/etc
HOME=$BASE/home/$(ls -1 $BASE/home/ | tail -1)/jcmuller

sudo mv /etc/apt/sources.list /etc/apt/sources.list.$VERSION
sudo cp $ETC/apt/sources.list /etc/apt/sources.list
sudo cp -r $ETC/apt/sources.list.d/*.list /etc/apt/sources.list.d

sudo apt-key add $BASE/keys
sudo apt install -y apt-transport-https ca-certificates dselect
sudo apt update
sudo dselect update
sudo dpkg --set-selections < packages.list
sudo apt-get dselect-upgrade -y

for i in opt usr/local/bin
do
  LAST=$(ls -1 $BASE/$i/ | tail -1)
  sudo rsync -avzzpl \
    --stats \
    --progress \
    "${BASE}/${i}/${LAST}/$(basename ${i})/" \
    "/${i}/"
done

sudo rsync \
  -avzzpl \
  --stats \
  --progress \
  "${BASE}/home/${VERSION}/jcmuller/"
  /home/jcmuller/

[[ -x "/usr/bin/dconf" ]] && dconf load / gsettings.conf
crontab $BASE/crontab-backup
EOF

sudo dpkg-query -f '${binary:Package}\n' -W | sudo tee ~/Desktop/packages.list
[[ -x "/usr/bin/dconf" ]] && dconf dump / >~/Desktop/gsettings.conf

VERSION="$(hostname)-$(date +"%Y%m%d%H%M")"

for i in etc opt usr/local/bin; do
  # shellcheck disable=SC2029
  ssh "$REMOTE_HOST" mkdir -p "$REMOTE_PATH/$i"
  # shellcheck disable=SC2029
  LAST=$(ssh "$REMOTE_HOST" ls -1 "$REMOTE_PATH/$i/" | tail -1)
  sudo rsync -avzzpl \
    --stats \
    --progress \
    "/$i" \
    --link-dest="${REMOTE_PATH}/${i}/${LAST}" \
    "${BASE}/${i}/${VERSION}/"
done

# shellcheck disable=SC2029
ssh "$REMOTE_HOST" mkdir -p "$REMOTE_PATH/home"
# shellcheck disable=SC2029
LAST=$(ssh "$REMOTE_HOST" ls -1 "$REMOTE_PATH/home/" | tail -1)
sudo rsync \
  -avzzpl \
  --stats \
  --progress \
  --exclude .asdf/installs \
  --exclude .asdf/tags \
  --exclude .bundle/cache \
  --exclude .cache \
  --exclude .config/Slack/Cache \
  --exclude .dropbox \
  --exclude .dropbox-dist \
  --exclude .minikube \
  --exclude .xsession-errors* \
  --exclude Development/Greenhouse/greenhouse/log \
  --exclude Development/Greenhouse/jben/log \
  --exclude Downloads \
  --exclude Dropbox \
  --exclude .dropbox \
  --exclude .dropbox-dist \
  --exclude Nextcloud \
  --exclude robocode \
  --exclude snap \
  --exclude .minikube \
  --exclude .xsession-errors* \
  --exclude tmp \
  /home/jcmuller \
  --link-dest="${REMOTE_PATH}/home/${LAST}" \
  "${BASE}/home/${VERSION}"

rsync "$RESTORE_TEMPFILE_PATH" "$RESTORE_PATH"
rsync ~/Desktop/packages.list "$BASE"/
rsync ~/Desktop/gsettings.conf "$BASE"/

cron=$(mktemp)
crontab -l >"$cron"
rsync "$cron" "$BASE"/crontab
