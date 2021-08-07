
;-------------------------------VARIABLES EXTERNAS---------------------------------------
;Flags de sys_call
EXTERN SYS_H
EXTERN SYS_R
EXTERN SYS_C
EXTERN SYS_P
EXTERN SYS_P_VGA

EXTERN calcular_Promedio

EXTERN PUNTERO_TABLA_DIGITO

EXTERN ejecutar_tarea_1
EXTERN cargar_tabla_digitos_T1

EXTERN ejecutar_tarea_2
EXTERN cargar_tabla_digitos_T2

EXTERN ejecutar_tarea_3
EXTERN cargar_tabla_digitos_T3

EXTERN PUNTERO_PANTALLA
EXTERN escribir_Promedio_VGA

EXTERN __VIDEO_LIN


;------------------------------VARIABLES GLOBALES-----------------------------------------
GLOBAL tarea_1
GLOBAL tarea_2
GLOBAL tarea_3
GLOBAL tarea_0

GLOBAL FLAG_TAREA_1
GLOBAL FLAG_TAREA_2
GLOBAL FLAG_TAREA_3

;------tarea 1-------
GLOBAL PROMEDIO_TABLA_DIGITOS
GLOBAL PUNTERO_TABLA_DIGITO_T1
;------tarea 2-------
GLOBAL SUMA2_TABLA_DIGITOS
GLOBAL PUNTERO_TABLA_DIGITO_T2
;------tarea 3-------
GLOBAL SUMA3_TABLA_DIGITOS
GLOBAL PUNTERO_TABLA_DIGITO_T3

GLOBAL tarea_3_falla_AC
;--------------------------------DEFINE------------------------------------------
%define CANT_TABLA 25                  ;rvisar que sea igual al de a define.h

USE32
;-------------------------------------SECTION-------------------------------------------

;-------------------------------------TAREA 1-------------------------------------------
section .bss_tarea1

PUNTERO_TABLA_DIGITO_T1 resw (CANT_TABLA*4 + 1)     ;CANT_TABLA*4 + 1 = 25 qword + 1 word de indice

ALIGN 4
FLAG_TAREA_1 db 0

section .datos_tarea1

PROMEDIO_TABLA_DIGITOS  resb 40

section .rodata_tarea1

section .stak_tarea1

inicio_stak_tarea1  resb 0x1000                ;stak de 4k

section .text_tarea1

tarea_1:
;Copio la tabla de digitos de kernel a una tabla de privilegio 3
    mov ecx, CANT_TABLA                 ;En ecx tengo la cantidad a copiar
    mov edi, PUNTERO_TABLA_DIGITO_T1    ;En edi tengo mi direccion destino
    mov esi, PUNTERO_TABLA_DIGITO       ;En esi tengo mi direccion fuente
    mov eax, SYS_C                      ;Flag que determina la accion de SYSCALL
    int 0x80

    call ejecutar_tarea_1

    mov esi, __VIDEO_LIN                ;en esi tengo la direccion fuente
    mov edi, PROMEDIO_TABLA_DIGITOS     ;en edi tengo la direccion destino
    mov edx, 0                          ;en edx fila
    mov ecx, 64                         ;en ecx columna
    mov eax, SYS_P_VGA                 ;system call de lectura
    mov ebx, 4                         ;tamaño del dato    1 = byte, 2 = word, 3 = dword, 4 = qword
    int 0x80

;Leer Direccion del promedio para generar #PF
;    mov dword eax, [PROMEDIO_TABLA_DIGITOS]      ;guardo promedio en eax
;    mov dword ebx, [eax]                         ;leo contenido de la direcion que guarda eax
tarea_1_end:
    
    mov eax, SYS_H                 ;system call de halted
    int 0x80
    jmp tarea_1

;-------------------------------------TAREA 2-------------------------------------------
section .bss_tarea2

PUNTERO_TABLA_DIGITO_T2 resw (CANT_TABLA*4 + 1)     ;CANT_TABLA*4 + 1 = 25 qword + 1 word de indice

ALIGN 4
FLAG_TAREA_2 db 0

section .datos_tarea2

SUMA2_TABLA_DIGITOS dq 0

section .rodata_tarea2

section .stak_tarea2

inicio_stak_tarea2  resb 0x1000                ;stak de 4k

section .text_tarea2

tarea_2:
;Copio la tabla de digitos de kernel a una tabla de privilegio 3
    mov ecx, CANT_TABLA                 ;En ecx tengo la cantidad a copiar
    mov edi, PUNTERO_TABLA_DIGITO_T2    ;En edi tengo mi direccion destino
    mov esi, PUNTERO_TABLA_DIGITO       ;En esi tengo mi direccion fuente
    mov eax, SYS_C                      ;Flag que determina la accion de SYSCALL
    int 0x80

    ;call ejecutar_tarea_2

;Suma aritmetica saturada en tamaño word
    xor ecx, ecx
    mov ecx, CANT_TABLA                 ;En ecx tengo la cantidad a copiar
    mov esi, PUNTERO_TABLA_DIGITO_T2    ;puntero a PUNTERO_TABLA_DIGITO_T2
    mov edi, SUMA2_TABLA_DIGITOS        ;puntero a SUMA2_TABLA_DIGITOS
    mov ebx, CANT_TABLA
    pxor mm0, mm0

suma_t2:
    paddusw qword mm0, [esi]
    add esi, 8                          ;me desplazo por la tabla 
    loop suma_t2

    movq qword [edi], mm0                ;Guardo el valor de la suma en SUMA2_TABLA_DIGITOS

    mov esi, __VIDEO_LIN                ;en esi tengo la direccion fuente
    mov edi, SUMA2_TABLA_DIGITOS        ;en edi tengo la direccion destino
    mov edx, 1                          ;en edx fila
    mov ecx, 64                         ;en ecx columna
    mov eax, SYS_P_VGA                 ;system call de lectura
    mov ebx, 4                         ;tamaño del dato    1 = byte, 2 = word, 3 = dword, 4 = qword
    int 0x80

tarea_2_end:

    mov eax, SYS_H                 ;system call de halted
    int 0x80
    jmp tarea_2

;-------------------------------------TAREA 3-------------------------------------------
section .bss_tarea3

PUNTERO_TABLA_DIGITO_T3 resw (CANT_TABLA*4 + 1)     ;CANT_TABLA*4 + 1 = 25 qword + 1 word de indice

ALIGN 4

FLAG_TAREA_3 db 0

section .datos_tarea3

SUMA3_TABLA_DIGITOS dq 0

section .rodata_tarea3

section .stak_tarea3

inicio_stak_tarea3  resb 0x1000                ;stak de 4k

section .text_tarea3

tarea_3:

;Copio la tabla de digitos de kernel a una tabla de privilegio 3
    mov ecx, CANT_TABLA                 ;En ecx tengo la cantidad a copiar
    mov edi, PUNTERO_TABLA_DIGITO_T3    ;En edi tengo mi direccion destino
    mov esi, PUNTERO_TABLA_DIGITO       ;En esi tengo mi direccion fuente
    mov eax, SYS_C                      ;Flag que determina la accion de SYSCALL
    int 0x80

    ;call ejecutar_tarea_3

    xor ecx, ecx
    mov ecx, CANT_TABLA                 ;En ecx tengo la cantidad a copiar  
    mov esi, PUNTERO_TABLA_DIGITO_T3    ;puntero a PUNTERO_TABLA_DIGITO
    mov edi, SUMA3_TABLA_DIGITOS        ;puntero a SUMA3_TABLA_DIGITOS
    mov ebx, CANT_TABLA
    pxor mm0, mm0
suma_t3:
    paddq qword mm0, [esi]
    add esi, 8                          ;me desplazo por la tabla 
    loop suma_t3

    movq qword [edi], mm0               ;Guardo el valor de la suma en SUMA3_TABLA_DIGITOS

    mov esi, __VIDEO_LIN                ;en esi tengo la direccion destino
    mov edi, SUMA3_TABLA_DIGITOS        ;en edi tengo la direccion fuente
    mov edx, 2                          ;en edx fila
    mov ecx, 64                         ;en ecx columna
    mov eax, SYS_P_VGA                  ;system call de lectura
    mov ebx, 4                          ;tamaño del dato    1 = byte, 2 = word, 3 = dword, 4 = qword
    int 0x80

tarea_3_end:

    mov eax, SYS_H                 ;system call de halted
    int 0x80
    jmp tarea_3


tarea_3_falla_AC:       ;Solo se usa para generar la falla de AC
    
    mov dword[0x01530007],0xF 

    mov eax, SYS_H                 ;system call de halted
    int 0x80
    jmp tarea_3_falla_AC

;-------------------------------------TAREA 0-------------------------------------------
section .bss_tarea0

FLAG_tarea_0 db 0

section .datos_tarea0

section .rodata_tarea0

section .stak_tarea0

inicio_stak_tarea0  resb 0x1000                ;stak de 4k

section .text_tarea0

tarea_0:

    mov eax, SYS_H                 ;system call de halted
    int 0x80
    jmp tarea_0

tarea_0_end:
retf
