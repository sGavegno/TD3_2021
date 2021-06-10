
#include "../inc/funciones.h"


__attribute__(( section(".funciones"))) void buffer_Push(buff* buff_p,byte Dato)
{
	if(Dato >= 0x00 & Dato <= 0X15 )
	{	
		if(buff_p->Cant < BUFF_SIZE)
		{
			buff_p->buffer[buff_p->In] = Dato;
			buff_p->Cant++;
			buff_p->In++;
			if(buff_p->In == BUFF_SIZE)
			{
				buff_p->In = 0;
			}
		}
		else
		{
			//funcion para cargar tabla
			/*
				flag_simular_enter
			*/
		}
	}
}

__attribute__(( section(".funciones"))) byte buffer_Pop(buff* buff_p) 
{
	byte retorno = 0xFF;

	if(buff_p->Cant > 0)	
	{
		retorno = buff_p->buffer[buff_p->Out];
		buff_p->Cant--;
		buff_p->Out++;
		if(buff_p->Out == BUFF_SIZE)
		{
			buff_p->Out = 0;
		}
		return retorno;
	}
	else
	{	
		return retorno;				//Buffer vacio
	}
}

__attribute__(( section(".funciones"))) void buffer_Clear(buff* buff_p)
{
	static int i=0;

    buff_p->In = 0;                            
    buff_p->Out = 0;          
	for(i=0; i<LONG_BUFFER; i++)
	{
	    buff_p->buffer[i] = 0;
	}               
           
    buff_p->Cant = 0;      
}

__attribute__(( section(".funciones"))) void cargar_tabla(t_datos* table_p, buff* buff_p)
{
	static char indice = 1;
	word i=0;
	byte dato = 0xFF;
	dword numero = 0;

//saco el numero del buffer y lo ordeno
	for(i = 0; i < LONG_BUFFER; i++)
	{
		dato = buffer_Pop(buff_p);	
		if( dato != 0xFF)
		{
			numero = numero*10 + dato;
		}
	}
//cargo la tabla de datos
	if(indice <= CANT_TABLA)
	{
		for(i = 0; i < LONG_TABLA; i++)
		{	
			table_p->buffer[(indice * LONG_TABLA) -1 - i] = numero % 100;
			numero = numero / 100;
		}
		indice++;
	}
}

__attribute__(( section(".text_tarea1"))) void calcular_Promedio(t_datos* table_p, promedio* prom_p)
{
	word offset = 0;
	word i = 0, j = 0;
	dword sumProm = 0;
	dword prom = 0;
	dword numero = 0;
	word div = 1;


	for(j=0; j < CANT_TABLA; j++)
	{
		for(i = 0; i < LONG_TABLA; i++)
		{	
			// 00 00 00 01 23 45 67 89 
			numero = numero*100 + table_p->buffer[(LONG_TABLA*j) + i];	
		}
		if(numero > 0)
		{
			sumProm = sumProm + numero;
			prom = sumProm / div;
//			asm("xchg %bx,%bx");
			div++;
		}
		numero = 0;
	}

	if(prom > 0)
	{
		for(i = 0; i < LONG_TABLA; i++)
		{
			prom_p->buffer[LONG_TABLA -1 - i] = prom % 100;
			prom = prom/100;
		}
	}
}

__attribute__(( section(".funciones"))) void escribir_Pantalla(buff_video* buffV_p, promedio* prom_p, word fila, word columna)
{
	word offset = 0;
	byte numero[16];
	byte varaux = 0;
	byte string[] = "Sebastian Gavegno";
	word cant = 0;
	cant = sizeof(string);

	for(offset = 0; offset < 8; offset++)
	{
		varaux = prom_p->buffer[offset];
		// ejemplo 00 00 00 01 23 45 67 89 
		numero[offset*2]= varaux/10;
		numero[(offset*2)+1]= varaux%10;
	}

	if((fila < 25) & (columna < 80))
	{
		for(offset = 0; offset < LONG_BUFFER; offset++)
		{
			buffV_p->buffer[((columna + offset) * 2) + (fila * 160)] = 48 + numero[offset];	// 48 es el 0 ascii
			//cargo atributos
			buffV_p->buffer[((columna + offset) * 2 + 1) + (fila * 160)] = 0x07;	//Atributo blanco sobre negro
		}
	}

/*
	if((fila < 25) & (columna < 80))
	{
		for(offset = 0; offset < LONG_BUFFER; offset++)
		{
			buffV_p->buffer[((columna + offset) * 2) + (fila * 160)] = 48 + prom_p->buffer[offset];	// 48 es el 0 ascii
			//cargo atributos
			buffV_p->buffer[((columna + offset) * 2 + 1) + (fila * 160)] = 0x07;	//Atributo blanco sobre negro
		}
	}
*/
	for(offset = 0; offset < cant; offset++)
	{
		buffV_p->buffer[((0 + offset) * 2) + (24 * 160)] = string[offset];	
		//cargo atributos
		buffV_p->buffer[((0 + offset) * 2 + 1) + (24 * 160)] = 0x07;	//Atributo blanco sobre negro
	}	
}
