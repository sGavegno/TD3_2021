NAME_MOD = I2Cdriver
obj-m := src/$(NAME_MOD).o


KERNELDIR = /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

#compila el modulo haciendo una llamada al Makefile que esta en '/lib/modules/$(shell uname -r)/build'
all: 
	make -C $(KERNELDIR) M=$(PWD) modules

#revisa si el modulo esta instalado
cat:
	cat /proc/modules | grep $(NAME_MOD)

#instala el modulo
insmod:
	sudo insmod src/$(NAME_MOD).ko

#desinstala el modulo
rmmod:
	sudo rmmod $(NAME_MOD)

#muestra los mensajes (dmesg), en el ejemplo todos los printk imprimen el nombre del archivo
dmesg:
	dmesg | grep $(NAME_MOD) 

info:
	modinfo src/$(NAME_MOD).ko

tail:
	tail -f /var/log/syslog

clean:
	rm -rf *.o core .depend .*.cmd *.mod.c *.mod *.ko .tmp_versions modules.* Module* *.save
