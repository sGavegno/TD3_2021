
;-------------------------------VARIABLES EXTERNAS---------------------------------------


EXTERN calcular_Promedio

EXTERN PUNTERO_TABLA_DIGITO

EXTERN ejecutar_tarea_1
EXTERN ejecutar_tarea_2
EXTERN ejecutar_tarea_3

EXTERN PUNTERO_PANTALLA
EXTERN escribir_Promedio_VGA

EXTERN __VIDEO_VMA_LIN


;------------------------------VARIABLES GLOBALES-----------------------------------------
GLOBAL tarea_1
GLOBAL tarea_2
GLOBAL tarea_3

GLOBAL FLAG_TAREA_1
GLOBAL FLAG_TAREA_2
GLOBAL FLAG_TAREA_3

;------tarea 1-------
GLOBAL PROMEDIO_TABLA_DIGITOS
;------tarea 2-------
GLOBAL SUMA2_TABLA_DIGITOS
GLOBAL SUMA3_TABLA_DIGITOS

GLOBAL contador_1
GLOBAL contador_2
GLOBAL contador_3
;--------------------------------DEFINE------------------------------------------


USE32
;-------------------------------------SECTION-------------------------------------------

;-------------------------------------TAREA 1-------------------------------------------
section .bss_tarea1

FLAG_TAREA_1 db 0

section .datos_tarea1

contador_1 dw 0

section .rodata_tarea1

PROMEDIO_TABLA_DIGITOS  resb 40

section .stak_tarea1

inicio_stak_tarea1  resb 0x1000                ;stak de 4k

section .text_tarea1

tarea_1:
;xchg bx,bx
    cmp byte [FLAG_TAREA_1], 0x01    
    jne tarea_1_end

    mov byte [FLAG_TAREA_1], 0x00
 
    call ejecutar_tarea_1

;Leer Direccion del promedio

;    mov dword eax, [PROMEDIO_TABLA_DIGITOS]      ;guardo promedio en eax
;    mov dword ebx, [eax]                         ;leo contenido de la direcion que guarda eax
tarea_1_end:
retf

;-------------------------------------TAREA 2-------------------------------------------
section .bss_tarea2

FLAG_TAREA_2 db 0

section .datos_tarea2

contador_2 dw 0

SUMA2_TABLA_DIGITOS dq 0

section .rodata_tarea2

section .stak_tarea2

inicio_stak_tarea2  resb 0x1000                ;stak de 4k

section .text_tarea2

tarea_2:

    cmp byte [FLAG_TAREA_2], 0x01    
    jne tarea_2_end

    mov byte [FLAG_TAREA_2], 0x00

    call ejecutar_tarea_2

tarea_2_end:
retf

;-------------------------------------TAREA 3-------------------------------------------
section .bss_tarea3

FLAG_TAREA_3 db 0

section .datos_tarea3

contador_3 dw 0

SUMA3_TABLA_DIGITOS dq 0

section .rodata_tarea3

section .stak_tarea3

inicio_stak_tarea3  resb 0x1000                ;stak de 4k

section .text_tarea3

tarea_3:

    cmp byte [FLAG_TAREA_3], 0x01    
    jne tarea_3_end

    mov byte [FLAG_TAREA_3], 0x00

    call ejecutar_tarea_3

tarea_3_end:
retf

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

tarea_4_end:
retf
