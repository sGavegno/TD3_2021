ENTRY (reset)

    __INIT_ROM              = 0xFFFF0000;
    __RESET                 = 0xFFFFFFF0;

    __STACK_START = 0x2FFF4000;
    __STACK_END = 0x2FFF8000;
    __STACK_SIZE = ((__STACK_END - __STACK_START)/4); /*32b word*/

   /*-----------------VMA-----------------*/
    __SYS_TABLES_VMA        = 0x00000000;
    __HANDLER_VMA           = 0x00100000;
    __TABLES_DIGITOS_VMA    = 0x00200000;
    __DATOS_VMA             = 0x00210000;
    __KERNEL_VMA            = 0x00202000;
    __DATA_VMA              = 0x00210000;

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

    .rutinas_handler __HANDLER_VMA :
        AT ( LOADADDR(.sys_tables) + SIZEOF(.sys_tables) )
        { 
            __HANDLER_LMA = LOADADDR(.rutinas_handler);
            *(.handler);   
            __HANDLER_size = SIZEOF(.rutinas_handler);
        } > ram
        __HANDLER_VMA_END = .;

    .tables_digito __TABLES_DIGITOS_VMA :
            AT ( LOADADDR(.rutinas_handler) + SIZEOF(.rutinas_handler))
        {
            __TABLES_DIGITOS_LMA = LOADADDR(.tables_digito);
            *(.tables_digito); 
            __TABLES_DIGITOS_size = SIZEOF(.tables_digito);
        } > ram
        __TABLES_DIGITOS_VMA_END = .;

    .data __DATA_VMA :
        AT ( LOADADDR(.tables_digito) + SIZEOF(.tables_digito))
        {
            __DATA_LMA = LOADADDR(.data);
            *(.data);
            *(.rodata);
            *(.bss); 
            __DATA_size = SIZEOF(.data);
        } > ram
        __DATA_VMA_END = .;

    .kernel __KERNEL_VMA :
        AT ( LOADADDR(.data) + SIZEOF(.data) )
        { 
            __KERNEL_LMA = LOADADDR(.kernel);            
            *(.kernel); *(.rutinas); *(.funciones);  
            __KERNEL_size = SIZEOF(.kernel);        
        } > ram
        __KERNEL_VMA_END = .;

    .reset __RESET :
        AT (__RESET)
        { 
            *(.reset); 
        } > rom

}