
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

void buffer_Clear(buff* buff_p)
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

void cargar_tabla(t_datos* table_p, buff* buff_p)
{
	static char offset = 0;
	word i=0;
	byte dato = 0xFF;

	if(offset < 16*10)
	{
		for(i = 0; i < 16; i++)
		{
			dato = buffer_Pop(buff_p);	

			if( dato != 0xFF)
			{
				table_p->buffer[offset] = dato;
			}
			else
			{
				table_p->buffer[offset] = 0;
			}
			offset++;
		}
	}
}