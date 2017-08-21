#
# systemd service file for node-red
#

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append += "file://node-red.service"

inherit systemd useradd

SYSTEMD_SERVICE_${PN} = "node-red.service"

USERADD_PACKAGES = "${PN}"
USERADD_PARAM_${PN} = " --system --no-create-home  --shell /bin/false --user-group node"

do_install_append() {
	# install systemd unit
	install -d ${D}${systemd_unitdir}/system/
	install -m 0644 ${WORKDIR}/node-red.service ${D}${systemd_unitdir}/system/

	# create node-red working dir
	install -d -m 755 ${D}${servicedir}/node

	# install extra nodes
	cd ${D}${servicedir}/node
	oe_runnpm install node-red-contrib-thingspeak42
	oe_runnpm install node-red-contrib-telegrambot

	# configure access rights: node-red is running as node:node
	chown -R node ${D}${servicedir}/node
	chgrp -R node ${D}${servicedir}/node
}

FILES_${PN} += "${servicedir}/node"
FILES_${PN} += "${systemd_unitdir}/system/node-red.service"
