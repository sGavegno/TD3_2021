

;-------------------------------VARIABLES EXTERNAS---------------------------------------
EXTERN SYS_H
EXTERN SYS_R
EXTERN SYS_P

;------------------------------VARIABLES GLOBALES-----------------------------------------
GLOBAL suma_aritmetica_tarea_2
GLOBAL suma_aritmetica_tarea_3

%define CANT_TABLA 25                       ;Cantidad de datos que puede almacenar mi tabla
;-------------------------------------SECTION-------------------------------------------

USE32
section .SIMD_tarea_2

;Suma aritmetica saturada en tamaño word
suma_aritmetica_tarea_2:
;xchg bx,bx
    xor ecx, ecx
    mov esi, [esp + 4]                  ;puntero a PUNTERO_TABLA_DIGITO
    mov edi, [esp + 8]                  ;puntero a SUMA2_TABLA_DIGITOS
    pxor mm0, mm0

suma_t2:
    
    paddsw qword mm0, [esi]
    add esi, 8                          ;me desplazo por la tabla 
    inc ecx
    cmp ecx, CANT_TABLA
    jne suma_t2

    movq [edi], mm1                ;Guardo el valor de la suma en SUMA2_TABLA_DIGITOS

    ret

section .SIMD_tarea_3

;Suma aritmetica saturada en tamaño quadruple word
suma_aritmetica_tarea_3:
;xchg bx,bx
    xor ecx, ecx
    mov esi, [esp + 4]                  ;puntero a PUNTERO_TABLA_DIGITO
    mov edi, [esp + 8]                  ;puntero a SUMA3_TABLA_DIGITOS
    pxor mm0, mm0

suma_t3:
    paddq qword mm0, [esi]
    add esi, 8                          ;me desplazo por la tabla 
    inc ecx
    cmp ecx, CANT_TABLA
    jne suma_t3

    movq [edi], mm1                ;Guardo el valor de la suma en SUMA3_TABLA_DIGITOS

    ret
