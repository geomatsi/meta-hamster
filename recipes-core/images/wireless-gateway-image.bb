SUMMARY = "Wireless gateway image"

LICENSE = "MIT"

IMAGE_INSTALL_append = "packagegroup-wireless-gateway"
IMAGE_FEATURES += "tools-debug ssh-server-dropbear"

inherit core-image
