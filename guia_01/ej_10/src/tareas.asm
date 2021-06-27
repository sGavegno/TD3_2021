
;-------------------------------VARIABLES EXTERNAS---------------------------------------


EXTERN calcular_Promedio

EXTERN PUNTERO_TABLA_DIGITO

EXTERN PUNTERO_PANTALLA
EXTERN escribir_Pantalla

EXTERN __VIDEO_VMA_LIN

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

PROMEDIO_TABLA_DIGITOS  resb 40

section .stak_tarea1

inicio_stak_tarea1  resb 0x1000                ;stak de 4k

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
    push dword __VIDEO_VMA_LIN
    call escribir_Pantalla
    add esp, 16

;Leer Direccion del promedio

    mov dword eax, [PROMEDIO_TABLA_DIGITOS]      ;guardo promedio en eax
    mov dword ebx, [eax]                         ;leo contenido de la direcion que guarda eax

tarea_end:
retf

