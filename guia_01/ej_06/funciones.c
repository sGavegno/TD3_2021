
#include "funciones.h"




/*Funcion para inicializar el ring buffer de teclado*/
__attribute__(( section(".funciones"))) void buffer_init(buffer* rb_p)
{
    rb_p->tam_elemento = sizeof(byte);
    rb_p->longitud=LONG_BUFFER*(rb_p->tam_elemento);
    rb_p->longitud_en_bytes=(rb_p->longitud)*(rb_p->tam_elemento);
    rb_p->inicio=rb_p->buffer;
    rb_p->fin=(byte*)(rb_p->buffer+LONG_BUFFER-1);
    rb_p->progreso=0;
    rb_p->cabeza=rb_p->inicio;
    rb_p->cola=rb_p->inicio;
}

/*Funcion para limpiar el ring buffer de teclado*/
__attribute__(( section(".funciones"))) void buffer_clear(buffer* rb_p)
{
    static int i=0;
    rb_p->progreso=0;
    rb_p->cola=rb_p->inicio;
    for(i=0;i<rb_p->longitud;i++)
    {
    rb_p->buffer[i]=0x00;
    }
}

/*Función para pushear dentro del ring buffer de teclado*/
__attribute__(( section(".funciones"))) void buffer_push(buffer* rb_p,byte tecla_recibida)
{
    rb_p->buffer[rb_p->progreso]=tecla_recibida;
    rb_p->cola=(byte*)(rb_p->buffer+rb_p->progreso);  
    rb_p->progreso++;
    if(rb_p->progreso == rb_p->longitud)
    {
    buffer_clear((buffer*) &__DATA_VMA);
    }
}

/*Función para chequear que la tecla ingresada sea valida*/
__attribute__(( section(".funciones"))) void __chequeo_tecla(byte tecla)
{
    tecla=(0x000000FF)&tecla;
    switch (tecla)
    {
    case TECLA_0:
        {
        buffer_push((buffer*) &__DATA_VMA,0x00);
        break;
        }

    case TECLA_1:
        {
        buffer_push((buffer*) &__DATA_VMA,0x01);
        break;
        }
    case TECLA_2:
        {
        buffer_push((buffer*) &__DATA_VMA,0x02);
        break;
        }
    case TECLA_3:
        {
        buffer_push((buffer*) &__DATA_VMA,0x03);

        break;
        }
   case TECLA_4:
        {
        buffer_push((buffer*) &__DATA_VMA,0x04);

       // asm("xchg %%bx,%%bx"::);
        break;
        }
    case TECLA_5:
        {

        buffer_push((buffer*) &__DATA_VMA,0x05);
       // asm("xchg %%bx,%%bx"::);
        break;
        }
    case TECLA_6:
        {

        buffer_push((buffer*) &__DATA_VMA,0x06);
       // asm("xchg %%bx,%%bx"::);
        break;
        }
    case TECLA_7:
        {

        buffer_push((buffer*) &__DATA_VMA,0x07);
       // asm("xchg %%bx,%%bx"::);
        break;
        }
    case TECLA_8:
        {
       // asm("xchg %%bx,%%bx"::);

        buffer_push((buffer*) &__DATA_VMA,0x08);
        break;
        }
    case TECLA_9:
        {
       // asm("xchg %%bx,%%bx"::);

        buffer_push((buffer*) &__DATA_VMA,0x09);
        break;
        }
    case TECLA_ENTER:
        {
        buffer_clear((buffer*) &__DATA_VMA);       
        break;
        }
    default:
        break;
    }
    
}