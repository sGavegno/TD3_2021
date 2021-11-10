SRCPATH = ./src/
OBJPATH = ./obj/
COMPATH = ./comons/
PUERTO = 10101

CC = gcc
OFLAGS = -lm -o   
CFLAGS = -c -Wall
OUTPUT = ServidorWeb.exe
OBJETO = $(OBJPATH)ServidorWeb.o $(OBJPATH)funciones.o $(OBJPATH)funcSIMD.o $(OBJPATH)configuracion.o $(OBJPATH)config.o $(OBJPATH)string.o $(OBJPATH)dictionary.o

all: $(OBJETO) 
	$(CC) $(OBJETO) $(OFLAGS) $(OUTPUT)	

$(OBJPATH)ServidorWeb.o: $(SRCPATH)ServidorWeb.c
	$(CC) $< $(CFLAGS) -o $@

$(OBJPATH)funciones.o: $(SRCPATH)funciones.c
	$(CC) $< $(CFLAGS) -o $@

$(OBJPATH)funcSIMD.o: $(SRCPATH)funcSIMD.c
	$(CC) $< $(CFLAGS) -o $@

$(OBJPATH)configuracion.o: $(SRCPATH)configuracion.c
	$(CC) $< $(CFLAGS) -o $@

$(OBJPATH)config.o: $(COMPATH)config.c 
	$(CC) $< $(CFLAGS) -o $@

$(OBJPATH)string.o: $(COMPATH)string.c 
	$(CC) $< $(CFLAGS) -o $@

$(OBJPATH)dictionary.o: $(COMPATH)collections/dictionary.c
	$(CC) $< $(CFLAGS) -o $@
	
run:	
	./$(OUTPUT) $(PUERTO)

clean:

	rm ./obj/*.o *.exe 