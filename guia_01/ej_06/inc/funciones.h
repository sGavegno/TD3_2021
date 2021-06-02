
/*--------------------------------DEFINE------------------------------------------*/

#define LONG_BUFFER 16
#define BUFF_SIZE 16

extern long unsigned __DATA_VMA;

typedef unsigned long dword;
typedef unsigned int word;
typedef unsigned char byte;


/*--------------------------------------------------------------------------------------------*/
typedef struct buff
{
    byte buffer[LONG_BUFFER];           //buffer
    byte In;                            //puntero a entrada
    byte Out;                           //puntero a salida
    byte Cant;                          //Cantidad de elementos guardados
}buff;

typedef struct t_datos
{
    byte buffer[LONG_BUFFER*10];           //buffer
}t_datos;

void buffer_Push(buff*, byte);
byte buffer_Pop(buff*);
void buffer_Clear(buff*);

void cargar_tabla(t_datos* ,buff*);


