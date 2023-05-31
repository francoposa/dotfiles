#!/bin/bash
# This needs to run as sudo.
# After completion, recommend running:
# ps aux | grep clam
# Which should show /usr/bin/freshclam and /usr/sbin/clamd both running
# Only tested to run on fedora 38, extremely unpolished, etc.

if [ "$USER" != 'root' ]
  then echo "Please run as root"
  exit
fi
echo "Running as root!"

echo "Installing clamav and dependencies..."
dnf install clamav clamav-update clamd -y

echo "Setting freshclam config ..."
clamconf -g freshclam.conf > /etc/freshclam.conf
sed -i 's/Example/#Example/' /etc/freshclam.conf
sed -i 's/#DatabaseMirror database.clamav.net/DatabaseMirror database.clamav.net/' /etc/freshclam.conf
chown clamupdate:clamupdate freshclam.conf

echo "Running freshclam to get virus definitions..."
freshclam

echo "Setting scan.conf ..."
sed -i 's/#LocalSocket \/run\/clamd.scan\/clamd.sock/LocalSocket \/run\/clamd.scan\/clamd.sock/' /etc/clamd.d/scan.conf
sed -i 's/#LocalSocketMode 660/LocalSocketMode 660/' /etc/clamd.d/scan.conf

echo "Enabling service ..."
systemctl enable clamav-freshclam --now
systemctl enable clamd@scan.service --now
