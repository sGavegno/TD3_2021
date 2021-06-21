
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

	if(buff_p->Cant == BUFF_SIZE)
	{
			//funcion para cargar tabla
			/*
				flag_simular_enter = 1
				out 0x60, 1C
			*/
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
	static char indice = 0;
	word i=0;
	byte dato = 0xFF;
	qword numero = 0;
	dword numero_L = 0;
	dword numero_H = 0;	
	byte cant = 0;

	cant = buff_p->Cant;
//saco el numero del buffer y lo ordeno
	for(i = 0; i < cant; i++)
	{
		dato = buffer_Pop(buff_p);	
		if( dato != 0xFF)
		{
			numero = numero*10 + dato;

			if(i < LONG_BUFFER/2)
			{
				numero_L = numero_L*10 + dato;
			}
			else
			{
				numero_H = numero_H*10 + dato;				
			}
		}
	}
//cargo la tabla de datos
	if(indice <= CANT_TABLA)
	{
		table_p->tabla[indice] = numero;
//		table_p->tabla[indice] = (numero_H << 32) | numero_L;
		indice++;
	}
}

__attribute__(( section(".text_tarea1"))) void calcular_Promedio(t_datos* table_p, promedio* prom_p)
{
	word i = 0;
	word div = 0;

	prom_p->aux = 0;
	prom_p->Suma = 0;
	prom_p->prom = 0;

	for(i=0; i < CANT_TABLA; i++)
	{
		prom_p->aux = table_p->tabla[i];

		if(prom_p->aux > 0)
		{
			prom_p->Suma = prom_p->Suma + prom_p->aux;
			div++;
			prom_p->aux = 0;
		}
	}
	if(div > 0)
	{
		prom_p->prom = division_64(prom_p->Suma, div);
	}
}

__attribute__(( section(".text_tarea1")))qword division_64(qword sumaprom, word div)
{
    static byte i=0;
    static qword resultado64,aux;         //sumaprom/div  
    resultado64=0;
    aux=0;    
    for(i=0;i<64;i++)
    {
        
        aux=aux | ( ( sumaprom>>(64-1-i) ) & ( 0x01 ) );
        if(aux>=div)
        {
        resultado64=resultado64|0x1;            
        aux=aux-div;
        }
        resultado64=resultado64<<1;
        aux=aux<<1;
    }
    resultado64=resultado64>>1;
    return resultado64;
}



__attribute__(( section(".funciones"))) void escribir_Pantalla(buff_video* buffV_p, promedio* prom_p, word fila, word columna)
{
	word offset = 0;
	qword aux = 0;
	dword aux_L = 0;
	dword aux_H = 0;
	byte numero[16];
	byte varaux = 0;
	byte string[] = "Sebastian Gavegno";
	word cant = 0;
	cant = sizeof(string);

	aux = prom_p->prom;
	aux_L = prom_p->prom;
	aux_H = (prom_p->prom) >> 32;
	for(offset = 0; offset < 16; offset++)
	{
		if(offset < 8)
		{
			//numero[offset] = aux_L % 10;
			varaux = aux_L % 16;
			aux_L = aux_L / 16;
			if(varaux>=10)
    		{
    			varaux=varaux+7;
    		}
			numero[offset] = varaux;
		}
		else
		{	
			//numero[offset] = aux_H%10;
			varaux = aux_H % 16;			
			aux_H = aux_H / 16;	
			if(varaux>=10)
    		{
    			varaux=varaux+7;
    		}
			numero[offset] = varaux;	
		}
	}

	if((fila < 25) & (columna < 80))
	{
		for(offset = 0; offset < LONG_BUFFER; offset++)
		{
			buffV_p->buffer[((columna + offset) * 2) + (fila * 160)] = 48 + numero[LONG_BUFFER-1 - offset];	// 48 es el 0 ascii
			//cargo atributos
			buffV_p->buffer[((columna + offset) * 2 + 1) + (fila * 160)] = 0x1F;	//Atributo blanco sobre negro
		}
	}

	for(offset = 0; offset < cant; offset++)
	{
		buffV_p->buffer[((0 + offset) * 2) + (24 * 160)] = string[offset];	
		//cargo atributos
		buffV_p->buffer[((0 + offset) * 2 + 1) + (24 * 160)] = 0x1F;	//Atributo blanco sobre negro
	}	
}


void carga_paginacion(dword Init_DP, dword Dir_Lineal, dword Dir_Fisica, word Atributo)
{
	//dword *Dir_DP = 0;
	//dword *Dir_TP = 0;
	dword Cont_DP = 0;
	dword Cont_TP = 0;
	dword Aux = 0;	
	word indice_DP = 0;
	word indice_TP = 0;

	Aux = (Dir_Lineal & 0xFFFFF000) >> 12; 
	indice_DP = (Aux>>10) & 0x3FF;
	indice_TP = Aux & 0x3FF;

	dword *Dir_DP = (dword *)(Init_DP + indice_DP*4);
	//*Dir_DP  = Init_DP + indice_DP*4;
	Cont_DP = Init_DP + 0x1000 + indice_DP * 0x1000 + Atributo;

	dword *Dir_TP = (dword *)(Init_DP + 0x1000 + indice_DP * 0x1000 + indice_TP * 4);
//	*Dir_TP = Init_DP + 0x1000 + indice_DP * 0x1000 + indice_TP * 4;
	Cont_TP = Dir_Fisica | Atributo;

	*Dir_DP = Cont_DP;
	*Dir_TP = Cont_TP;
}