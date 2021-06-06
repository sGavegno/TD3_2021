
;-------------------------------VARIABLES EXTERNAS---------------------------------------
EXTERN FLAG_TAREA_1

EXTERN calcular_Promedio

EXTERN PROMEDIO_TABLA_DIGITOS
EXTERN PUNTERO_TABLA_DIGITO

EXTERN PUNTERO_PANTALLA
EXTERN escribir_Pantalla

;------------------------------VARIABLES GLOBALES-----------------------------------------
GLOBAL tarea_promedio
 
;--------------------------------DEFINE------------------------------------------


USE32
;-------------------------------------SECTION-------------------------------------------
section .tarea

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
    push dword [PUNTERO_PANTALLA]
    call escribir_Pantalla
    add esp, 16

tarea_end:
retf

