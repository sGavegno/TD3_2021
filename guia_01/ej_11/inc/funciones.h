
#include "../inc/define.h"

void buffer_Push(buff*, byte);
byte buffer_Pop(buff*);
void buffer_Clear(buff*);

void cargar_tabla(t_datos* ,buff*);

void calcular_Promedio(t_datos*, promedio*);

qword division_64(qword sumaprom, word div);

void escribir_Promedio_Pantalla(buff_video*, promedio*,word, word);

void carga_paginacion(dword, dword, dword, word);