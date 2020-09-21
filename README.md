# Introduction

Microhard USB Serial Driver for LTESQ-CAT4.

# Prepare

Ubuntu 16.04 running kernel 4.15.0-117-generic.

```
$ uname -a
Linux ubuntu 4.15.0-117-generic #118-Ubuntu SMP Fri Sep 4 20:02:41 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

```

Download Ubuntu linux headers:

```
$ sudo apt-get install linux-headers-$(uname -r)
```

the Linux headers will be located in /usr/src/

# Compile/Install

Determine the kernel version:

```
$ uname -r

```
Checkout the driver to the correct kernel version:

```
$ git clone https://github.com/mhs2021/Microhard_Linux_USB_Driver.git
$ cd Microhard_USB_Serial_Driver
$ git checkout 4.15.0
$ make 
$ sudo make install

```

# Data connection via MBIM

Install ModemManager

```
$ sudo apt-get update
$ sudo apt-get install modemmanager libqmi-utils libmbim-utils policykit-1

```
Check cdc-wdm device

```
$ ls /dev/cdc-wdm*

```

Use libmbim-utils, assume WDM device is /dev/cdc-wdm0

```
$ sudo touch /etc/mbim-network.conf
$ sudo echo "APN=properapn" > /etc/mbim-network.conf 
$ sudo echo "PROXY=yes" >>   /etc/mbim-network.conf 
$ sudo mbim-network /dev/cdc-wdm0 start
$ sudo mbim-network /dev/cdc-wdm0 status 

```

Launch ModemManager

```
$ sudo ModemManager start

```

# Credit

Modified based on original author
