#!/bin/bash

ISO=$1
TAG=$2

# Mount ISO
mkdir rootfs
sudo mount -o loop "$ISO" rootfs

# Unpack Filesystem
mkdir unsquashfs
sudo unsquashfs -f -d unsquashfs rootfs/live/filesystem.squashfs

# Create Docker Image
IMAGE=$(sudo tar -C unsquashfs -c . | docker import - foltik/vyos)
docker tag "$IMAGE" foltik/vyos:$TAG
