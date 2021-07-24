
;-------------------------------VARIABLES EXTERNAS-------------------------------------------------
EXTERN __INIT_ROM
EXTERN __SYS_TABLES_LMA

EXTERN L_Handler_Timer
EXTERN L_Handler_Teclado

EXTERN L_Handler_DE
EXTERN L_Handler_NMI
EXTERN L_Handler_BP
EXTERN L_Handler_OF
EXTERN L_Handler_BR
EXTERN L_Handler_UD
EXTERN L_Handler_NM
EXTERN L_Handler_DF
EXTERN L_Handler_TS
EXTERN L_Handler_NP
EXTERN L_Handler_SS
EXTERN L_Handler_GP
EXTERN L_Handler_PF
EXTERN L_Handler_MF
EXTERN L_Handler_AC
EXTERN L_Handler_MC
EXTERN L_Handler_XM

EXTERN __SYS_TABLES_TSS_LIN

;------------------------------VARIABLES GLOBALES--------------------------------------------------
GLOBAL  CS_SEL
GLOBAL  DS_SEL
GLOBAL  TSS_SEL
GLOBAL  _gdtr32
GLOBAL  _idtr32

GLOBAL TSS_kernel
GLOBAL TSS_tarea1
GLOBAL TSS_tarea2
GLOBAL TSS_tarea3
GLOBAL TSS_tarea0

GLOBAL __TSS_kernel
GLOBAL __TSS_tarea1
GLOBAL __TSS_tarea2
GLOBAL __TSS_tarea3
GLOBAL __TSS_tarea0


;-------------------------------------SECTION-------------------------------------------

SECTION .sys_tables

GDT_32:
NULL_SEL    equ $-GDT_32
    db 0,0,0,0,0,0,0,0
CS_SEL equ $-GDT_32          ;Base 0x00000000 Limite 0xFFFFFFFF
    dw  0xFFFF                          ;Limite del segmento(bits 15 -0)
    dw  0                               ;Base del segmento(bits 15-0)
    db  0                               ;Base del segmento(bits 23-16)
    db  0x9A                            ;DPL=00 / bit3=1 seg.codigo/bit2=0/bit1=1 Lectura
    db  0xCF                            ;G=1/D=1 32 bits/Limite(bits 19:16)
    db  0x00                            ;Base del segmento(bits 31-24)

DS_SEL equ $-GDT_32          ;Base 0x00000000 Limite 0xFFFFFFFF
    dw  0xFFFF                          ;Limite del segmento(bits 15 -0)
    dw  0                               ;Base del segmento(bits 15-0)
    db  0                               ;Base del segmento(bits 23-16)
    db  0x92                            ;DPL=00 / bit3=0 seg.dato/bit2=0/bit1=1 (R/W)
    db  0xCF                            ;G=1/D=1 32 bits/Limite(bits 19:16)
    db  0x00                            ;Base del segmento(bits 31-24) 

TSS_SEL equ $-GDT_32          ;Base 0x00001000 Limite 0x00000067
    dw  0x0067                          ;Limite del segmento(bits 15 -0)
    dw  0x1000                          ;Base del segmento(bits 15-0)
    db  0                               ;Base del segmento(bits 23-16)
    db  10001001b                       ;P=1 / DPL=00 / bit3=1 seg.cod/bit2=0/bit1=1 (R/W)
    db  01000000b                       ;G=0/D=1 32 bits/Limite(bits 19:16)
    db  0                               ;Base del segmento(bits 31-24)    

GDT_SIZE_32 equ $-GDT_32

_gdtr32:
       dw  GDT_SIZE_32 - 1              ;Li­mite GDT (16 bits).
       dd  GDT_32                       ;Base GDT (32 bits). __SYS_TABLES_LMA

;------------------------------------IDT---------------------------------------------------
;#UD 0x06 Invalid Opcode (Fault)
;#DF 0x08 Double Fault (Abort)  
;#SS 0x0C Stack Segment Fault (Fault)
;#AC 0x11 Alignament Check (Fault)
;Teclado 0x21

H_ALTA EQU 0x0010

IDT_32:
;-------------------------------------Exepciones-------------------------------------
ISR00_idt EQU $ - IDT_32                 ;Divide Error
    dw L_Handler_DE     ;Offset 15-0
    dw CS_SEL           ;Selector
    db 0x00             ;No usado
    db 10001111b        ;P=1 Presente en el segmento
                        ;DPL=00, Nivel de prioridad Kernel
                        ;Bit 12: 0 por defecto 
                        ;D=1 Gate 32 bits 
                        ;Bits 10-8: 111 por defecto
    dw H_ALTA           ;Offset 31-16

ISR01_idt EQU $ - IDT_32               ;Debug Exception (Reservada)
    dq 0x0000           ;Reservados

ISR02_idt EQU $ - IDT_32              ;Nonmaskable External Interrupt
    dw L_Handler_NMI    ;Offset 15-0
    dw CS_SEL           ;Selector
    db 0x00             ;No usado
    db 10001111b        ;P=1 Presente en el segmento
                        ;DPL=00, Nivel de prioridad Kernel
                        ;Bit 12: 0 por defecto 
                        ;D=1 Gate 32 bits 
                        ;Bits 10-8: 111 por defecto
    dw H_ALTA           ;Offset 31-16 

ISR03_idt EQU $ - IDT_32     ;Nonmaskable External Interrupt
    dw L_Handler_BP     ;Offset 15-0
    dw CS_SEL           ;Selector
    db 0x00             ;No usado
    db 10001111b        ;P=1 Presente en el segmento
                        ;DPL=00, Nivel de prioridad Kernel
                        ;Bit 12: 0 por defecto 
                        ;D=1 Gate 32 bits 
                        ;Bits 10-8: 111 por defecto
    dw H_ALTA           ;Offset 31-16

ISR04_idt EQU $ - IDT_32        ;Nonmaskable External Interrupt
    dw L_Handler_OF     ;Offset 15-0
    dw CS_SEL           ;Selector
    db 0x00             ;No usado
    db 10001111b        ;P=1 Presente en el segmento
                        ;DPL=00, Nivel de prioridad Kernel
                        ;Bit 12: 0 por defecto 
                        ;D=1 Gate 32 bits 
                        ;Bits 10-8: 111 por defecto
    dw H_ALTA           ;Offset 31-16

ISR05_idt EQU $ - IDT_32        ;Nonmaskable External Interrupt
    dw L_Handler_BR     ;Offset 15-0
    dw CS_SEL           ;Selector
    db 0x00             ;No usado
    db 10001111b        ;P=1 Presente en el segmento
                        ;DPL=00, Nivel de prioridad Kernel
                        ;Bit 12: 0 por defecto 
                        ;D=1 Gate 32 bits 
                        ;Bits 10-8: 111 por defecto
    dw H_ALTA           ;Offset 31-16

ISR06_idt EQU $ - IDT_32         ;Nonmaskable External Interrupt
    dw L_Handler_UD     ;Offset 15-0
    dw CS_SEL           ;Selector
    db 0x00             ;No usado
    db 10001111b        ;P=1 Presente en el segmento
                        ;DPL=00, Nivel de prioridad Kernel
                        ;Bit 12: 0 por defecto 
                        ;D=1 Gate 32 bits 
                        ;Bits 10-8: 111 por defecto
    dw H_ALTA           ;Offset 31-16

ISR07_idt EQU $ - IDT_32         ;Nonmaskable External Interrupt
    dw L_Handler_NM     ;Offset 15-0
    dw CS_SEL           ;Selector
    db 0x00             ;No usado
    db 10001111b        ;P=1 Presente en el segmento
                        ;DPL=00, Nivel de prioridad Kernel
                        ;Bit 12: 0 por defecto 
                        ;D=1 Gate 32 bits 
                        ;Bits 10-8: 111 por defecto
    dw H_ALTA           ;Offset 31-16

ISR08_idt EQU $ - IDT_32          ;Nonmaskable External Interrupt
    dw L_Handler_DF     ;Offset 15-0
    dw CS_SEL           ;Selector
    db 0x00             ;No usado
    db 10001111b        ;P=1 Presente en el segmento
                        ;DPL=00, Nivel de prioridad Kernel
                        ;Bit 12: 0 por defecto 
                        ;D=1 Gate 32 bits 
                        ;Bits 10-8: 111 por defecto
    dw H_ALTA           ;Offset 31-16

ISR09_idt EQU $ - IDT_32        ;Reservada
    dq 0x0000                   ;Reservados

ISR10_idt EQU $-IDT_32          ;Nonmaskable External Interrupt
    dw L_Handler_TS     ;Offset 15-0
    dw CS_SEL           ;Selector
    db 0x00             ;No usado
    db 10001111b        ;P=1 Presente en el segmento
                        ;DPL=00, Nivel de prioridad Kernel
                        ;Bit 12: 0 por defecto 
                        ;D=1 Gate 32 bits 
                        ;Bits 10-8: 111 por defecto
    dw H_ALTA           ;Offset 31-16

ISR11_idt EQU $ - IDT_32      ;Nonmaskable External Interrupt
    dw L_Handler_NP     ;Offset 15-0
    dw CS_SEL           ;Selector
    db 0x00             ;No usado
    db 10001111b        ;P=1 Presente en el segmento
                        ;DPL=00, Nivel de prioridad Kernel
                        ;Bit 12: 0 por defecto 
                        ;D=1 Gate 32 bits 
                        ;Bits 10-8: 111 por defecto
    dw H_ALTA           ;Offset 31-16

ISR12_idt EQU $ - IDT_32        ;Nonmaskable External Interrupt
    dw L_Handler_SS     ;Offset 15-0
    dw CS_SEL           ;Selector
    db 0x00             ;No usado
    db 10001111b        ;P=1 Presente en el segmento
                        ;DPL=00, Nivel de prioridad Kernel
                        ;Bit 12: 0 por defecto 
                        ;D=1 Gate 32 bits 
                        ;Bits 10-8: 111 por defecto
    dw H_ALTA           ;Offset 31-16

ISR13_idt EQU $ - IDT_32       ;Nonmaskable External Interrupt
    dw L_Handler_GP     ;Offset 15-0
    dw CS_SEL           ;Selector
    db 0x00             ;No usado
    db 10001111b        ;P=1 Presente en el segmento
                        ;DPL=00, Nivel de prioridad Kernel
                        ;Bit 12: 0 por defecto 
                        ;D=1 Gate 32 bits 
                        ;Bits 10-8: 111 por defecto
    dw H_ALTA           ;Offset 31-16

ISR14_idt EQU $ - IDT_32           ;Nonmaskable External Interrupt
    dw L_Handler_PF     ;Offset 15-0
    dw CS_SEL           ;Selector
    db 0x00             ;No usado.
    db 10001111b        ;P=1 Presente en el segmento
                        ;DPL=00, Nivel de prioridad Kernel
                        ;Bit 12: 0 por defecto 
                        ;D=1 Gate 32 bits 
                        ;Bits 10-8: 111 por defecto
    dw H_ALTA           ;Offset 31-16

ISR15_idt EQU $ - IDT_32         ;Nonmaskable External Interrupt
    dq 0x0000           ;Reservados

ISR16_idt EQU $ - IDT_32         ;Nonmaskable External Interrupt
    dw L_Handler_MF     ;Offset 15-0
    dw CS_SEL           ;Selector
    db 0x00             ;No usado.
    db 10001111b        ;P=1 Presente en el segmento
                        ;DPL=00, Nivel de prioridad Kernel
                        ;Bit 12: 0 por defecto 
                        ;D=1 Gate 32 bits 
                        ;Bits 10-8: 111 por defecto
    dw H_ALTA           ;Offset 31-16

ISR17_idt EQU $ - IDT_32          ;Nonmaskable External Interrupt
    dw L_Handler_AC     ;Offset 15-0
    dw CS_SEL           ;Selector
    db 0x00             ;No usado.
    db 10001111b        ;P=1 Presente en el segmento
                        ;DPL=00, Nivel de prioridad Kernel
                        ;Bit 12: 0 por defecto 
                        ;D=1 Gate 32 bits 
                        ;Bits 10-8: 111 por defecto
    dw H_ALTA           ;Offset 31-16

ISR18_idt EQU $ - IDT_32          ;Nonmaskable External Interrupt
    dw L_Handler_MC     ;Offset 15-0
    dw CS_SEL           ;Selector
    db 0x00             ;No usado.
    db 10001111b        ;P=1 Presente en el segmento
                        ;DPL=00, Nivel de prioridad Kernel
                        ;Bit 12: 0 por defecto 
                        ;D=1 Gate 32 bits 
                        ;Bits 10-8: 111 por defecto
    dw H_ALTA           ;Offset 31-16

ISR19_idt EQU $ - IDT_32          ;Nonmaskable External Interrupt
    dw L_Handler_XM     ;Offset 15-0
    dw CS_SEL           ;Selector
    db 0x00             ;No usado
    db 10001111b        ;P=1 Presente en el segmento
                        ;DPL=00, Nivel de prioridad Kernel
                        ;Bit 12: 0 por defecto 
                        ;D=1 Gate 32 bits 
                        ;Bits 10-8: 111 por defecto
    dw H_ALTA           ;Offset 31-16

;---------------------------------Reservados-------------------------------
ISR20to31_idt EQU $ - IDT_32
    times 12 dq 0x0000  

;--------------------------------Interupciones-----------------------------
ISR32_idt EQU $ - IDT_32            ;L_Handler_Timer
;Compuerta de interrupción de Timer.
    dw L_Handler_Timer              ;Offset 15-0
    dw CS_SEL                       ;Selector.
    db 0x00                         ;No usado.
    db 0x8E                         ;Compuerta de interrupción.
    dw H_ALTA                       ;Offset 31-16       

ISR33_idt EQU $ - IDT_32
;Compuerta de interrupción de teclado.
    dw L_Handler_Teclado            ;Offset 15-0
    dw CS_SEL                       ;Selector.
    db 0x00                         ;No usado.
    db 0x8E                         ;Compuerta de interrupción.
    dw H_ALTA                       ;Offset 31-16
    
ISR34to46_idt EQU $ - IDT_32
    times 13 dq 0x0000          

IDT_SIZE_32  EQU $ - IDT_32             ;Tamaño de la IDT.

_idtr32:                                ;Imagen de IDTR.
        DW IDT_SIZE_32 - 1              
        DD IDT_32                       


;------------------------------TSS-------------------------------
SECTION .sys_tables_tss

TSS:
TSS_kernel EQU $ - TSS
    times 0x68 db 0
TSS_tarea1 EQU $ - TSS
    times 0x68 db 0
TSS_tarea2 EQU $ - TSS
    times 0x68 db 0
TSS_tarea3 EQU $ - TSS
    times 0x68 db 0
TSS_tarea0 EQU $ - TSS
    times 0x68 db 0
