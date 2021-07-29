ENTRY (reset)

    __INIT_ROM              = 0xFFFF0000;
    __RESET                 = 0xFFFFFFF0;
                        
    __CR3_kernel            = 0x00010000;
    __CR3_tarea0            = 0x00010000;       /* kernel / halted */
    __CR3_tarea1            = 0x01010000;
    __CR3_tarea2            = 0x02010000;
    __CR3_tarea3            = 0x03010000;

    __TSS_kernel            = 0x00001000;
    __TSS_tarea0            = 0x00001100;
    __TSS_tarea1            = 0x00001200;
    __TSS_tarea2            = 0x00001300;
    __TSS_tarea3            = 0x00001400;

    __MMX_tarea2            = 0x00001500;
    __MMX_tarea3            = 0x00001600;

   /*--------------Direccion Fisica-----------------*/
    __SYS_TABLES_FIS        = 0x00000000;
    __SYS_TABLES_TSS_FIS    = 0x00001000;
    __SYS_TABLES_PAG_FIS    = 0x00010000;               /* tamaño 0x400000 */
    __SYS_TABLES_PAG_T1_FIS = 0x01010000;   
    __SYS_TABLES_PAG_T2_FIS = 0x02010000;
    __SYS_TABLES_PAG_T3_FIS = 0x03010000;    
    __VIDEO_FIS             = 0x000B8000;
    __HANDLER_FIS           = 0x00100000;
    __DATOS_FIS             = 0x00200000;
    __TABLES_DIGITOS_FIS    = 0x00210000;
    __KERNEL_FIS            = 0x00220000;
    __FUNCIONES_FIS         = 0x00230000;

    __TEXT_TAREA1_FIS       = 0x00310000;
    __BSS_TAREA1_FIS        = 0x00320000;
    __DATA_TAREA1_FIS       = 0x00330000;
    __RODATA_TAREA1_FIS     = 0x00340000;

    __TEXT_TAREA2_FIS       = 0x00410000;
    __BSS_TAREA2_FIS        = 0x00420000;
    __DATA_TAREA2_FIS       = 0x00430000;
    __RODATA_TAREA2_FIS     = 0x00440000;

    __TEXT_TAREA3_FIS       = 0x00510000;
    __BSS_TAREA3_FIS        = 0x00520000;
    __DATA_TAREA3_FIS       = 0x00530000;
    __RODATA_TAREA3_FIS     = 0x00540000;

    __TEXT_tarea0_FIS       = 0x00610000;
    __BSS_tarea0_FIS        = 0x00620000;
    __DATA_tarea0_FIS       = 0x00630000;
    __RODATA_tarea0_FIS     = 0x00640000;

    __STACK_KERNEL_FIS      = 0x1FFF8000;               /* stak de 4k */
    __STACK_KERNEL_END_FIS  = 0x1FFF8FFF;

    __STACK_KERNEL_T1_FIS      = 0x1FFF4000;               /* stak de 4k */
    __STACK_KERNEL_T1_END_FIS  = 0x1FFF4FFF; 

    __STACK_KERNEL_T2_FIS      = 0x1FFF5000;               /* stak de 4k */
    __STACK_KERNEL_T2_END_FIS  = 0x1FFF5FFF;

    __STACK_KERNEL_T3_FIS      = 0x1FFF6000;               /* stak de 4k */
    __STACK_KERNEL_T3_END_FIS  = 0x1FFF6FFF;

    __STACK_KERNEL_T0_FIS      = 0x1FFF7000;               /* stak de 4k */
    __STACK_KERNEL_T0_END_FIS  = 0x1FFF7FFF;

    __STACK_TAREA1_FIS       = 0x1FFF0000;               /* stak de 4k */
    __STACK_TAREA1_END_FIS   = 0x1FFF0FFF;

    __STACK_TAREA2_FIS       = 0x1FFF1000;               /* stak de 4k */
    __STACK_TAREA2_END_FIS   = 0x1FFF1FFF;

    __STACK_TAREA3_FIS       = 0x1FFF2000;               /* stak de 4k */
    __STACK_TAREA3_END_FIS   = 0x1FFF2FFF;

    __STACK_tarea0_FIS       = 0x1FFF3000;               /* stak de 4k */
    __STACK_tarea0_END_FIS   = 0x1FFF3FFF; 

    __INIT_VMA              = 0xFFFF0000;

    /*--------------Dirección Lineal-----------------*/
    __SYS_TABLES_LIN            = 0x00000000;
    __SYS_TABLES_TSS_LIN        = 0x00001000;
    __SYS_TABLES_PAG_LIN        = 0x00010000;
    __SYS_TABLES_PAG_T1_LIN     = 0x01010000;
    __SYS_TABLES_PAG_T2_LIN     = 0x02010000;
    __SYS_TABLES_PAG_T3_LIN     = 0x03010000; 
    __VIDEO_LIN                 = 0x00E80000;
    __HANDLER_LIN               = 0x00100000;
    __DATOS_LIN                 = 0x01200000;
    __TABLES_DIGITOS_LIN        = 0x01210000;
    __KERNEL_LIN                = 0x01220000;
    __FUNCIONES_LIN             = 0x01230000;

    __TEXT_TAREA1_LIN           = 0x01310000;
    __BSS_TAREA1_LIN            = 0x01320000;
    __DATA_TAREA1_LIN           = 0x01330000;
    __RODATA_TAREA1_LIN         = 0x01340000;

    __TEXT_TAREA2_LIN           = 0x01410000;
    __BSS_TAREA2_LIN            = 0x01420000;
    __DATA_TAREA2_LIN           = 0x01430000;
    __RODATA_TAREA2_LIN         = 0x01440000;

    __TEXT_TAREA3_LIN           = 0x01510000;
    __BSS_TAREA3_LIN            = 0x01520000;
    __DATA_TAREA3_LIN           = 0x01530000;
    __RODATA_TAREA3_LIN         = 0x01540000;

    __TEXT_tarea0_LIN           = 0x01610000;
    __BSS_tarea0_LIN            = 0x01620000;
    __DATA_tarea0_LIN           = 0x01630000;
    __RODATA_tarea0_LIN         = 0x01640000;

    __STACK_KERNEL_LIN          = 0x1FFF8000;               /* stak de 4k */
    __STACK_KERNEL_LIN_END      = 0x1FFF8FFF;

    __STACK_KERNEL_T1_LIN      = 0x1FFF4000;               /* stak de 4k */
    __STACK_KERNEL_T1_END_LIN  = 0x1FFF4FFF; 

    __STACK_KERNEL_T2_LIN      = 0x1FFF5000;               /* stak de 4k */
    __STACK_KERNEL_T2_END_LIN  = 0x1FFF5FFF;

    __STACK_KERNEL_T3_LIN      = 0x1FFF6000;               /* stak de 4k */
    __STACK_KERNEL_T3_END_LIN  = 0x1FFF6FFF;

    __STACK_KERNEL_T0_LIN      = 0x1FFF7000;               /* stak de 4k */
    __STACK_KERNEL_T0_END_LIN  = 0x1FFF7FFF;


    __STACK_TAREA1_LIN           = 0x0078F000;               /* stak de 4k */
    __STACK_TAREA1_LIN_END       = 0x0078FFFF;
    
    __STACK_TAREA2_LIN           = 0x00790000;               /* stak de 4k */
    __STACK_TAREA2_LIN_END       = 0x00790FFF;

    __STACK_TAREA3_LIN           = 0x00791000;               /* stak de 4k */
    __STACK_TAREA3_LIN_END       = 0x00791FFF;

    __STACK_tarea0_LIN           = 0x00792000;               /* stak de 4k */
    __STACK_tarea0_LIN_END       = 0x00792FFF;

MEMORY
{
    ram (!x) : ORIGIN = 0x00000000, LENGTH = 0xFFFF0000 
    rom (rx) : ORIGIN = 0xFFFF0000, LENGTH = 64K
}

SECTIONS
{   

    .init __INIT_VMA :
        AT ( __INIT_ROM )
        { 
            *(.init);
            *(.text);
            *(.funciones_ROM);
            *(.note.gnu.property);
            __INIT_size = SIZEOF(.init);        
        } > rom
        __INIT_VMA_END = .;

    .sys_tables __SYS_TABLES_LIN :
            AT ( LOADADDR(.init) + SIZEOF(.init))
        {
            __SYS_TABLES_LMA = LOADADDR(.sys_tables);
            *(.sys_tables); 
            __SYS_TABLES_size = SIZEOF(.sys_tables);
        } > ram
        __SYS_TABLES_VMA_END = .;

    .sys_tables_tss __SYS_TABLES_TSS_LIN :
            AT ( LOADADDR(.sys_tables) + SIZEOF(.sys_tables))
        {
            __SYS_TABLES_TSS_LMA = LOADADDR(.sys_tables_tss);
            *(.sys_tables_tss); 
            __SYS_TABLES_TSS_size = SIZEOF(.sys_tables_tss);
        } > ram
        __SYS_TABLES_TSS_VMA_END = .;

    .sys_tables_paginacion __SYS_TABLES_PAG_LIN :
            AT ( LOADADDR(.sys_tables_tss) + SIZEOF(.sys_tables_tss))
        {
            __SYS_TABLES_PAG_LMA = LOADADDR(.sys_tables_paginacion);
            *(.sys_tables_paginacion); 
            __SYS_TABLES_PAG_size = SIZEOF(.sys_tables_paginacion);
        } > ram
        __SYS_TABLES_PAG_VMA_END = .;

    .video __VIDEO_LIN :
        AT ( LOADADDR(.sys_tables_paginacion) + SIZEOF(.sys_tables_paginacion) )
        { 
            __VIDEO_LMA = LOADADDR(.video);
            *(.video);   
            __VIDEO_size = SIZEOF(.video);
        } > ram
        __VIDEO_VMA_END = .;

    .rutinas_handler __HANDLER_LIN :
        AT ( LOADADDR(.video) + SIZEOF(.video) )
        { 
            __HANDLER_LMA = LOADADDR(.rutinas_handler);
            *(.handler); 
            *(.scheduler);  
            __HANDLER_size = SIZEOF(.rutinas_handler);
        } > ram
        __HANDLER_VMA_END = .;

    .data __DATOS_LIN :
        AT ( LOADADDR(.rutinas_handler) + SIZEOF(.rutinas_handler))
        {
            __DATOS_LMA = LOADADDR(.data);
            *(.datos);
            *(.datos_no_inicializadas);
            *(.data);
            *(.rodata);
            *(.bss); 
            __DATOS_size = SIZEOF(.data);
        } > ram
        __DATOS_VMA_END = .;

    .tables_digito __TABLES_DIGITOS_LIN :
            AT ( LOADADDR(.data) + SIZEOF(.data))
        {
            __TABLES_DIGITOS_LMA = LOADADDR(.tables_digito);
            *(.tables_digito); 
            __TABLES_DIGITOS_size = SIZEOF(.tables_digito);
        } > ram
        __TABLES_DIGITOS_VMA_END = .;

    .kernel __KERNEL_LIN :
        AT ( LOADADDR(.tables_digito) + SIZEOF(.tables_digito) )
        { 
            __KERNEL_LMA = LOADADDR(.kernel);            
            *(.kernel);  
            __KERNEL_size = SIZEOF(.kernel);        
        } > ram
        __KERNEL_VMA_END = .;

    .funciones __FUNCIONES_LIN :
        AT ( LOADADDR(.kernel) + SIZEOF(.kernel) )
        { 
            __FUNCIONES_LMA = LOADADDR(.funciones);            
            *(.funciones);  
            *(.funciones_SIMD);             
            __FUNCIONES_size = SIZEOF(.funciones);        
        } > ram
        __FUNCIONES_VMA_END = .;

    .text_tarea1 __TEXT_TAREA1_LIN :
        AT ( LOADADDR(.funciones) + SIZEOF(.funciones) )
        {
            __TEXT_TAREA1_LMA = LOADADDR(.text_tarea1);
            *(.text_tarea1);
        } > ram
        __TEXT_TAREA1_VMA_END = .;

    .bss_tarea1 __BSS_TAREA1_LIN :
        AT ( LOADADDR(.text_tarea1) + SIZEOF(.text_tarea1) )
        {
            __BSS_TAREA1_LMA = LOADADDR(.bss_tarea1);
            *(.bss_tarea1);
        } > ram
        __BSS_TAREA1_VMA_END = .;

    .datos_tarea1 __DATA_TAREA1_LIN :
        AT ( LOADADDR(.bss_tarea1) + SIZEOF(.bss_tarea1) )
        {
            __DATA_TAREA1_LMA = LOADADDR(.datos_tarea1);
            *(.datos_tarea1);
        } > ram
        __DATA_TAREA1_VMA_END = .;

    .rodata_tarea1 __RODATA_TAREA1_LIN :
        AT ( LOADADDR(.datos_tarea1) + SIZEOF(.datos_tarea1) )
        {
            __RODATA_TAREA1_LMA = LOADADDR(.rodata_tarea1);
            *(.rodata_tarea1);
        } > ram
        __RODATA_TAREA1_VMA_END = .;

    .text_tarea2 __TEXT_TAREA2_LIN :
        AT ( LOADADDR(.rodata_tarea1) + SIZEOF(.rodata_tarea1) )
        {
            __TEXT_TAREA2_LMA = LOADADDR(.text_tarea2);
            *(.text_tarea2); 
            *(.SIMD_tarea_2);
        } > ram
        __TEXT_TAREA2_VMA_END = .;

    .bss_tarea2 __BSS_TAREA2_LIN :
        AT ( LOADADDR(.text_tarea2) + SIZEOF(.text_tarea2) )
        {
            __BSS_TAREA2_LMA = LOADADDR(.bss_tarea2);
            *(.bss_tarea2);
        } > ram
        __BSS_TAREA2_VMA_END = .;

    .datos_tarea2 __DATA_TAREA2_LIN :
        AT ( LOADADDR(.bss_tarea2) + SIZEOF(.bss_tarea2) )
        {
            __DATA_TAREA2_LMA = LOADADDR(.datos_tarea2);
            *(.datos_tarea2);
        } > ram
        __DATA_TAREA2_VMA_END = .;

    .rodata_tarea2 __RODATA_TAREA2_LIN :
        AT ( LOADADDR(.datos_tarea2) + SIZEOF(.datos_tarea2) )
        {
            __RODATA_TAREA2_LMA = LOADADDR(.rodata_tarea2);
            *(.rodata_tarea2);
        } > ram
        __RODATA_TAREA2_VMA_END = .;

    .text_tarea3 __TEXT_TAREA3_LIN :
        AT ( LOADADDR(.rodata_tarea2) + SIZEOF(.rodata_tarea2) )
        {
            __TEXT_TAREA3_LMA = LOADADDR(.text_tarea3);
            *(.text_tarea3);
            *(.SIMD_tarea_3);
        } > ram
        __TEXT_TAREA3_VMA_END = .;

    .bss_tarea3 __BSS_TAREA3_LIN :
        AT ( LOADADDR(.text_tarea3) + SIZEOF(.text_tarea3) )
        {
            __BSS_TAREA3_LMA = LOADADDR(.bss_tarea3);
            *(.bss_tarea3);
        } > ram
        __BSS_TAREA3_VMA_END = .;

    .datos_tarea3 __DATA_TAREA3_LIN :
        AT ( LOADADDR(.bss_tarea3) + SIZEOF(.bss_tarea3) )
        {
            __DATA_TAREA3_LMA = LOADADDR(.datos_tarea3);
            *(.datos_tarea3);
        } > ram
        __DATA_TAREA3_VMA_END = .;

    .rodata_tarea3 __RODATA_TAREA3_LIN :
        AT ( LOADADDR(.datos_tarea3) + SIZEOF(.datos_tarea3) )
        {
            __RODATA_TAREA3_LMA = LOADADDR(.rodata_tarea3);
            *(.rodata_tarea3);
        } > ram
        __RODATA_TAREA3_VMA_END = .;

    .text_tarea0 __TEXT_tarea0_LIN :
        AT ( LOADADDR(.rodata_tarea3) + SIZEOF(.rodata_tarea3) )
        {
            __TEXT_tarea0_LMA = LOADADDR(.text_tarea0);
            *(.text_tarea0);
        } > ram
        __TEXT_tarea0_VMA_END = .;

    .bss_tarea0 __BSS_tarea0_LIN :
        AT ( LOADADDR(.text_tarea0) + SIZEOF(.text_tarea0) )
        {
            __BSS_tarea0_LMA = LOADADDR(.bss_tarea0);
            *(.bss_tarea0);
        } > ram
        __BSS_tarea0_VMA_END = .;

    .datos_tarea0 __DATA_tarea0_LIN :
        AT ( LOADADDR(.bss_tarea0) + SIZEOF(.bss_tarea0) )
        {
            __DATA_tarea0_LMA = LOADADDR(.datos_tarea0);
            *(.datos_tarea0);
        } > ram
        __DATA_tarea0_VMA_END = .;

    .rodata_tarea0 __RODATA_tarea0_LIN :
        AT ( LOADADDR(.datos_tarea0) + SIZEOF(.datos_tarea0) )
        {
            __RODATA_tarea0_LMA = LOADADDR(.rodata_tarea0);
            *(.rodata_tarea0);
        } > ram
        __RODATA_tarea0_VMA_END = .;

    .stak_kernel __STACK_KERNEL_LIN :
        AT ( LOADADDR(.rodata_tarea0) + SIZEOF(.rodata_tarea0) )
        {
            __STACK_KERNEL_LMA = LOADADDR(.stak_kernel);
            *(.stak_kernel);
        } > ram
        __STACK_KERNEL_VMA_END = .;

    .stak_tarea1 __STACK_TAREA1_LIN :
        AT ( LOADADDR(.stak_kernel) + SIZEOF(.stak_kernel) )
        {
            __STAK_TAREA1_LMA = LOADADDR(.stak_tarea1);
            *(.stak_tarea1);
        } > ram
        __STAK_TAREA1_VMA_END = .;

    .stak_tarea2 __STACK_TAREA2_LIN :
        AT ( LOADADDR(.stak_tarea1) + SIZEOF(.stak_tarea1) )
        {
            __STAK_TAREA2_LMA = LOADADDR(.stak_tarea2);
            *(.stak_tarea2);
        } > ram
        __STAK_TAREA2_VMA_END = .;

    .stak_tarea3 __STACK_TAREA3_LIN :
        AT ( LOADADDR(.stak_tarea2) + SIZEOF(.stak_tarea2) )
        {
            __STAK_TAREA3_LMA = LOADADDR(.stak_tarea3);
            *(.stak_tarea3);
        } > ram
        __STAK_TAREA3_VMA_END = .; 

    .stak_tarea0 __STACK_tarea0_LIN :
        AT ( LOADADDR(.stak_tarea3) + SIZEOF(.stak_tarea3) )
        {
            __STAK_tarea0_LMA = LOADADDR(.stak_tarea0);
            *(.stak_tarea0);
        } > ram
        __STAK_tarea0_VMA_END = .;               

    .reset __RESET :
        AT (__RESET)
        { 
            *(.reset); 
        } > rom

}