

;-------------------------------VARIABLES EXTERNAS---------------------------------------
EXTERN LONG_TABLA_DATOS
 

;------------------------------VARIABLES GLOBALES-----------------------------------------
GLOBAL PUNTERO_TABLA_DIGITO

GLOBAL CONTADOR_TIMER
GLOBAL BUFFER_TECLADO
GLOBAL PROMEDIO_TABLA_DIGITOS

GLOBAL CANTIDAD_TECLAS

GLOBAL tarea_actual 
GLOBAL tarea_siguiente

GLOBAL contador_1
GLOBAL contador_2
GLOBAL contador_3

;--------------------------------------SECTION-----------------------------------------------
USE32

section .tables_digito

PUNTERO_TABLA_DIGITO resb 8*10   ;mi tabla puede cargar hasta 10 numeros de 64bits

;-------------------------------VARIABLES inicializadas---------------------------------------
section .datos                      

CONTADOR_TIMER dw 0x0000

contador_1 dw 0
contador_2 dw 0
contador_3 dw 0

CANTIDAD_TECLAS dw 0x00

tarea_actual dw 0
tarea_siguiente dw 0

TIMES 12 db 0

;------------------------------VARIABLES NO inicializadas---------------------------------------

section .datos_no_inicializadas

BUFFER_TECLADO  resb 19

TIMES 13 db 0
