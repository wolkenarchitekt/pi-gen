#!/bin/bash -e
#Taken from: https://github.com/RPi-Distro/pi-gen/issues/508
install -m 644 files/docker.list "${ROOTFS_DIR}/etc/apt/sources.list.d/"
sed -i "s/RELEASE/${RELEASE}/g" "${ROOTFS_DIR}/etc/apt/sources.list.d/docker.list"

on_chroot << EOF
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

adduser ${FIRST_USER_NAME} docker
systemctl enable docker.service
systemctl enable containerd.service
EOF
