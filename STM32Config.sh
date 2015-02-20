#!/bin/bash

#HABILITACIÓN DEL USB
sudo su
cd /etc/udev/rules.d
echo '"SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3744", MODE="0666"' > 45-usb-stlink-v2.rules

#TOOLCHAIN
sudo add-apt-repository ppa:terry.guo/gcc-arm-embedded -y
sudo apt-get update
sudo apt-get install gcc-arm-none-eabi

#DESCARGAR Y CARGAR STLINK
sudo apt-get install --yes autoconf pkg-config libusb-1.0 git
cd ~
git clone https://github.com/texane/stlink stlink.git
cd ~/stlink.git
./autogen.sh
./configure
sudo Make

#DESCARGAR STM32 LIBRERÍAS Y PARPADEO EJEMPLO
cd ~
sudo git clone git://github.com/libopencm3/libopencm3.git
cd libopencm3
sudo make
sudo make install

#Actualizamos variable de entorno
echo OPENCM3_DIR=$OPENCM3_DIR:/usr/local/arm-none-eabi >> $HOME/.bashrc


sudo git clone https://github.com/libopencm3/libopencm3-examples
#cd libopencm3-examples
cd ..

sudo git submodule init
sudo git submodule update
sudo make
