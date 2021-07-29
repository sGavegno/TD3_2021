
;-------------------------------VARIABLES EXTERNAS---------------------------------------
EXTERN SYS_H
EXTERN SYS_R
EXTERN SYS_P
EXTERN SYS_P_VGA

EXTERN calcular_Promedio

EXTERN PUNTERO_TABLA_DIGITO

EXTERN ejecutar_tarea_1
EXTERN ejecutar_tarea_2
EXTERN ejecutar_tarea_3

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
;------tarea 2-------
GLOBAL SUMA2_TABLA_DIGITOS
GLOBAL SUMA3_TABLA_DIGITOS


;--------------------------------DEFINE------------------------------------------


USE32
;-------------------------------------SECTION-------------------------------------------

;-------------------------------------TAREA 1-------------------------------------------
section .bss_tarea1

FLAG_TAREA_1 db 0

section .datos_tarea1

PROMEDIO_TABLA_DIGITOS  resb 40

section .rodata_tarea1

section .stak_tarea1

inicio_stak_tarea1  resb 0x1000                ;stak de 4k

section .text_tarea1

tarea_1:
;xchg bx,bx
    call ejecutar_tarea_1

    mov esi, __VIDEO_LIN                ;en esi tengo la direccion fuente
    mov edi, PROMEDIO_TABLA_DIGITOS     ;en edi tengo la direccion destino
    mov edx, 0                          ;en edx fila
    mov ecx, 64                         ;en ecx columna
    mov eax, SYS_P_VGA                 ;system call de lectura
    mov ebx, 4                         ;tamaño del dato    1 = byte, 2 = word, 3 = dword, 4 = qword
    int 0x80

;Leer Direccion del promedio

;    mov dword eax, [PROMEDIO_TABLA_DIGITOS]      ;guardo promedio en eax
;    mov dword ebx, [eax]                         ;leo contenido de la direcion que guarda eax
tarea_1_end:
    
    mov eax, SYS_H                 ;system call de halted
    int 0x80
    jmp tarea_1

;-------------------------------------TAREA 2-------------------------------------------
section .bss_tarea2

FLAG_TAREA_2 db 0

section .datos_tarea2

SUMA2_TABLA_DIGITOS dq 0

section .rodata_tarea2

section .stak_tarea2

inicio_stak_tarea2  resb 0x1000                ;stak de 4k

section .text_tarea2

tarea_2:
;xchg bx,bx
    call ejecutar_tarea_2

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

FLAG_TAREA_3 db 0

section .datos_tarea3

SUMA3_TABLA_DIGITOS dq 0

section .rodata_tarea3

section .stak_tarea3

inicio_stak_tarea3  resb 0x1000                ;stak de 4k

section .text_tarea3

tarea_3:
;xchg bx,bx
    call ejecutar_tarea_3

    mov esi, __VIDEO_LIN                ;en esi tengo la direccion fuente
    mov edi, SUMA3_TABLA_DIGITOS        ;en edi tengo la direccion destino
    mov edx, 2                          ;en edx fila
    mov ecx, 64                         ;en ecx columna
    mov eax, SYS_P_VGA                 ;system call de lectura
    mov ebx, 4                         ;tamaño del dato    1 = byte, 2 = word, 3 = dword, 4 = qword
    int 0x80

tarea_3_end:

    mov eax, SYS_H                 ;system call de halted
    int 0x80
    jmp tarea_3

;-------------------------------------TAREA 4-------------------------------------------
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
