

;-------------------------------VARIABLES EXTERNAS---------------------------------------
EXTERN LONG_TABLA_DATOS

;------------------------------VARIABLES GLOBALES-----------------------------------------
GLOBAL PUNTERO_TABLA_DIGITO

GLOBAL CONTADOR_TIMER
GLOBAL BUFFER_TECLADO
GLOBAL PROMEDIO_TABLA_DIGITOS

GLOBAL PUNTERO_PANTALLA

GLOBAL CANTIDAD_TECLAS

USE32
;--------------------------------------SECTION-----------------------------------------------


section .tables_digito

PUNTERO_TABLA_DIGITO resb 16*10   ;mi tabla puede cargar hasta 10 numeros de 64bits

;-------------------------------VARIABLES inicializadas---------------------------------------
section .datos                      

CONTADOR_TIMER dw 0x0000

CANTIDAD_TECLAS dw 0x00

TIMES 12 db 0

;------------------------------VARIABLES NO inicializadas---------------------------------------

section .datos_no_inicializadas

BUFFER_TECLADO  resb 19

TIMES 13 db 0

PUNTERO_PANTALLA resb 4

TIMES 12 db 0
