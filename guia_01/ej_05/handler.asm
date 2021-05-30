

;-------------------------------VARIABLES EXTERNAS---------------------------------------
EXTERN __SYS_TABLES_VMA
EXTERN DS_SEL
EXTERN _gdtr32
;------------------------------VARIABLES GLOBALES-----------------------------------------
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

SECTION .handler

USE32

;-----------------------------------HANDLER INTERUPCIONES--------------------------------------------
Handler_Teclado:
    PUSHAD                              ;Salvo los registros de uso general.
    
    xchg bx,bx	

    IN al, 0x60                         ;Leer tecla del buffer de teclado
    mov bl, al
    AND al, al
    JS Teclado_fin                      ;Si se suelta al tecla no hago nada

    cmp bl, TECLA_U
    je T_U 

    cmp bl, TECLA_I
    je T_I 

    cmp bl, TECLA_S
    je T_S

    cmp bl, TECLA_A
    je T_A 

    jmp Teclado_fin

	T_U:                                ;#UD: Invalid Opcode Fetch		
        UD2							
        jmp Teclado_fin

	T_I: 					            ;#DF: Doble falta

        jmp Teclado_fin
                
	T_S: 							    ;#SS: Falta en el Stack Segment	
        MOV esp,0
        PUSH eax    
        jmp Teclado_fin

	T_A: 							    ;#AC: Aligment check

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
    IRET

Handler_NMI:
    mov dl,0x02
    IRET

Handler_BP:
    mov dl,0x03
    IRET

Handler_OF:
    mov dl,0x04
    IRET

Handler_BR:
    mov dl,0x05
    IRET

Handler_UD:
    mov dl,0x06
    IRET

Handler_NM:
    mov dl,0x07
    IRET

Handler_DF:
    mov dl,0x08
    IRET

Handler_TS:
    mov dl,0x0A
    IRET

Handler_NP:
    mov dl,0x0B
    IRET

Handler_SS:
    mov dl,0x0C
    IRET

Handler_GP:
    mov dl,0x0D
    IRET

Handler_PF:
    mov dl,0x0E
    IRET

Handler_MF:
    mov dl,0x10
    IRET

Handler_AC:
    mov dl,0x11
    IRET

Handler_MC:
    mov dl,0x12
    IRET

Handler_XM:
    mov dl,0x13
    IRET