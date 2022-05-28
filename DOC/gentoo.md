# Gentoo Cheatsheet

## Portage

### Update system

    emerge --sync && emerge -avuDNt && emerge --depclean

### List explicitly installed packages

    cat /var/lib/portage/world

## Networking

### Connect to new wifi

    wpa_passphrase <SSID> <PASSWORD> >> /etc/wpa_supplicant/wpa_supplicant.conf
