#
# enable wpa_supplicant for wlan0
#

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append += "file://wpa_supplicant-wlan0.conf"

do_install_append() {
	install -d ${D}${sysconfdir}/wpa_supplicant/
	install -m 0644 ${WORKDIR}/wpa_supplicant-wlan0.conf ${D}${sysconfdir}/wpa_supplicant/

	if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
		install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants
		ln -s ${systemd_unitdir}/system/wpa_supplicant@.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/wpa_supplicant@wlan0.service
	fi
}
