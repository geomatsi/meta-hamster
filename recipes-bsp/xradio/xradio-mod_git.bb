SUMMARY = "Kernel module and firmware for xr819 WiFi chip"
LIC_FILES_CHKSUM = "file://LICENSE;md5=a23a74b3f4caf9616230789d94217acb"
LICENSE = "GPLv2"

SRCREV = "014dfdd203102c5fd2370a73ec4ae3e6dd4e9ded"

inherit module

PV = "1.1+git${SRCPV}"
PR = "r0"

SRC_URI = "git://github.com/geomatsi/xradio.git;protocol=https \
        file://boot_xr819.bin \
        file://sdd_xr819.bin \
        file://fw_xr819.bin \
        "

COMPATIBLE_MACHINE = "orange-pi-zero"

S = "${WORKDIR}/git"

EXTRA_OEMAKE += "-C ${STAGING_KERNEL_DIR} M=${S}"

do_install_append () {
	install -d ${D}/lib/firmware/xr819/
	install -m 0644 ${WORKDIR}/boot_xr819.bin ${D}/lib/firmware/xr819/
	install -m 0644 ${WORKDIR}/sdd_xr819.bin ${D}/lib/firmware/xr819/
	install -m 0644 ${WORKDIR}/fw_xr819.bin ${D}/lib/firmware/xr819/
}

FILES_${PN} += "/lib/firmware/xr819/*"
