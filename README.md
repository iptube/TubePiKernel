# Tube Pi Kernel
A raspberry Pi (and other Linux) netfilter kernel module to deal with SPUD packets

## Cross compiling on Linux (ubuntu)
Setting up the raspberry pi with the right kernel src and compiling a new kernel is painful.
It is recommended to cross-compile a new kernel and the modules on another Linux box.
(Or os-x (BSD) if you are feeling lucky)

### Cross-compile kernel on Ubuntu
1. Install compiler and tools

apt-get install gcc-arm-linux-gnueabi make ncurses-dev

2. Create some handy directories

mkdir kernel  
mkdir modules

3. Get kernel src (Make sure you have enough memory or swap space)

git clone https://github.com/raspberrypi/linux.git

4. Set env variables

export KERNEL_SRC=/home/palmarti/development/raspberry/linux/  
export CCPREFIX=/usr/bin/arm-linux-gnueabi-  
export MODULES_TEMP=/home/palmarti/development/raspberry/modules/  

5. Prepare kernel compilation

cd linux
make mrproper

6. Copy kernel config from this repo

cp ../pi-kernel-config .config

7. Compile kernel  
make ARCH=arm CROSS_COMPILE=${CCPREFIX} oldconfig  
make ARCH=arm CROSS_COMPILE=${CCPREFIX} -j4  
make ARCH=arm CROSS_COMPILE=${CCPREFIX} -j4 modules  
make ARCH=arm CROSS_COMPILE=${CCPREFIX} INSTALL_MOD_PATH=${MODULES_TEMP} modules_install  

8. Make a nice package  
cd ..  
cd tools/mkimage  
./imagetool-uncompressed.py ${KERNEL_SRC}/arch/arm/boot/zImage  
cd ../..  
cp tools/mkimage/kernel.img kernel/kernel_cross.img  
tar zczf kernel_pi.tar.gz modules/lib/ kernel/  

9. Transfer the kernel_pi.tar.gz to the pi and ubdate /usr/lib and what kernel to boot

### Cross compile module

1. Set env variables  
CCPREFIX=/usr/bin/arm-linux-gnueabi-  

2. Call make  
⋅make ARCH=arm CROSS_COMPILE=${CCPREFIX} KERNEL_HEADERS=/home/palmarti/development/raspberry/modules/lib/modules/3.18.9+/build

