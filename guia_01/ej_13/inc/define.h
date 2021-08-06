

/*--------------------------------DEFINE------------------------------------------*/

/* -------------DEFINES BUFFER------------- */
#define LONG_BUFFER 16
#define CANT_TABLA 25                       //Cantidad de datos que puede almacenar mi tabla
#define LONG_TABLA 8                        //originalmente 16
#define LONG_TABLA_DATOS CANT_TABLA*LONG_TABLA
#define BUFF_SIZE 16
#define LONG_BUFF_VIDEO 4000

/* -------------DEFINES BUFFER PANTALLA------------- */
#define FILAS_PANTALLA      24   //24 filas de 160 bytes cada una
#define COLUMNAS_PANTALLA   80   //80 columnas de 2 bytes cada una
#define BUFFER_MAX_VIDEO    32   //16 caracteres con sus 16 atributos cada uno
#define ASCII_TRUE          1
#define ASCII_FALSE         0

extern long unsigned __DATA_VMA;

typedef unsigned long long qword;       //64 bits
typedef unsigned long dword;            //32 bits
typedef unsigned short word;            //16bits
typedef unsigned char byte;             //8bits


/* ---------------EXTERN---------------------------- */
extern long unsigned __VIDEO_LIN;

extern long unsigned PUNTERO_TABLA_DIGITO;


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
    word  indice;
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

typedef struct buffer_screen
{
    byte buffer_screen[FILAS_PANTALLA][COLUMNAS_PANTALLA];   // Buffer para toda la pantalla.
    //byte mensaje[FILAS_PANTALLA*COLUMNAS_PANTALLA];         // Mensaje de tamaño máximo toda la pantalla.
    byte long_mensaje;                                      // Longitud en bytes del mensaje.
}buff_screen_t;