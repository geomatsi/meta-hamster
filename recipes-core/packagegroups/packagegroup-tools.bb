DESCRIPTION = "Selection of packages: tools, networking, development"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_${PN} = "\
    avahi-daemon \
    avahi-utils \
    mtd-utils \
    lrzsz \
    ntp \
    "
