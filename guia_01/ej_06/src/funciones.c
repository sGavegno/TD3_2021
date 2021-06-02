
#include "../inc/funciones.h"


__attribute__(( section(".funciones"))) void buffer_Push(buff* buff_p,byte Dato)
{

	if(buff_p->Cant < BUFF_SIZE)
	{
		buff_p->buffer[buff_p->In] = Dato;
		buff_p->Cant++;
		if(buff_p->In == BUFF_SIZE-1)
		{
			buff_p->In = 0;
		}
		else
		{
			buff_p->In++;
		}
	}

}

__attribute__(( section(".funciones"))) byte buffer_Pop(buff* buff_p) 
{
	static int retorno = -1;

	if(buff_p->Cant == 0)	
	{
		//Buff vacio
		return retorno;
	}
	else
	{
		retorno = buff_p->buffer[buff_p->Out];
		buff_p->Cant--;
		if(buff_p->Out == BUFF_SIZE-1)
		{
			buff_p->Out = 0;
		}
		else
		{
			buff_p->Out++;
		}
		return retorno;
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
	static int i=0;
	static int dato;

	for(i = 0; i < 16; i++)
	{	//modificar para almacenar varios numeros de 64bits
		table_p->tabla_datos[ i] = buff_p->buffer[i];
/*
		dato = buffer_Pop(buff_p);			//buff_p->buffer[i]
		if(dato != -1)
		{	
			table_p->tabla_datos[i] = dato;
		}
		else
		{
			dato = 0;
			
		}
		*/
	}
}