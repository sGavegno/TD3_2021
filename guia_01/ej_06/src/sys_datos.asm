

;-------------------------------VARIABLES EXTERNAS---------------------------------------


;------------------------------VARIABLES GLOBALES-----------------------------------------
GLOBAL puntero_tabla_digito

GLOBAL CONTADOR_TIMER
GLOBAL BUFFER_TECLADO

;-------------------------------------SECTION-------------------------------------------
section .tables_digito

puntero_tabla_digito resb 16*10     ;mi tabla puede cargar hasta 10 numeros de 64bits

SECTION .data

CONTADOR_TIMER dw 0x0000

TIMES 14 db 0

BUFFER_TECLADO  resb 19

TIMES 13 db 0
