
;-------------------------------VARIABLES EXTERNAS---------------------------------------
EXTERN FLAG_TAREA_1

EXTERN calcular_Promedio
EXTERN PROMEDIO_TABLA_DIGITOS
EXTERN puntero_tabla_digito
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

        push dword PROMEDIO_TABLA_DIGITOS
        push dword puntero_tabla_digito
        call calcular_Promedio
        add esp,8

tarea_end:
retf


