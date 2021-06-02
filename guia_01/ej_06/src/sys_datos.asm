

;-------------------------------VARIABLES EXTERNAS---------------------------------------


;------------------------------VARIABLES GLOBALES-----------------------------------------
GLOBAL puntero_tabla_digito

GLOBAL CONTADOR_TIMER
GLOBAL BUFFER_TECLADO

;-------------------------------------SECTION-------------------------------------------
section .tables_digito

puntero_tabla_digito resb 16*80     ;mi tabla puede cargar hasta 80 numeros de 64bits

SECTION .data

CONTADOR_TIMER dw 0x0000

ALIGN 16

BUFFER_TECLADO  resb 20
