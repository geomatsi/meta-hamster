#
#
#

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://eth.network file://wlan.network"

PACKAGECONFIG += "networkd resolved"
FILES_${PN} += "{sysconfdir}/systemd/network/*"

do_install_append() {
	install -d ${D}${sysconfdir}/systemd/network/
	install -m 0644 ${WORKDIR}/*.network ${D}${sysconfdir}/systemd/network/
}
