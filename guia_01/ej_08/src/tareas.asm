
;-------------------------------VARIABLES EXTERNAS---------------------------------------


EXTERN calcular_Promedio

EXTERN PUNTERO_TABLA_DIGITO

EXTERN PUNTERO_PANTALLA
EXTERN escribir_Pantalla

;------------------------------VARIABLES GLOBALES-----------------------------------------
GLOBAL tarea_promedio
GLOBAL FLAG_TAREA_1
GLOBAL PROMEDIO_TABLA_DIGITOS
;--------------------------------DEFINE------------------------------------------


USE32
;-------------------------------------SECTION-------------------------------------------

section .bss_tarea1

FLAG_TAREA_1 db 0

section .datos_tarea1


section .rodata_tarea1

PROMEDIO_TABLA_DIGITOS  resb 16

section .stak_tarea1

inicio_stak_tarea1  resb 0x4000                ;stak de 16k

section .text_tarea1

tarea_promedio:

    cmp byte [FLAG_TAREA_1], 0x01    
    jne tarea_end

    mov byte [FLAG_TAREA_1], 0x00
 
;xchg bx,bx
    push dword PROMEDIO_TABLA_DIGITOS
    push dword PUNTERO_TABLA_DIGITO
    call calcular_Promedio
    add esp,8
 
 ;xchg bx,bx
    push 64 
    push 0     
    push dword PROMEDIO_TABLA_DIGITOS     
    push dword [PUNTERO_PANTALLA]
    call escribir_Pantalla
    add esp, 16

tarea_end:
retf

