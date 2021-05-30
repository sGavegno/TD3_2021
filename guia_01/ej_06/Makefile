.PHONY: clean
AC = nasm
CC = gcc
LD = ld
AFLAGS = -f elf32
LDFLAGS = -z max-page-size=0x1000 --oformat=binary -m elf_i386
LFLAGS = -z max-page-size=0x1000 -m elf_i386
ODFLAGS = -CprsSx --prefix-addresses
LDSCRIPT = linker.ld
RESET = reset_vector
ROM_NAME = mi_rom
OBJS = reset.o init32.o main.o sys_tables.o sys_tables_idt.o handler.o

all: $(ROM_NAME).bin $(ROM_NAME).elf
	@echo	''
	@echo	'-----> Generando listado de hexadecimales y ELFs'
	hexdump -C $(ROM_NAME).bin > $(ROM_NAME)_hexdump.txt
	objdump $(ODFLAGS) $(ROM_NAME).elf > $(ROM_NAME)_objdump.txt
	readelf -a $(ROM_NAME).elf > $(ROM_NAME)_readelf.txt
	@echo	''

$(ROM_NAME).bin: $(OBJS)
	@echo	'-----> Linkeando en formato binario'
	$(LD) $(LDFLAGS) -o $@ $(OBJS) -T $(LDSCRIPT) -e $(RESET)

$(ROM_NAME).elf: $(OBJS)
	@echo	'-----> Linkeando en formato ELF'
	$(LD) -z max-page-size=0x1000 -m elf_i386 -T $(LDSCRIPT) -Map=$(ROM_NAME) -e $(RESET) $(OBJS) -o $@

init16.bin: init16.asm sys_tables.o
	@echo	'-----> Compilando init16.asm'
	$(AC) -f bin $< -o $@ -l init16.lst

reset.o: reset.asm
	@echo	'-----> Compilando reset.asm'
	$(AC) $(AFLAGS) $< -o $@ -l reset.lst

init32.o: init32.asm init16.bin
	@echo	'-----> Compilando init32.asm'
	$(AC) $(AFLAGS) $< -o $@ -l init32.lst

main.o: main.asm
	@echo	'-----> Compilando main.asm'
	$(AC) $(AFLAGS) $< -o $@ -l main.lst

sys_tables.o: sys_tables.asm
	@echo	'-----> Compilando sys_tables.asm'
	$(AC) $(AFLAGS) $< -o $@ -l sys_tables.lst

sys_tables_idt.o: sys_tables_idt.asm
	@echo	'-----> Compilando sys_tables.asm'
	$(AC) $(AFLAGS) $< -o $@ -l sys_tables.lst

handler.o: handler.asm
	@echo	'-----> Compilando handler.asm'
	$(AC) $(AFLAGS) $< -o $@ -l handler.lst

bochs:
	@echo '-------> Llamando a bochs'
	bochs -qf bochs.cfg

git:
	git add .		
	git commit -m "texto"
	git push -u origin master

clean:
	@echo limpiando carpeta..
	rm *.bin *.elf *.o *.lst *.map *.ini 
	
