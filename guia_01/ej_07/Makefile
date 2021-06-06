.PHONY: clean

BINPATH = ./bin/
DOCPATH = ./doc/
INCPATH = ./inc/
LIBPATH = ./lib/
SRCPATH = ./src/
SUPPATH = ./sup/

AC = nasm
CC = gcc
LD = ld

AFLAGS = -f elf32
LDFLAGS = -z max-page-size=0x1000 --oformat=binary -m elf_i386
LFLAGS = -z max-page-size=0x1000 -m elf_i386
ODFLAGS = -CprsSx --prefix-addresses
CFLAGS = -c -m32 -fno-stack-protector -fno-asynchronous-unwind-tables -Wall -fno-PIC

LDSCRIPT = linker.ld
RESET = reset_vector
ROM_NAME = mi_rom
OBJS = $(BINPATH)funciones.o $(BINPATH)handler.o $(BINPATH)init32.o $(BINPATH)main.o $(BINPATH)reset.o $(BINPATH)sys_datos.o $(BINPATH)sys_tables.o $(BINPATH)tareas.o 

all: $(BINPATH)$(ROM_NAME).bin $(BINPATH)$(ROM_NAME).elf
	@echo	''
	@echo	'-----> Generando listado de hexadecimales y ELFs'
	hexdump -C $(BINPATH)$(ROM_NAME).bin > $(DOCPATH)$(ROM_NAME)_hexdump.txt
	objdump $(ODFLAGS) $(BINPATH)$(ROM_NAME).elf > $(DOCPATH)$(ROM_NAME)_objdump.txt
	readelf -a $(BINPATH)$(ROM_NAME).elf > $(DOCPATH)$(ROM_NAME)_readelf.txt
	@echo	''

$(BINPATH)$(ROM_NAME).bin: $(OBJS)
	@echo	'-----> Linkeando en formato binario'
	$(LD) $(LDFLAGS) -o $@ $(OBJS) -T $(LDSCRIPT) -e $(RESET)

$(BINPATH)$(ROM_NAME).elf: $(OBJS)
	@echo	'-----> Linkeando en formato ELF'
	$(LD) -z max-page-size=0x1000 -m elf_i386 -T $(LDSCRIPT) -Map=$(ROM_NAME) -e $(RESET) $(OBJS) -o $@

$(BINPATH)init16.bin: $(SRCPATH)init16.asm 
	@echo	'-----> Compilando init16.asm'
	$(AC) -f bin $< -o $@ -l $(DOCPATH)init16.lst

$(BINPATH)reset.o: $(SRCPATH)reset.asm
	@echo	'-----> Compilando reset.asm'
	$(AC) $(AFLAGS) $< -o $@ -l $(DOCPATH)reset.lst

$(BINPATH)init32.o: $(SRCPATH)init32.asm $(BINPATH)init16.bin
	@echo	'-----> Compilando init32.asm'
	$(AC) $(AFLAGS) $< -o $@ -l $(DOCPATH)init32.lst

$(BINPATH)main.o: $(SRCPATH)main.asm
	@echo	'-----> Compilando main.asm'
	$(AC) $(AFLAGS) $< -o $@ -l $(DOCPATH)main.lst

$(BINPATH)sys_tables.o: $(SRCPATH)sys_tables.asm
	@echo	'-----> Compilando sys_tables.asm'
	$(AC) $(AFLAGS) $< -o $@ -l $(DOCPATH)sys_tables.lst

$(BINPATH)handler.o: $(SRCPATH)handler.asm
	@echo	'-----> Compilando handler.asm'
	$(AC) $(AFLAGS) $< -o $@ -l $(DOCPATH)handler.lst

$(BINPATH)sys_datos.o: $(SRCPATH)sys_datos.asm
	@echo	'-----> Compilando sys_datos.asm'
	$(AC) $(AFLAGS) $< -o $@ -l $(DOCPATH)sys_datos.lst

$(BINPATH)tareas.o: $(SRCPATH)tareas.asm
	@echo	'-----> Compilando tareas.asm'
	$(AC) $(AFLAGS) $< -o $@ -l $(DOCPATH)tareas.lst

$(BINPATH)funciones.o: $(SRCPATH)funciones.c
	@echo	'-----> Compilando funciones.asm'
	$(CC) $(CFLAGS) $< -o $@

bochs:
	@echo '-------> Llamando a bochs'
	bochs -qf bochs.cfg

git:
	git add .		
	git commit -m "$(arg)"
	git push -u origin master

clean:
	@echo limpiando carpeta..
	rm $(BINPATH)*.bin $(BINPATH)*.elf $(BINPATH)*.o $(DOCPATH)*.lst *.map *.ini
	
