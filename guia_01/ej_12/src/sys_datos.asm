

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

GLOBAL dir_lineal_page_fault
GLOBAL error_code_PF
GLOBAL dir_phy_dinamica
GLOBAL page_fault_msg
GLOBAL page_fault_msg_2
GLOBAL page_fault_msg_3
GLOBAL page_fault_msg_4
GLOBAL page_fault_msg_5
GLOBAL page_fault_msg_6

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

tarea_actual db 0
tarea_siguiente db 0

variables_globales:

    dir_lineal_page_fault       resd 1              ; Dir. Lineal que produjo una Page Fault Exception.

    error_code_PF               resd 1              ; Código de error del #PF

    dir_phy_dinamica            dd 0x0A000000       ; Dir. Phy. dinámica para salvar el #PF

mensajes_error:
    page_fault_msg              db "-----PAGE FAULT-----",0
    page_fault_msg_2            db "Dir. VMA = 0x",0
    page_fault_msg_3            db "Error Code: ",0
    page_fault_msg_4            db "Paginacion OFF. Se puede paginar con VMA del CR2",0
    page_fault_msg_5            db "Paginacion exitosa.",0
    page_fault_msg_6            db "#PF Handler - Paginas de 4K creadas: ",0

TIMES 12 db 0

;------------------------------VARIABLES NO inicializadas---------------------------------------

section .datos_no_inicializadas

BUFFER_TECLADO  resb 19

TIMES 13 db 0
