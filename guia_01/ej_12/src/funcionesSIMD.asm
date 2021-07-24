

;-------------------------------VARIABLES EXTERNAS---------------------------------------

;------------------------------VARIABLES GLOBALES-----------------------------------------
GLOBAL suma_aritmetica_tarea_2
GLOBAL suma_aritmetica_tarea_3

%define CANT_TABLA 10                       //Cantidad de datos que puede almacenar mi tabla
;-------------------------------------SECTION-------------------------------------------

USE32
section .text_tarea2

suma_aritmetica_tarea_2:

xor ecx,ecx
mov eax,[esp+4]
mov ebx,CANT_TABLA
add eax,16
pxor mm0,mm0

loop_t2:
    paddusw mm0, qword[eax]
    add eax,8
    inc ecx
    cmp ecx,ebx
jne loop_t2

;copio en edx:eax el contenido del registro mm0
movd eax,mm0
psrlq mm0,32
movd edx,mm0

pxor mm0,mm0


ret


section .text_tarea3

suma_aritmetica_tarea_3:
xor ecx,ecx
mov eax,[esp+4]
mov ebx,CANT_TABLA
add eax,16
pxor mm0,mm0

loop_t3:
    paddq mm0, qword[eax]
    add eax,8
    inc ecx
    cmp ecx,ebx
jne loop_t3

;copio en edx:eax el contenido del registro mm0
movd eax,mm0
psrlq mm0,32
movd ebx,mm0

ret
