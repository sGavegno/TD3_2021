
/*--------------------------------DEFINE------------------------------------------*/

#define LONG_BUFFER 16
#define CANT_TABLA 10                       //Cantidad de datos que puede almacenar mi tabla
#define LONG_TABLA 8                        //originalmente 16
#define LONG_TABLA_DATOS CANT_TABLA*LONG_TABLA
#define BUFF_SIZE 16
#define LONG_BUFF_VIDEO 4000

extern long unsigned __DATA_VMA;

typedef unsigned long long qword;       //64 bits
typedef unsigned long dword;            //32 bits
typedef unsigned short word;            //16bits
typedef unsigned char byte;             //8bits


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
    qword tabla[CANT_TABLA];
}t_datos;

typedef struct promedio
{
    qword prom;
    qword Suma;
    qword aux;
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

qword division_64(qword sumaprom, word div);

void escribir_Pantalla(buff_video*, promedio*,word, word);


