
USE32
;-------------------------------VARIABLES EXTERNAS-------------------------------------------------
EXTERN  DS_SEL
EXTERN  CS_SEL

EXTERN tarea_1
EXTERN tarea_2
EXTERN tarea_3

EXTERN __VIDEO_LIN

EXTERN msg_bienvenida_VGA
EXTERN __VIDEO_LIN
EXTERN limpiar_VGA
;------------------------------VARIABLES GLOBALES--------------------------------------------------
GLOBAL kernel_size
GLOBAL kernel_init

;-------------------------------------SECTION-------------------------------------------
section .stak_kernel

inicio_stak_kernel  resb 0x1000                ;stak de 4k

section .kernel

kernel_init:
    
    ;xchg bx,bx

    call borrar_pantalla

    ; -> Escribo la pantalla con mensaje fijo.
    push __VIDEO_LIN
    call msg_bienvenida_VGA                     
    add esp,4

    .halted:

;        call CS_SEL:tarea_1

;        call CS_SEL:tarea_2

;        call CS_SEL:tarea_3

        hlt
        jmp .halted

    .guard:
        hlt
        jmp .guard

kernel_end:

borrar_pantalla:
        MOV esi, __VIDEO_LIN         ;Puntero al buffer de video.
        MOV ecx, 25*80                   ;Cantidad de caracteres a borrar.
        MOV ax, 0x1F20                   ;Caracter y atributo de espacio.
ciclo_borrar_pantalla:
        MOV [esi], ax                    ;Espacio en blanco sobre negro.
        ADD esi, 2                       ;Apuntar al siguiente carácter.
        LOOP ciclo_borrar_pantalla      ;Seguir ciclo si no terminó.
        RET

