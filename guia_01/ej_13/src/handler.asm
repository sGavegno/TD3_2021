

;-------------------------------VARIABLES EXTERNAS---------------------------------------
EXTERN  CS_SEL
EXTERN DS_no_P


EXTERN Mover_Punto

EXTERN Scheduler
EXTERN tarea_promedio
EXTERN carga_paginacion

EXTERN escribir_Nro64_VGA

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
EXTERN borrar_tabla

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
EXTERN __CR3_tarea3

EXTERN __TSS_tarea3
EXTERN tarea_3_falla_AC 
EXTERN IDT_32
EXTERN escribir_mensaje_VGA
;------------------------------VARIABLES GLOBALES-----------------------------------------
GLOBAL return_Scheduler

GLOBAL SYS_H
GLOBAL SYS_R
GLOBAL SYS_C
GLOBAL SYS_P
GLOBAL SYS_P_VGA

GLOBAL L_Handler_Timer
GLOBAL L_Handler_Teclado
GLOBAL L_SYS_CALL

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
L_SYS_CALL EQU (SYS_CALL - OFFSET_HANDLER)


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
%define TECLA_Backspace     0x0E

%define TAREA_0     0
%define TAREA_1     1
%define TAREA_2     2
%define TAREA_3     3


SYS_H       EQU     0
SYS_R       EQU     1
SYS_C       EQU     2
SYS_P       EQU     3
SYS_P_VGA   EQU     4
;-------------------------------------SECTION-----------------------------------------------------
USE32

SECTION .handler

;-----------------------------------HANDLER INTERUPCIONES--------------------------------------------
;---Scheduler
Handler_Timer:   
    
    MOV al, 0x20                        ;Env??o End of Interrupt al PIC.
    OUT 0x20, al

    jmp Scheduler
return_Scheduler:

Handler_fin:

    IRET                                ;Fin de la interrupci??n.

    jmp Handler_Timer

Handler_Teclado:
    PUSHAD                              ;Salvo los registros de uso general.
    
    IN al, 0x60                         ;Leer tecla del buffer de teclado
    mov bl, al
    AND al, al
    JS Teclado_fin                      ;Si se suelta al tecla no hago nada

	
    xor eax, eax
    mov word eax, [CANTIDAD_TECLAS]
    cmp eax, 0x10                       ;Tabla completa
    jae T_ENTER

    add eax, 1
    mov [CANTIDAD_TECLAS], eax

detectar_numeros:
;Detecto los numeros
    cmp bl, TECLA_U
    je T_U

    cmp bl, TECLA_I
    je T_I

    cmp bl, TECLA_S
    je T_S

    cmp bl, TECLA_A
    je T_A

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

    cmp bl, TECLA_Backspace
    je T_Backspace 

    cmp bl, TECLA_ENTER
    je T_ENTER 

T_U:                    ;Genera #UD
    
    UD2
    jmp Teclado_fin

T_I:                    ;Genera #DF

    mov edi,IDT_32  ; Borro la primer entrada de la IDT #DE
    mov ecx,0x01      
    xor eax,eax           
    rep stosd   

    xor     ebx, ebx        
;    pop     eax
    div     ebx  

    jmp Teclado_fin

T_S:                    ;Genera #SS
    mov ax,DS_no_P
    mov ss,ax
    jmp Teclado_fin

T_A:                    ;Genera #AC
    xor eax, eax
    mov eax,cr0
    or eax, 1 << 18             ; CR0.AC = 1
    mov cr0,eax

    mov ebx, cr3                ;cambio el CR3 para poder cargar la TSS de la tarea 3
    mov eax, __CR3_tarea3
    mov cr3, eax

    xor eax, eax
    mov eax, __TSS_tarea3
    mov [eax+0x24], dword(0x40202) ;EFLAGS bit 18 Alignment Check en 1
    mov [eax+0x20], dword(tarea_3_falla_AC) ;EIP     
    
    mov cr3, ebx                ;Recupero CR3

    jmp Teclado_fin

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

T_Backspace:
    xor eax, eax
    mov  [CANTIDAD_TECLAS], ax

    push dword PUNTERO_TABLA_DIGITO
    call borrar_tabla
    add esp,4
    jmp Teclado_fin

T_ENTER:
	
    xor eax, eax
    mov  [CANTIDAD_TECLAS], ax

    push dword BUFFER_TECLADO
    push dword PUNTERO_TABLA_DIGITO
    call cargar_tabla
    add esp,8

    jmp Teclado_fin

Teclado_fin:
    MOV al, 0x20                        ;Env??o End of Interrupt al PIC.
    OUT 0x20, al
    POPAD                               ;Restauro registros de uso general.
    IRET                                ;Fin de la interrupci??n.
    
;En eax se fuarda el flag para que la syscall sepa que debe hacer
SYS_CALL:
    sti

    cmp eax, SYS_R
    je sys_read

    cmp eax, SYS_C
    je sys_copy

    cmp eax, SYS_P
    je sys_print

    cmp eax, SYS_P_VGA
    je sys_print_VGA

    cmp eax, SYS_H
    je sys_hlt

;parametros de sys_read
;ebx indica el tama??o a leer
;esi indica el lugar de memoria a leer
;edx:eax registros donde se guarda el contenido leido
sys_read:
    cmp ebx, 1 
    je read_byte

    cmp ebx, 2 
    je read_word

    cmp ebx, 3 
    je read_dword

    cmp ebx, 4 
    je read_qword

;8bits
read_byte:
    mov al, [esi]
    jmp SYS_CALL_FIN

;16bits
read_word:
    mov ax, [esi]
    jmp SYS_CALL_FIN

;32bits
read_dword:
    mov eax, [esi]
    jmp SYS_CALL_FIN

;64bits
read_qword:
    xor edx, edx
    xor eax, eax
    mov dword eax, [esi]
    mov dword edx, [esi + 4]            ;parte alta 
    jmp SYS_CALL_FIN

;parametros de sys_copy
;ebx indica el tama??o a leer ( no se implemento)
;esi indica el lugar de memoria a leer
;edi indica el lugar de memoria a escribir
;ecx indica la cantidad de memoria que se copia
sys_copy:
copia:
    mov eax, [esi]
    mov edx, [esi+4]
    mov [edi], eax
    mov [edi+4], edx
    add esi, 8
    add edi, 8
    loop copia
    jmp SYS_CALL_FIN

;parametros de sys_print
;ebx indica el tama??o a escribir
;edi indica el lugar de memoria a escribir
;edx:ecx contiene lo que se quiere escribir 
sys_print:

    cmp ebx, 1 
    je print_byte

    cmp ebx, 2 
    je print_word

    cmp ebx, 3 
    je print_dword

    cmp ebx, 4 
    je print_qword

;8bits
print_byte:
    mov byte [edi], cl
    jmp SYS_CALL_FIN

;16bits
print_word:
    mov word [edi], cx
    jmp SYS_CALL_FIN

;32bits
print_dword:
    mov dword [edi], ecx
    jmp SYS_CALL_FIN

;64bits
print_qword:
    mov dword [edi], ecx
    mov dword [edi + 4], edx            ;parte alta 
    jmp SYS_CALL_FIN

;parametros de sys_print_VGA
;ebx indica el tama??o a imprimir en pantalla (se implemento solo el qword)
;esi indica la direccion fuente
;edi indica la direccion destino
;edx indica la fila
;ecx indica la columna
sys_print_VGA:

    cmp ebx, 1
    je print_VGA_byte

    cmp ebx, 2
    je print_VGA_word

    cmp ebx, 3
    je print_VGA_dword

    cmp ebx, 4
    je print_VGA_qword

print_VGA_byte:
    jmp SYS_CALL_FIN
print_VGA_word:
    jmp SYS_CALL_FIN
print_VGA_dword:
    jmp SYS_CALL_FIN
print_VGA_qword:
    push ecx
    push edx    
    push edi
    push esi
    call escribir_Nro64_VGA
    add esp,16
    jmp SYS_CALL_FIN

sys_hlt:
    hlt
    jmp sys_hlt

SYS_CALL_FIN:
    IRET

;-----------------------------------HANDLER EXCEPCIONES--------------------------------------------
Handler_DE:
    xchg bx, bx
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
    xchg bx, bx
    mov dl,0x06
    hlt

Handler_NM:
    PUSHAD
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
    POPAD
    iret

Handler_DF:
    xchg bx, bx
    mov dl,0x08
    hlt

Handler_TS:
    mov dl,0x0A
    hlt

Handler_NP:
    mov dl,0x0B
    hlt

Handler_SS:
    xchg bx, bx
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
    mov     [dir_lineal_page_fault], eax    ; Guardo dir. lineal VMA que fall??

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
    ; -> -----------Apago la paginaci??n-----------------
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
    ; -> -----------Prendo la paginaci??n-----------------
    ;---------------------------------------------------
    xor eax, eax
    mov eax,cr0                 ;Activar paginacion encendiendo el
    or eax, 1 << 31             ;bit 31 CR0.
    mov cr0,eax 

;   INVLPG [dir_lineal_page_fault]

end_handler_PF:
    popad                       
    pop eax
    sti                         ; Habilito interrupciones.
    IRET

Handler_MF:
    mov dl,0x10
    hlt

Handler_AC:
    xchg bx, bx
    mov dl,0x11
    hlt

Handler_MC:
    mov dl,0x12
    hlt

Handler_XM:
    mov dl,0x13
    hlt