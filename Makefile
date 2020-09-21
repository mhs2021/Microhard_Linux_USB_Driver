KERNELDIR := /lib/modules/$(shell uname -r)/build
PWD       := $(shell pwd)

obj-m+=./drivers/usb/serial/usb_wwan.o
obj-m+=./drivers/usb/serial/option.o
obj-m+=./drivers/usb/serial/qcserial.o
obj-m+=./drivers/net/usb/qmi_wwan.o
obj-m+=./drivers/net/usb/cdc_mbim.o

modules: clean
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules

install: modules
	cp $(PWD)/drivers/usb/serial/option.ko /lib/modules/$(shell uname -r)/kernel/drivers/usb/serial/
	cp $(PWD)/drivers/usb/serial/usb_wwan.ko /lib/modules/$(shell uname -r)/kernel/drivers/usb/serial/
	cp $(PWD)/drivers/usb/serial/qcserial.ko /lib/modules/$(shell uname -r)/kernel/drivers/usb/serial/
	cp $(PWD)/drivers/net/usb/qmi_wwan.ko /lib/modules/$(shell uname -r)/kernel/drivers/net/usb/
	cp $(PWD)/drivers/net/usb/cdc_mbim.ko /lib/modules/$(shell uname -r)/kernel/drivers/net/usb/
	
	#remove qmi_wwan.ko since LTESQ-CAT4 is using mbim.
	rm /lib/modules/$(shell uname -r)/kernel/drivers/net/usb/qmi_wwan.ko
	
	modprobe -r option qcserial  cdc_mbim
	depmod

clean:
	rm -rf *~ .tmp_versions modules.order Module.symvers
	find . -type f -name *~ -o -name *.o -o -name *.ko -o -name *.cmd -o -name *.mod.c |  xargs rm -rf

