FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

inherit kernel

SRCREV_pn-${PN} = "745851c5bd2bf69176bc5231671f1c1e84394a50"

# kernel with more h/w features integrated for sunxi orange/pcduino boards:
#	EMAC, SPI, NOR, XR819
SRC_URI = " \
	git://github.com/geomatsi/linux.git;protocol=https;branch=sunxi-boards \
	file://defconfig \
	"
