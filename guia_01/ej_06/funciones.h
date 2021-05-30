
/*--------------------------------DEFINE------------------------------------------*/
#define TECLA_1     0x02
#define TECLA_2     0x03
#define TECLA_3     0x04
#define TECLA_4     0x05
#define TECLA_5     0x06
#define TECLA_6     0x07
#define TECLA_7     0x08
#define TECLA_8     0x09
#define TECLA_9     0x0A
#define TECLA_0     0x0B

#define TECLA_ENTER 0x1C

#define LONG_BUFFER 16

extern long unsigned __DATA_VMA;

typedef long unsigned direccion;
typedef unsigned char byte;
typedef unsigned long dword;

typedef struct buffer
{
    byte* cabeza;        //puntero a cabeza
    byte* cola;          //puntero a la cola
    byte buffer[LONG_BUFFER];            //buffer
    byte* inicio;        //puntero al inicio    //byte dato_dummy5;
    byte* fin;           //puntero al fin
    byte progreso;       //cantidad de datos ingresados
    byte longitud;       //longitud en elementos
    byte longitud_en_bytes;
    byte tam_elemento;   //tamaño de cada elemento
}buffer;


void buffer_init(buffer*);
void buffer_clear(buffer*);
void buffer_push(buffer*,byte);