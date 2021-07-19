
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

GLOBAL dir_lineal_page_fault
GLOBAL error_code_PF
GLOBAL dir_phy_dinamica
GLOBAL page_fault_msg
GLOBAL page_fault_msg_2
GLOBAL page_fault_msg_3
GLOBAL page_fault_msg_4
GLOBAL page_fault_msg_5
GLOBAL page_fault_msg_6
;-------------------------------------SECTION-------------------------------------------
section .stak_kernel

inicio_stak_kernel  resb 0x1000                ;stak de 4k


section .data

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

section .kernel


kernel_init:
    
    xchg bx,bx

    call borrar_pantalla

    ; -> Escribo la pantalla con mensaje fijo.
    push    __VIDEO_LIN
    call msg_bienvenida_VGA                     
    add esp,4

    .halted:

        call CS_SEL:tarea_1

        call CS_SEL:tarea_2

        call CS_SEL:tarea_3

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

