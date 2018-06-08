FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append += " \
	file://client.conf \
	file://pass \
	"

do_install_append() {
	install -d ${D}${sysconfdir}/openvpn
	install -m 0644 ${WORKDIR}/client.conf ${D}${sysconfdir}/openvpn/
	install -m 0644 ${WORKDIR}/pass ${D}${sysconfdir}/openvpn/

	install -d ${D}${sysconfdir}/openvpn/resolv
	install -m 0755 ${S}/contrib/pull-resolv-conf/client.up ${D}${sysconfdir}/openvpn/resolv/
	install -m 0755 ${S}/contrib/pull-resolv-conf/client.down ${D}${sysconfdir}/openvpn/resolv/

	if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
		install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants
		ln -s ${systemd_unitdir}/system/openvpn@.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/openvpn@client.service
	fi
}
