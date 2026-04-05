# slideshow-pi

Raspberry Pi photo slideshow with Samba network share.

## What it does
- Displays photos from `/srv/photos` as a fullscreen slideshow via mpv
- Automatically reloads when photos are added or removed
- Shares `/srv/photos` on the local network via Samba (Windows compatible)
- SSH enabled for remote access

## Files
| File | Description |
|---|---|
| `slideshow.sh` | Slideshow loop script with inotify file watching |
| `slideshow.service` | systemd service to autostart the slideshow |
| `smb.conf` | Samba config for the photos network share |
| `deploy.sh` | Deployment script, safe to re-run on updates |

## First time setup

### 1. Clone the repo
```bash
sudo git clone https://github.com/toihr/diashow-server.git /opt/slideshow-pi
```

### 2. Deploy (installs all packages)
```bash
sudo bash /opt/slideshow-pi/deploy.sh
```

### 3. Create Samba user
```bash
sudo useradd -M -s /sbin/nologin photos
sudo smbpasswd -a photos
```

## Updating
After pushing changes to the repo, SSH into the Pi and run:
```bash
sudo bash /opt/slideshow-pi/deploy.sh
```

## Connecting to the share
From Windows: `\\<pi-ip>\photos`  
Login with username `photos` and the password you set.

## Remote access
```bash
ssh pi@<pi-ip>
```
Or if hostname is set: `ssh pi@pi.local`

## Settings
| Setting | Location | Default |
|---|---|---|
| Photo duration | `slideshow.sh` | 30 seconds |
| Photos folder | `slideshow.sh` | `/srv/photos` |
| Samba share name | `smb.conf` | `photos` |
