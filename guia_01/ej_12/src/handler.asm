

;-------------------------------VARIABLES EXTERNAS---------------------------------------
EXTERN  CS_SEL

EXTERN Scheduler
EXTERN tarea_promedio
EXTERN carga_paginacion

EXTERN __MMX_tarea2
EXTERN __MMX_tarea3

EXTERN page_fault_msg
EXTERN page_fault_msg_2
EXTERN page_fault_msg_3
EXTERN page_fault_msg_4
EXTERN page_fault_msg_5
EXTERN page_fault_msg_6

EXTERN CONTADOR_TIMER
EXTERN PUNTERO_TABLA_DIGITO
EXTERN BUFFER_TECLADO

EXTERN buffer_Push
EXTERN buffer_Pop
EXTERN buffer_Clear
EXTERN cargar_tabla

EXTERN tarea_actual

EXTERN FLAG_TAREA_1
EXTERN FLAG_TAREA_2
EXTERN FLAG_TAREA_3

EXTERN CANTIDAD_TECLAS

EXTERN contador_1
EXTERN contador_2
EXTERN contador_3

EXTERN error_code_PF
EXTERN dir_lineal_page_fault
EXTERN dir_phy_dinamica
EXTERN __CR3_kernel

;------------------------------VARIABLES GLOBALES-----------------------------------------
GLOBAL return_Scheduler

GLOBAL L_Handler_Timer
GLOBAL L_Handler_Teclado

GLOBAL L_Handler_DE
GLOBAL L_Handler_NMI
GLOBAL L_Handler_BP
GLOBAL L_Handler_OF
GLOBAL L_Handler_BR
GLOBAL L_Handler_UD
GLOBAL L_Handler_NM
GLOBAL L_Handler_DF
GLOBAL L_Handler_TS
GLOBAL L_Handler_NP
GLOBAL L_Handler_SS
GLOBAL L_Handler_GP
GLOBAL L_Handler_PF
GLOBAL L_Handler_MF
GLOBAL L_Handler_AC
GLOBAL L_Handler_MC
GLOBAL L_Handler_XM


OFFSET_HANDLER equ 0x00100000

L_Handler_Timer EQU (Handler_Timer - OFFSET_HANDLER)
L_Handler_Teclado EQU (Handler_Teclado - OFFSET_HANDLER)


L_Handler_DE equ (Handler_DE - OFFSET_HANDLER)
L_Handler_NMI equ (Handler_NMI - OFFSET_HANDLER)
L_Handler_BP equ (Handler_BP - OFFSET_HANDLER)
L_Handler_OF equ (Handler_OF - OFFSET_HANDLER)
L_Handler_BR equ (Handler_BR - OFFSET_HANDLER)
L_Handler_UD equ (Handler_UD - OFFSET_HANDLER)
L_Handler_NM equ (Handler_NM - OFFSET_HANDLER)
L_Handler_DF equ (Handler_DF - OFFSET_HANDLER)
L_Handler_TS equ (Handler_TS - OFFSET_HANDLER)
L_Handler_NP equ (Handler_NP - OFFSET_HANDLER)
L_Handler_SS equ (Handler_SS - OFFSET_HANDLER)
L_Handler_GP equ (Handler_GP - OFFSET_HANDLER)
L_Handler_PF equ (Handler_PF - OFFSET_HANDLER)
L_Handler_MF equ (Handler_MF - OFFSET_HANDLER)
L_Handler_AC equ (Handler_AC - OFFSET_HANDLER)
L_Handler_MC equ (Handler_MC - OFFSET_HANDLER)
L_Handler_XM equ (Handler_XM - OFFSET_HANDLER)

;--------------------------------DEFINE------------------------------------------
;/* -------------DEFINES TECLADO------------- */
%define TECLA_1     0x02
%define TECLA_2     0x03
%define TECLA_3     0x04
%define TECLA_4     0x05
%define TECLA_5     0x06
%define TECLA_6     0x07
%define TECLA_7     0x08
%define TECLA_8     0x09
%define TECLA_9     0x0A
%define TECLA_0     0x0B

%define TECLA_ENTER 0x1C

%define TECLA_A     0x1E
%define TECLA_B     0x30
%define TECLA_C     0x2E
%define TECLA_D     0x20
%define TECLA_E     0x12
%define TECLA_F     0x21
%define TECLA_G     0x22
%define TECLA_H     0x23
%define TECLA_I     0x17
%define TECLA_J     0x24
%define TECLA_K     0x25
%define TECLA_L     0x26
%define TECLA_M     0x32
%define TECLA_N     0x31
%define TECLA_O     0x18
%define TECLA_P     0x19
%define TECLA_Q     0x10
%define TECLA_R     0x13
%define TECLA_S     0x1F
%define TECLA_T     0x14
%define TECLA_U     0x16
%define TECLA_V     0x2F
%define TECLA_W     0x11
%define TECLA_X     0x2D
%define TECLA_Y     0x15
%define TECLA_Z     0x2C

%define TAREA_0     0
%define TAREA_1     1
%define TAREA_2     2
%define TAREA_3     3

;-------------------------------------SECTION-----------------------------------------------------
USE32

SECTION .handler

;-----------------------------------HANDLER INTERUPCIONES--------------------------------------------
;---Scheduler
Handler_Timer:   
    
    MOV al, 0x20                        ;Envío End of Interrupt al PIC.
    OUT 0x20, al

    ;xchg bx,bx	
    jmp Scheduler
return_Scheduler:

Handler_fin:

    IRET                                ;Fin de la interrupción.

    jmp Handler_Timer

Handler_Teclado:
    PUSHAD                              ;Salvo los registros de uso general.
    
    ;xchg bx,bx	

    IN al, 0x60                         ;Leer tecla del buffer de teclado
    mov bl, al
    AND al, al
    JS Teclado_fin                      ;Si se suelta al tecla no hago nada

	;xchg bx,bx
    xor eax, eax
    mov byte eax, [BUFFER_TECLADO + 18] ;cantidad de datos en el buffer
    cmp eax, 0x10                       ;Tabla completa
    jne detectar_numeros

    push dword BUFFER_TECLADO
    push dword PUNTERO_TABLA_DIGITO
    call cargar_tabla
    add esp,8

    jmp Teclado_fin

detectar_numeros:
;Detecto los numeros
    cmp bl, TECLA_1
    je T_1 

    cmp bl, TECLA_2
    je T_2 

    cmp bl, TECLA_3
    je T_3 

    cmp bl, TECLA_4
    je T_4 

    cmp bl, TECLA_5
    je T_5 

    cmp bl, TECLA_6
    je T_6 

    cmp bl, TECLA_7
    je T_7 

    cmp bl, TECLA_8
    je T_8 

    cmp bl, TECLA_9
    je T_9 

    cmp bl, TECLA_0
    je T_0 

    cmp bl, TECLA_ENTER
    je T_ENTER 
;
T_1:
    push 0x01
    push dword BUFFER_TECLADO
    call buffer_Push
    add esp,8

    jmp Teclado_fin

T_2:
    push 0x02
    push dword BUFFER_TECLADO
    call buffer_Push
    add esp,8

    jmp Teclado_fin

T_3:
    push 0x03
    push dword BUFFER_TECLADO
    call buffer_Push
    add esp,8

    jmp Teclado_fin

T_4:
    push 0x04
    push dword BUFFER_TECLADO
    call buffer_Push
    add esp,8

    jmp Teclado_fin

T_5:
    push 0x05
    push dword BUFFER_TECLADO
    call buffer_Push
    add esp,8

    jmp Teclado_fin

T_6:
    push 0x06
    push dword BUFFER_TECLADO
    call buffer_Push
    add esp,8

    jmp Teclado_fin

T_7:
    push 0x07
    push dword BUFFER_TECLADO
    call buffer_Push
    add esp,8

    jmp Teclado_fin

T_8:
    push 0x08
    push dword BUFFER_TECLADO
    call buffer_Push
    add esp,8

    jmp Teclado_fin

T_9:
    push 0x09
    push dword BUFFER_TECLADO
    call buffer_Push
    add esp,8

    jmp Teclado_fin

T_0:	
    push 0x00
    push dword BUFFER_TECLADO
    call buffer_Push
    add esp,8

    jmp Teclado_fin

T_ENTER:
	
    push dword BUFFER_TECLADO
    push dword PUNTERO_TABLA_DIGITO
    call cargar_tabla
    add esp,8

    jmp Teclado_fin

Teclado_fin:
    MOV al, 0x20                        ;Envío End of Interrupt al PIC.
    OUT 0x20, al
    POPAD                               ;Restauro registros de uso general.
    IRET                                ;Fin de la interrupción.

Handler_Teclado_END:


;-----------------------------------HANDLER EXCEPCIONES--------------------------------------------
Handler_DE:
    mov dl,0xFF
    hlt

Handler_NMI:
    mov dl,0x02
    hlt

Handler_BP:
    mov dl,0x03
    hlt

Handler_OF:
    mov dl,0x04
    hlt

Handler_BR:
    mov dl,0x05
    hlt

Handler_UD:
    mov dl,0x06
    hlt

Handler_NM:
    mov dl,0x07

    clts        

    cmp byte [tarea_actual], TAREA_2
    je cargar_contexto_Tarea2

    cmp byte [tarea_actual], TAREA_3
    je cargar_contexto_Tarea3

    jmp fin_Handler_NM

cargar_contexto_Tarea2:
    FXRSTOR &__MMX_tarea2
    jmp fin_Handler_NM

cargar_contexto_Tarea3:
    FXRSTOR &__MMX_tarea3
    jmp fin_Handler_NM

fin_Handler_NM:

    iret

Handler_DF:
    mov dl,0x08
    hlt

Handler_TS:
    mov dl,0x0A
    hlt

Handler_NP:
    mov dl,0x0B
    hlt

Handler_SS:
    mov dl,0x0C
    hlt

Handler_GP:
    mov dl,0x0D
    hlt

Handler_PF:
xchg bx,bx
    mov dl,0x0E

    cli                                     ; Deshabilito interrupciones.
    pushad                                  ; Guardo registros.
    mov     ebx, [esp + 32]                 ; Guardo el Error Code. 
    mov     [error_code_PF], ebx
    mov     eax, cr2
    mov     [dir_lineal_page_fault], eax    ; Guardo dir. lineal VMA que falló

    ; -> Analizo el Error Code
    ; Si es una Pagina no presente (Bit 0 = 0) debe repaginar.
    and ebx, 0x1F   ; Bits 0 - 5 donde tengo los flags.
    cmp ebx, 0x00
    je pag_no_presente
    cmp ebx, 0x02
    je write_access
    jmp end_handler_PF

pag_no_presente:
write_access:

    ;---------------------------------------------------
    ; -> -----------Guardo VMA de falla y Dir. Fisica en GPRs
    ;----------para poder re-paginar con la paginacion apagada-----------------
    ;---------------------------------------------------
    ; ->Guardo en edx la VMA de falla del CR2
    xor   edx, edx
    mov   edx, [dir_lineal_page_fault] 
    ; ->Guardo en ecx la Dir. Fisica dinamica
    xor   ecx, ecx
    mov   ecx, [dir_phy_dinamica] 

    ;---------------------------------------------------
    ; -> -----------Apago la paginación-----------------
    ;---------------------------------------------------
    xor eax, eax
    mov eax,cr0                 ;Desactivo paginacion apago el
    xor eax, 1 << 31            ;bit 31 CR0.
    mov cr0,eax 

    push 0x03
    push ecx
    push edx
    push __CR3_kernel         
    call carga_paginacion
    add esp,16

    ;---------------------------------------------------
    ; -> -----------Prendo la paginación-----------------
    ;---------------------------------------------------
    xor eax, eax
    mov eax,cr0                 ;Activar paginacion encendiendo el
    or eax, 1 << 31             ;bit 31 CR0.
    mov cr0,eax 

;   INVLPG [dir_lineal_page_fault]

end_handler_PF:
    popad                       ; Tomo valores de registros guardados.
    pop eax
xchg bx,bx
    sti                         ; Habilito interrupciones.
    IRET

Handler_MF:
    mov dl,0x10
    hlt

Handler_AC:
    mov dl,0x11
    hlt

Handler_MC:
    mov dl,0x12
    hlt

Handler_XM:
    mov dl,0x13
    hlt