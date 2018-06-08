DESCRIPTION = "Selection of packages: tools, networking, development"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_${PN} = "\
    avahi-daemon \
    avahi-utils \
    openvpn \
    ethtool \
    iputils \
    net-tools \
    mtd-utils \
    lrzsz \
    ntp \
    "
