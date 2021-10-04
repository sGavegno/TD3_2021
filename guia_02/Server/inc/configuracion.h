

#define CANT_CONEX_MAX_DEFAULT  100
#define BACKLOG_DEFAULT         20
#define MUESTREO_SENSOR         2

#define CONFIG_RUTA             "./Config/Configuracion.cfg"


void configuracion_init( struct confServer *serverConf);
void configuracion_reload(struct confServer *serverConf);