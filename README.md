# Dependencies

This layer depends on:

  URI: git://git.openembedded.org/bitbake
  branch: master

  https://github.com/openembedded/meta-openembedded
  layers: meta-oe meta-python meta-networking
  branch: master

  https://github.com/linux-sunxi/meta-sunxi
  branch: master

  URI: git://github.com/imyller/meta-nodejs.git
  branch: master


# Preliminary setup

## repo tool
Install repo tool
```bash
$ curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
$ chmod a+x ~/bin/repo
```

## Node.js specific dependencies
See details at https://github.com/imyller/meta-nodejs for nodejs prerequisites.
In brief, the following packages should be installed in order to build
images for 32-bit ARM on x86_64 Ubuntu or Debian host:

```bash
$ sudo dpkg --add-architecture i386
$ sudo apt-get update
$ sudo apt-get install g++-multilib libssl-dev:i386 libcrypto++-dev:i386 zlib1g-dev:i386
```

# Hamster images based on Yocto v2.5 Sumo
Yocto Sumo images are based on upstream kernel v4.16 and u-boot v2018.03.
Note that nodejs is built using Morty branch of meta-nodejs layer
in both Morty and Sumo images.

## Fetch Yocto layers

```bash
$ mkdir -p /home/builder/project/source
$ mkdir -p /home/builder/project/build
$ cd /home/builder/project/source
$ repo init -u https://github.com/geomatsi/yocto-manifests.git -b master -m iot-sunxi-sumo.xml
$ repo sync -c
```

## Prepare Yocto build environment

```bash
$ cd poky
$ source oe-init-build-env /home/builder/project/build
```

Yocto configuration files will be stored in /home/builder/project/build/conf directory.

## Edit build settings

### bblayers.conf
Add the following layers to bblayers.conf:

```asciidoc
...

BBLAYERS ?= " \
 /home/builder/project/source/poky/meta \
 /home/builder/project/source/poky/meta-poky \
 /home/builder/project/source/meta-openembedded/meta-oe \
 /home/builder/project/source/meta-openembedded/meta-python \
 /home/builder/project/source/meta-openembedded/meta-networking \
 /home/builder/project/source/meta-nodejs \
 /home/builder/project/source/meta-nodejs-contrib \
 /home/builder/project/source/meta-sunxi \
 /home/builder/project/source/meta-sunxi-contrib \
 /home/builder/project/source/meta-iot-simple \
 /home/builder/project/source/meta-hamster \
 "
...

```

### local.conf

#### Machine specific definitions

1. Orange-Pi Zero

   For Orange-Pi Zero board replace default machine definition with the following:

   ```asciidoc
   MACHINE = "orange-pi-zero"
   ```

Specify kernel module for WiFi chip:

   ```asciidoc
   IMAGE_INSTALL_append = " kernel-module-xradio "
   ```

2. Orange-Pi Zero Plus2

   For Orange-Pi Zero Plus2 board replace default machine definition with the following:

   ```asciidoc
   MACHINE = "orange-pi-zero-plus2"
   ```

Specify firmware for WiFi chip:

   ```asciidoc
   IMAGE_INSTALL_append = " armbian-firmware-brcm "
   ```

3. Orange-Pi PC Plus

   For Orange-Pi PC Plus board replace default machine definition with the following:

   ```asciidoc
   MACHINE = "orange-pi-pc-plus"
   ```

Specify kernel module for WiFi chip:

   ```asciidoc
   IMAGE_INSTALL_append = " kernel-module-rtl8189fs "
   ```

#### Init system

   By default sysvinit init system is enabled on all the images. In order to build
   image with systemd add the following lines at the bottom of local.conf:
   
   ```asciidoc
   DISTRO_FEATURES_append = " systemd"
   DISTRO_FEATURES_BACKFILL_CONSIDERED += "sysvinit"
   VIRTUAL-RUNTIME_init_manager = "systemd"
   VIRTUAL-RUNTIME_initscripts = "systemd-compat-units"
   ```

#### Parallel build

   Add the following lines at the bottom of local.conf in order to explicitely
   specify parallel build constraints:
   
   ```asciidoc
   PARALLEL_MAKE = "-j 2"
   BB_NUMBER_THREADS = "2"
   ```

## Building images

```bash
$ bitbake iot-image-base
$ bitbake iot-image-web
```

## Customizing images

### WiFi connection
Set SSID and PSK in wpa_supplicant configuration file:

```bash
vi /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
```

### VPN connection
Setup OpenVPN client:

```bash
vi /etc/openvpn/client.conf
vi /etc/openvpn/pass
```

Update openvpn systemd unit file /etc/systemd/system/multi-user.target.wants/openvpn@client.service
to start OpenVPN only when network connection is up and online:

```ascii
After=syslog.target network-online.target
Wants=network-online.target
```

### NRF24 configuration 
Configure NRF24 board and radio settings:

```bash
vi /etc/nrf24/default.cfg
```
