
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
	word numero = 0;

//saco el numero del buffer y lo ordeno
	for(i = 0; i < LONG_BUFFER; i++)
	{
		dato = buffer_Pop(buff_p);	
		if( dato != 0xFF)
		{
			numero = numero + dato;
			numero = numero *10;
		}
	}
//cargo la tabla de datos
	if(indice <= LONG_TABLA)
	{
		for(i = 0; i < LONG_BUFFER; i++)
		{	

			table_p->buffer[(indice * LONG_BUFFER) - i] = numero % 10;
			numero = numero / 10;

		}
		indice++;
	}
}

