DESCRIPTION = "IoT packages"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_${PN} = "\
    wireless-tools \
    wpa-supplicant \
    hostapd \
    iw \
    ntp \
    bluez5 \
    connman \
    neard \
    mosquitto \
    dnsmasq \
    tcpdump \
    bridge-utils \
    arptables \
    ipsec-tools \
    lowpan-tools \
    nrf24-tools \
    irda-utils \
    i2c-tools \
    ethtool \
    iputils \
    net-tools \
    spitools \
    lrzsz \
    avahi-daemon \
    avahi-utils \
    "
