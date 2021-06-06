

;-------------------------------VARIABLES EXTERNAS---------------------------------------
EXTERN LONG_TABLA_DATOS

;------------------------------VARIABLES GLOBALES-----------------------------------------
GLOBAL PUNTERO_TABLA_DIGITO

GLOBAL CONTADOR_TIMER
GLOBAL BUFFER_TECLADO
GLOBAL PROMEDIO_TABLA_DIGITOS
GLOBAL FLAG_TAREA_1

GLOBAL PUNTERO_PANTALLA

GLOBAL CANTIDAD_TECLAS

USE32
;-------------------------------------SECTION-------------------------------------------
section .tables_digito

PUNTERO_TABLA_DIGITO resb 16*10   ;mi tabla puede cargar hasta 10 numeros de 64bits


SECTION .datos

CONTADOR_TIMER dw 0x0000

FLAG_TAREA_1 db 0

CANTIDAD_TECLAS dw 0x00

TIMES 12 db 0

;--------------------VARIABLES NO inicializadas---------------------------------------
;mover a seccion correspondiente

BUFFER_TECLADO  resb 19

TIMES 13 db 0

PROMEDIO_TABLA_DIGITOS  resb 16

PUNTERO_PANTALLA resb 4

TIMES 12 db 0
