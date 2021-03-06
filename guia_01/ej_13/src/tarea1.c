

#include "../inc/tarea1.h"

__attribute__(( section(".text_tarea1"))) void ejecutar_tarea_1(void)
{
	//calcular_Promedio(&PUNTERO_TABLA_DIGITO, &PROMEDIO_TABLA_DIGITOS);
	calcular_Promedio(&PUNTERO_TABLA_DIGITO_T1, &PROMEDIO_TABLA_DIGITOS);
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
		//asm("xchg %bx, %bx"); 
		prom_p->prom = division_64(prom_p->Suma, div);
	}
}

__attribute__(( section(".text_tarea1")))qword division_64(qword sumaprom, word div)
{
    __attribute__(( section(".datos_tarea1")))static byte i=0;
    __attribute__(( section(".datos_tarea1")))static qword resultado64,aux;         //sumaprom/div  
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



