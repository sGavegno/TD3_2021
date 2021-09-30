SRCPATH = ./src
OBJPATH = ./obj

CC = gcc
OFLAGS = -lm -o   
CFLAGS = -c -Wall
OUTPUT = ServidorWeb.exe
OBJETO = ServidorWeb.o funciones.o


all: $(OBJETO) 
	$(CC) $(OBJETO) $(OFLAGS) $(OUTPUT)	

ServidorWeb.o: $(SRCPATH)/ServidorWeb.c
	$(CC) $< $(CFLAGS)

funciones.o: $(SRCPATH)/funciones.c
	$(CC) $< $(CFLAGS)

run:	
	./$(OUTPUT) $(arg)

clean:

	rm *.o *.exe