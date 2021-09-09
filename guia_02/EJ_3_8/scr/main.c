
#include "../inc/define.h"
#include "../inc/handler.h"


//-- Variables Globales --
int CANTCHLD = 0;


//-- MAIN --
int main (int argc, char *argv[]) 
{
int var = 0;
int i;

//	if(argc > 1)
//	{
//		CANTCHLD = argv[2]; 
//	}

	signal(SIGCHLD, SIGCHLD_handler);
	signal(SIGTERM, SIGTERM_handler);
	signal(SIGUSR1, SIGUSR1_handler);
	signal(SIGINT, SIGINT_handler);

	for(i=0;i<10;i++) 
    {
		kill(getpid(), SIGUSR1);
    }

    //Código del padre
	printf("Proceso padre ID = %d, Variable = %d \n\r", getpid(), var);
		
	sleep(30);
	printf("Muere el padre ID = %d\n\r", getpid());

	return(0);
} 

