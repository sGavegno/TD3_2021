

;-------------------------------VARIABLES EXTERNAS---------------------------------------
EXTERN LONG_TABLA_DATOS

;------------------------------VARIABLES GLOBALES-----------------------------------------
GLOBAL puntero_tabla_digito

GLOBAL CONTADOR_TIMER
GLOBAL BUFFER_TECLADO
GLOBAL PROMEDIO_TABLA_DIGITOS
GLOBAL FLAG_TAREA_1

GLOBAL punteroPantalla

USE32
;-------------------------------------SECTION-------------------------------------------
section .tables_digito

puntero_tabla_digito resb 16*10   ;mi tabla puede cargar hasta 10 numeros de 64bits

SECTION .datos

CONTADOR_TIMER dw 0x0000

FLAG_TAREA_1 db 0

TIMES 13 db 0

;--------------------VARIABLES NO inicializadas---------------------------------------
;mover a seccion correspondiente

BUFFER_TECLADO  resb 19

TIMES 13 db 0

PROMEDIO_TABLA_DIGITOS  resb 16

punteroPantalla resb 4000

