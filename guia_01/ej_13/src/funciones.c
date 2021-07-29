
#include "../inc/funciones.h"

//------------------------------Paginacion------------------------------------------------
__attribute__(( section(".funciones"))) void carga_paginacion(dword Init_DP, dword Dir_Lineal, dword Dir_Fisica, word AtDP, word AtTP)
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
	Cont_DP = Init_DP + 0x1000 + indice_DP * 0x1000 + AtDP;

	dword *Dir_TP = (dword *)(Init_DP + 0x1000 + indice_DP * 0x1000 + indice_TP * 4);
//	*Dir_TP = Init_DP + 0x1000 + indice_DP * 0x1000 + indice_TP * 4;
	Cont_TP = Dir_Fisica | AtTP;

	*Dir_DP = Cont_DP;
	*Dir_TP = Cont_TP;
}
//---------------------Lectura de teclado---------------------
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
	byte cant = 0;

	cant = buff_p->Cant;
//saco el numero del buffer y lo ordeno
	for(i = 0; i < cant; i++)
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
		table_p->tabla[indice] = numero;
		indice++;
	}
}

//------------------------------Escribir Pantalla------------------------------------------------

/* Función que escribe un mensaje en el borde superior izquierdo de la pantalla */
__attribute__(( section(".funciones"))) void escribir_mensaje_VGA (char* msg, byte fila, byte columna, byte flag_ASCII)
{
    static int pos_msg = 0;
    buff_screen_t* VGA = (buff_screen_t*)&__VIDEO_LIN;    // Dirección base de la pantalla en el borde superior izquierdo.
    byte atributos = 0x1F;                              // Fondo Azul y letra blanca.

    /* Filas = 24 (y)
       Columnas = 80 (x) */

    /* Escribe el mensaje en pantalla en la pos. deseada hasta encontrar el NULL del vector. */
    for (pos_msg = 0; *(msg + pos_msg) != 0; pos_msg++)
    {
        /* Si no es ASCII, lo convierto. */
        if (!flag_ASCII)
        {
            *(msg + pos_msg) = convertir_ASCII (*(msg + pos_msg));
        }

        VGA->buffer_screen[2*fila][2*columna + 2*pos_msg ] = *(msg + pos_msg);
        VGA->buffer_screen[2*fila][2*columna +(2*pos_msg + 1) ] = atributos;

    }

}

/* Función que convierte un byte en ASCII */
__attribute__(( section(".funciones"))) byte convertir_ASCII (byte caracter)
{
    //Si es un número:       
    if (caracter > -1 && caracter < 10)
    {
    caracter = caracter + 48; //Convierto a ASCII (el cero es 48)
    }
    else
    {
        //Si es una letra:
        if ( caracter > 9 && caracter < 91)
        {
            caracter = caracter + 65 ; // Convierto a ASCII (la A es 65)
        } 

    }
    return caracter;

}

/* Función que inicializa o reinicia la pantalla con un mensaje fijo.  */
 __attribute__(( section(".funciones"))) void msg_bienvenida_VGA (buff_screen_t* VGA)
{
    escribir_mensaje_VGA("-----------------------------------------", 0, 0, ASCII_TRUE);
    escribir_mensaje_VGA("Ej.13 -  NIVELES DE PRIVILEGIO - TD3 2021", 1, 0, ASCII_TRUE);
    escribir_mensaje_VGA("-----------------------------------------", 2, 0, ASCII_TRUE);

    escribir_mensaje_VGA(" |||||| ||  || |||||| ||||||   ", 4, 0, ASCII_TRUE);
    escribir_mensaje_VGA(" ||  || ||  ||   ||   ||  ||   ", 5, 0, ASCII_TRUE);
    escribir_mensaje_VGA(" |||||| ||  ||   ||   ||  ||        ", 6, 0, ASCII_TRUE);
    escribir_mensaje_VGA(" ||     ||  ||   ||   ||  ||    ", 7, 0, ASCII_TRUE);
    escribir_mensaje_VGA(" ||     ||||||   ||   ||||||        ", 8, 0, ASCII_TRUE);
    escribir_mensaje_VGA("                                      ", 9, 0, ASCII_TRUE);
    escribir_mensaje_VGA(" |||||| ||      ||||||   ||  || ||||||   ", 10, 0, ASCII_TRUE);
    escribir_mensaje_VGA(" ||     ||      ||  ||   ||  || ||       ", 11, 0, ASCII_TRUE);
    escribir_mensaje_VGA(" |||||| ||      ||  ||   ||  || ||||||  ", 12, 0, ASCII_TRUE);
    escribir_mensaje_VGA(" ||     ||      ||  ||   ||  || ||      ", 13, 0, ASCII_TRUE);
    escribir_mensaje_VGA(" |||||| ||||||  |||||||| |||||| ||||||  ", 14, 0, ASCII_TRUE);
    escribir_mensaje_VGA("                                     ", 15, 0, ASCII_TRUE);
    escribir_mensaje_VGA(" ||     |||||| ||||||             ", 16, 0, ASCII_TRUE);
    escribir_mensaje_VGA(" ||     ||     ||                ", 17, 0, ASCII_TRUE);
    escribir_mensaje_VGA(" ||     |||||| ||||||            ", 18, 0, ASCII_TRUE);
    escribir_mensaje_VGA(" ||     ||     ||                ", 19, 0, ASCII_TRUE);
    escribir_mensaje_VGA(" |||||| |||||| ||||||           ", 20, 0, ASCII_TRUE);

    escribir_mensaje_VGA("-----------------------------------------", 22, 0, ASCII_TRUE);
    escribir_mensaje_VGA("     Gavegno Sebastian   152.553-0       ", 23, 0, ASCII_TRUE);
    escribir_mensaje_VGA("-----------------------------------------", 24, 0, ASCII_TRUE);
    escribir_mensaje_VGA("Promedio: ", 0, 54, ASCII_TRUE);
	escribir_mensaje_VGA("Suma 1: ", 1, 56, ASCII_TRUE);
	escribir_mensaje_VGA("Suma 2: ", 2, 56, ASCII_TRUE);
}

/* Función que escribe un caracter en una posición determinada de la pantalla. */
__attribute__(( section(".funciones"))) void escribir_caracter_VGA (char caracter, byte fila, byte columna, byte flag_ASCII)
{
    static int pos_msg = 0;
    buff_screen_t* VGA = (buff_screen_t*)&__VIDEO_LIN; // Dirección base de la pantalla en el borde superior izquierdo.
    byte atributos = 0x1F;              // Fondo Azul y letra blanca.

    /* Si no es ASCII, lo convierto. */
    if (!flag_ASCII)
    {
        caracter= convertir_ASCII (caracter);
    }

    VGA->buffer_screen[2*fila][2*columna + 2*pos_msg ] = caracter;
    VGA->buffer_screen[2*fila][2*columna +(2*pos_msg + 1) ] = atributos;

}

/* Función que limpia la pantalla borrando todo lo que tenga escrito. */
 __attribute__(( section(".funciones"))) void limpiar_VGA (buff_screen_t* VGA)
 {
    static int i = 0;
    static int j = 0;

    for (i = 0; i < 25; i++) 
    {
        for (j = 0; j < 80; j++) 
        {
            escribir_caracter_VGA(' ', i, j, ASCII_TRUE);      
        }
    } 
 }

__attribute__(( section(".funciones"))) void escribir_Nro64_VGA(buff_video* buffV_p, qword* num64, word fila, word columna)
{
	word offset = 0;
	byte numero[16];
	dword aux_L = 0;
	dword aux_H = 0;
	byte varaux = 0;

	aux_L = *num64;
	aux_H = *num64 >> 32;
	for(offset = 0; offset < 16; offset++)
	{
		if(offset < 8)
		{	//numero[offset] = aux_L % 10;
			varaux = aux_L % 16;
			aux_L = aux_L / 16;
			if(varaux>=10)
    		{
    			varaux=varaux+7;
    		}
			numero[offset] = varaux;
		}
		else
		{	//numero[offset] = aux_H%10;
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
}

