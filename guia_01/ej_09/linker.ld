ENTRY (reset)

    __INIT_ROM              = 0xFFFF0000;
    __RESET                 = 0xFFFFFFF0;

   /*-----------------VMA-----------------*/
    __SYS_TABLES_VMA        = 0x00000000;
    __SYS_TABLES_PAG_VMA    = 0x00010000;
    __VIDEO_VMA             = 0x000B8000;
    __HANDLER_VMA           = 0x00100000;
    __DATOS_VMA             = 0x00200000;
    __TABLES_DIGITOS_VMA    = 0x00210000;
    __KERNEL_VMA            = 0x00220000;
    __TEXT_TAREA1_VMA       = 0x00310000;
    __BSS_TAREA1_VMA        = 0x00320000;
    __DATA_TAREA1_VMA       = 0x00330000;
    __RODATA_TAREA1_VMA     = 0x00340000;

    __STACK_KERNEL_VMA      = 0x1FFF8000;               /* stak de 4k */
    __STACK_KERNEL_END_VMA  = 0x1FFF8FFF;
    
    __STAK_TAREA1_VMA       = 0x1FFFF000;               /* stak de 4k */
    __STAK_TAREA1_END_VMA   = 0x1FFFFFFF;
    
    __INIT_VMA              = 0xFFFF0000;

    /*-----------------LMA-----------------*/
    __INIT_LMA              = 0xFFFF0000;


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
            *(.note.gnu.property);
            __INIT_size = SIZEOF(.init);        
        } > rom
        __INIT_VMA_END = .;

    .sys_tables __SYS_TABLES_VMA :
            AT ( LOADADDR(.init) + SIZEOF(.init))
        {
            __SYS_TABLES_LMA = LOADADDR(.sys_tables);
            *(.sys_tables); 
            __SYS_TABLES_size = SIZEOF(.sys_tables);
        } > ram
        __SYS_TABLES_VMA_END = .;

    .sys_tables_paginacion __SYS_TABLES_PAG_VMA :
            AT ( LOADADDR(.sys_tables) + SIZEOF(.sys_tables))
        {
            __SYS_TABLES_PAG_LMA = LOADADDR(.sys_tables_paginacion);
            *(.sys_tables_paginacion); 
            __SYS_TABLES_PAG_size = SIZEOF(.sys_tables_paginacion);
        } > ram
        __SYS_TABLES_PAG_VMA_END = .;

    .video __VIDEO_VMA :
        AT ( LOADADDR(.sys_tables_paginacion) + SIZEOF(.sys_tables_paginacion) )
        { 
            __VIDEO_LMA = LOADADDR(.video);
            *(.video);   
            __VIDEO_size = SIZEOF(.video);
        } > ram
        __VIDEO_VMA_END = .;

    .rutinas_handler __HANDLER_VMA :
        AT ( LOADADDR(.video) + SIZEOF(.video) )
        { 
            __HANDLER_LMA = LOADADDR(.rutinas_handler);
            *(.handler);   
            __HANDLER_size = SIZEOF(.rutinas_handler);
        } > ram
        __HANDLER_VMA_END = .;

    .data __DATOS_VMA :
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

    .tables_digito __TABLES_DIGITOS_VMA :
            AT ( LOADADDR(.data) + SIZEOF(.data))
        {
            __TABLES_DIGITOS_LMA = LOADADDR(.tables_digito);
            *(.tables_digito); 
            __TABLES_DIGITOS_size = SIZEOF(.tables_digito);
        } > ram
        __TABLES_DIGITOS_VMA_END = .;

    .kernel __KERNEL_VMA :
        AT ( LOADADDR(.tables_digito) + SIZEOF(.tables_digito) )
        { 
            __KERNEL_LMA = LOADADDR(.kernel);            
            *(.kernel); *(.funciones);  
            __KERNEL_size = SIZEOF(.kernel);        
        } > ram
        __KERNEL_VMA_END = .;

    .text_tarea1 __TEXT_TAREA1_VMA :
        AT ( LOADADDR(.kernel) + SIZEOF(.kernel) )
        {
            __TEXT_TAREA1_LMA = LOADADDR(.text_tarea1);
            *(.text_tarea1);
        } > ram
        __TEXT_TAREA1_VMA_END = .;

    .bss_tarea1 __BSS_TAREA1_VMA :
        AT ( LOADADDR(.text_tarea1) + SIZEOF(.text_tarea1) )
        {
            __BSS_TAREA1_LMA = LOADADDR(.bss_tarea1);
            *(.bss_tarea1);
        } > ram
        __BSS_TAREA1_VMA_END = .;

    .datos_tarea1 __DATA_TAREA1_VMA :
        AT ( LOADADDR(.bss_tarea1) + SIZEOF(.bss_tarea1) )
        {
            __DATA_TAREA1_LMA = LOADADDR(.datos_tarea1);
            *(.datos_tarea1);
        } > ram
        __DATA_TAREA1_VMA_END = .;

    .rodata_tarea1 __RODATA_TAREA1_VMA :
        AT ( LOADADDR(.datos_tarea1) + SIZEOF(.datos_tarea1) )
        {
            __RODATA_TAREA1_LMA = LOADADDR(.rodata_tarea1);
            *(.rodata_tarea1);
        } > ram
        __RODATA_TAREA1_VMA_END = .;

    .stak_kernel __STACK_KERNEL_VMA :
        AT ( LOADADDR(.rodata_tarea1) + SIZEOF(.rodata_tarea1) )
        {
            __STACK_KERNEL_LMA = LOADADDR(.rodata_tarea1);
            *(.stak_kernel);
        } > ram
        __STACK_KERNEL_VMA_END = .;

    .stak_tarea1 __STAK_TAREA1_VMA :
        AT ( LOADADDR(.stak_kernel) + SIZEOF(.stak_kernel) )
        {
            __STAK_TAREA1_LMA = LOADADDR(.rodata_tarea1);
            *(.stak_tarea1);
        } > ram
        __STAK_TAREA1_VMA_END = .;

    .reset __RESET :
        AT (__RESET)
        { 
            *(.reset); 
        } > rom

}