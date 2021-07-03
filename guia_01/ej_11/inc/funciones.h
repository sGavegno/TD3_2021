
#include "../inc/define.h"

//-------------Paginacion---------------------
void carga_paginacion(dword, dword, dword, word, word);

//-------------Buffer Teclado---------------
void buffer_Push(buff*, byte);
byte buffer_Pop(buff*);
void buffer_Clear(buff*);

void cargar_tabla(t_datos* ,buff*);

//------------------VGA---------------------
void escribir_mensaje_VGA (char* , byte , byte , byte );
void escribir_caracter_VGA (char , byte , byte , byte );
void msg_bienvenida_VGA (buff_screen_t* VGA);
byte convertir_ASCII (byte );
void limpiar_VGA (buff_screen_t* );

void escribir_Nro64_VGA(buff_video*, qword*, word, word);