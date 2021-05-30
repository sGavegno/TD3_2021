
;-------------------------------VARIABLES EXTERNAS-------------------------------------------------
EXTERN __INIT_ROM
EXTERN __SYS_TABLES_LMA
;------------------------------VARIABLES GLOBALES--------------------------------------------------
GLOBAL  CS_SEL
GLOBAL  DS_SEL
GLOBAL  _gdtr32

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

GDT_SIZE_32 equ $-GDT_32

_gdtr32:
       dw  GDT_SIZE_32 - 1                 ;Li­mite GDT (16 bits).
       dd  __SYS_TABLES_LMA            ;Base GDT (32 bits). __SYS_TABLES_LMA


