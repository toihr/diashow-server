#!/bin/bash
set -e

cd /opt/slideshow-pi
git pull

# Only install missing packages
for pkg in mpv inotify-tools samba; do
  dpkg -l "$pkg" &>/dev/null || apt install -y "$pkg"
done

mkdir -p /srv/photos
chmod 777 /srv/photos

cp -u slideshow.sh /usr/local/bin/slideshow.sh
chmod +x /usr/local/bin/slideshow.sh
cp -u slideshow.service /etc/systemd/system/slideshow.service
cp -u smb.conf /etc/samba/smb.conf

systemctl daemon-reload
systemctl enable --now ssh smbd slideshow
systemctl restart slideshow

echo "Done! Share at \\\\$(hostname -I | awk '{print $1}')\\photos"
