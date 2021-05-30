
;-------------------------------VARIABLES EXTERNAS-------------------------------------------------
EXTERN __INIT_ROM
EXTERN __SYS_TABLES_LMA


;------------------------------VARIABLES GLOBALES--------------------------------------------------
GLOBAL  CS_SEL
GLOBAL  DS_SEL
GLOBAL  _gdtr32

GLOBAL TECLA_A
GLOBAL TECLA_B
GLOBAL TECLA_C
GLOBAL TECLA_D
GLOBAL TECLA_E
GLOBAL TECLA_F
GLOBAL TECLA_G   
GLOBAL TECLA_H     
GLOBAL TECLA_I     
GLOBAL TECLA_J     
GLOBAL TECLA_K     
GLOBAL TECLA_L     
GLOBAL TECLA_M     
GLOBAL TECLA_N     
GLOBAL TECLA_O     
GLOBAL TECLA_P
GLOBAL TECLA_Q
GLOBAL TECLA_R
GLOBAL TECLA_S
GLOBAL TECLA_T
GLOBAL TECLA_U
GLOBAL TECLA_V
GLOBAL TECLA_W
GLOBAL TECLA_X
GLOBAL TECLA_Y
GLOBAL TECLA_Z 

;-------------------------------------SECTION-------------------------------------------
SECTION .data


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
    
GDT_SIZE_32 equ $-GDT_32

_gdtr32:
       dw  GDT_SIZE_32 - 1              ;Li­mite GDT (16 bits).
       dd  GDT_32                       ;Base GDT (32 bits). __SYS_TABLES_LMA


