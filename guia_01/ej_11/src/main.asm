
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
    push    ebp
    mov     ebp, esp
    push    __VIDEO_LIN
    call msg_bienvenida_VGA                     
    leave

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


;Cargar TSS                 Pasar a .C
init_TSS:

;    mov eax, __TSS_tarea1
    ;backlink
    mov [eax], dword(0) 
    ;ESP0
    mov [eax+0x04], dword(0) 
    ;SS0
    mov [eax+0x08], dword(0) 
    ;ESP1
    mov [eax+0x0C], dword(0) 
    ;SS1
    mov [eax+0x10], dword(0) 
    ;ESP2
    mov [eax+0x14], dword(0) 
    ;SS2
    mov [eax+0x18], dword(0) 
    ;CR3
    mov dword [eax+0x1C], __CR3_tarea1
    ;EIP
    mov [eax+0x20], dword(0) 
    ;EFLAGS
    mov [eax+0x24], dword(0) 
    ;EAX
    mov [eax+0x28], dword(0) 
    ;ECX
    mov [eax+0x2C], dword(0) 
    ;EDX
    mov [eax+0x30], dword(0) 
    ;EBX
    mov [eax+0x34], dword(0) 
    ;ESP
    mov [eax+0x38], dword(0) 
    ;EBP
    mov [eax+0x3C], dword(0)    
    ;ESI
    mov [eax+0x40], dword(0) 
    ;EDI
    mov [eax+0x44], dword(0) 
    ;ES
    mov [eax+0x48], dword(0) 
    ;CS
    mov [eax+0x4C], dword(0) 
    ;SS
    mov [eax+0x50], dword(0) 
    ;DS
    mov [eax+0x54], dword(0) 
    ;FS
    mov [eax+0x58], dword(0) 
    ;GS
    mov [eax+0x5C], dword(0) 
    ;LDTR
    mov [eax+0x60], dword(0) 
    ;Bitmap E/S
    mov [eax + 0x64], dword(0) 

    ret
