

#include "../inc/tarea2.h"



__attribute__(( section(".text_tarea2"))) void ejecutar_tarea_2(void)
{
    suma_aritmetica_tarea_2(&PUNTERO_TABLA_DIGITO, &SUMA2_TABLA_DIGITOS);

    escribir_Nro64_VGA(&__VIDEO_LIN, &SUMA2_TABLA_DIGITOS, 1,64);

}

__attribute__(( section(".text_tarea2"))) qword tarea_2_suma( t_datos* table_p, qword* suma_p)
{
    word i = 0;
    qword Suma = 0;
    for(i = 0; i< CANT_TABLA; i++)
    {
        if(Suma < 0xFFFFFFFFFFFFFFFF)
        {
            Suma = Suma + table_p->tabla[i]; 
        }
    }
    *suma_p = Suma;
}

__attribute__(( section(".text_tarea3"))) void ejecutar_tarea_3(void)
{
    suma_aritmetica_tarea_3(&PUNTERO_TABLA_DIGITO, &SUMA3_TABLA_DIGITOS);

    escribir_Nro64_VGA(&__VIDEO_LIN, &SUMA3_TABLA_DIGITOS, 2, 64);

}

__attribute__(( section(".text_tarea3"))) qword tarea_3_suma( t_datos* table_p, qword* suma_p)
{
    word i = 0;
    qword Suma = 0;
    for(i = 0; i< CANT_TABLA; i++)
    {
        if(Suma < 0xFFFFFFFFFFFFFFFF)
        {
            Suma = Suma + table_p->tabla[i]; 
        }
    }
    *suma_p = Suma;
}


