
USE32
;-------------------------------VARIABLES EXTERNAS-------------------------------------------------
EXTERN  DS_SEL
EXTERN  CS_SEL

EXTERN tarea_promedio

EXTERN __VIDEO_VMA_LIN
;------------------------------VARIABLES GLOBALES--------------------------------------------------
GLOBAL kernel_size
GLOBAL kernel_init


;-------------------------------------SECTION-------------------------------------------
section .kernel


kernel_init:
    
    xchg bx,bx

    call borrar_pantalla

    .halted:

        call CS_SEL:tarea_promedio
        hlt
        jmp .halted

    .guard:
        hlt
        jmp .guard

kernel_end:

borrar_pantalla:
        MOV esi, __VIDEO_VMA_LIN         ;Puntero al buffer de video.
        MOV ecx, 25*80                   ;Cantidad de caracteres a borrar.
        MOV ax, 0x1F20                   ;Caracter y atributo de espacio.
ciclo_borrar_pantalla:
        MOV [esi], ax                    ;Espacio en blanco sobre negro.
        ADD esi, 2                       ;Apuntar al siguiente carácter.
        LOOP ciclo_borrar_pantalla      ;Seguir ciclo si no terminó.
        RET


section .stak_kernel

inicio_stak_kernel  resb 0x4000                ;stak de 16k
