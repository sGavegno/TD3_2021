
/*--------------------------------DEFINE------------------------------------------*/

#define LONG_BUFFER 16
#define LONG_TABLA 10                       //Cantidad de datos que puede almacenar mi tabla
#define LONG_TABLA_DATOS LONG_BUFFER*LONG_TABLA
#define BUFF_SIZE 16
#define LONG_BUFF_VIDEO 4000

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
    byte buffer[LONG_TABLA_DATOS];           //buffer
}t_datos;

typedef struct promedio
{
    byte buffer[LONG_BUFFER];           //buffer
}promedio;

typedef struct buff_video
{
    byte buffer[LONG_BUFF_VIDEO];           //buffer
}buff_video;

void buffer_Push(buff*, byte);
byte buffer_Pop(buff*);
void buffer_Clear(buff*);

void cargar_tabla(t_datos* ,buff*);

void calcular_Promedio(t_datos*, promedio*);

void escribir_Pantalla(buff_video*, promedio*,word, word);


