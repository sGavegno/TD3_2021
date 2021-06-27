
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

;-------------------------------------TAREA 1-------------------------------------------
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

tarea_end:
retf

;-------------------------------------TAREA 2-------------------------------------------
section .bss_tarea2

FLAG_TAREA_2 db 0

section .datos_tarea2


section .rodata_tarea2

section .stak_tarea2

inicio_stak_tarea2  resb 0x1000                ;stak de 4k

section .text_tarea2

tarea_2:



tarea_2_end

;-------------------------------------TAREA 3-------------------------------------------
section .bss_tarea3

FLAG_TAREA_3 db 0

section .datos_tarea3


section .rodata_tarea3

section .stak_tarea3

inicio_stak_tarea3  resb 0x1000                ;stak de 4k

section .text_tarea3

tarea_3:



tarea_3_end


;-------------------------------------TAREA 4-------------------------------------------
section .bss_tarea4

FLAG_TAREA_4 db 0

section .datos_tarea4

section .rodata_tarea4

section .stak_tarea4

inicio_stak_tarea4  resb 0x1000                ;stak de 4k

section .text_tarea4

tarea_4:

    .halted:
        hlt
        jmp .halted

tarea_4_end

