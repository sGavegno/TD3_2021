

;-------------------------------VARIABLES EXTERNAS---------------------------------------

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
    mov ebx, CANT_TABLA
    pxor mm0, mm0

suma_t2:
    paddusw mm0, qword[esi]
    add esi, 8
    inc ecx
    cmp ecx, ebx
jne suma_t2

    movq [edi], mm0                     ;Guardo el valor de la suma en SUMA2_TABLA_DIGITOS

    ret

section .SIMD_tarea_3

;Suma aritmetica saturada en tamaño quadruple word
suma_aritmetica_tarea_3:
;xchg bx,bx
    xor ecx, ecx
    mov esi, [esp + 4]                  ;puntero a PUNTERO_TABLA_DIGITO
    mov edi, [esp + 8]                  ;puntero a SUMA2_TABLA_DIGITOS
    mov ebx, CANT_TABLA
    pxor mm0, mm0

suma_t3:
    paddq mm0, qword[esi]
    add esi, 8
    inc ecx
    cmp ecx, ebx
    jne suma_t3

    movq [edi], mm0         ;Guardo el valor de la suma en SUMA3_TABLA_DIGITOS

    ret
