SUMMARY = "simple nodejs app to display board system and sensor data"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690"

SRCREV = "${AUTOREV}"

PR = "r0"
PV = "0.0.1+git${SRCPV}"

SRC_URI = "git://git@github.com/geomatsi/node-sensor-test.git;branch=master;protocol=https"

inherit npm-install bower-install

S = "${WORKDIR}/git"

do_install () {
    install -d ${D}/www/sensor
    install -d ${D}/www/sensor/public

	install -m 0644 ${S}/service.js ${D}/www/sensor/service.js
	install -m 0644 ${S}/public/flot.css ${D}/www/sensor/public/flot.css
	install -m 0644 ${S}/public/index.html ${D}/www/sensor/public/index.html

    cp -r ${S}/config ${D}/www/sensor/

    cp -r ${S}/node_modules ${D}/www/sensor/
    cp -r ${S}/public/bower_components ${D}/www/sensor/public/
}


FILES_${PN} = "/www/sensor"
