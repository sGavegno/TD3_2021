
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

__attribute__(( section(".funciones"))) void buffer_Pop(buff* buff_p) 
{
	if(buff_p->Cant == 0)	
	{
		//Buff vacio
	}
	else
	{
		buff_p->buffer[buff_p->Out] = 0;
		buff_p->Cant--;
		if(buff_p->Out == BUFF_SIZE-1)
		{
			buff_p->Out = 0;
		}
		else
		{
			buff_p->Out++;
		}
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
