
//#include "../inc/define.h"
#include "../inc/handler.h"
#include "../inc/init.h"

//-- Variables Globales --
int pid;
int var = 0;

//-- MAIN --
int main (int argc, char *argv[]) 
{
int i;
int CANTCHLD = 0;

	init_signal();

	if(argc > 1)
	{
		CANTCHLD = (int)*argv[1] - '0'; 
	}

	for(i = 0; i < CANTCHLD; i++) 
    {
		pid = fork();

    	if(pid == 0)
    	{
			//Código del hijo
        	for(i=0; i < cantVar; i++)
       		{
            	printf("Proceso hijo ID=%d, mi padre es ID=%d, mi grupo ID=%d, var=%d\r\n", getpid(), getppid(), getpgrp(),var);
            	raise( SIGUSR1);
				sleep(10);
        	}
        	raise( SIGKILL);
			//exit(0);		
    	}
    }

    //Código del padre
	printf("Proceso padre ID = %d, Variable = %d \n\r", getpid(), var);

	wait(NULL);

	printf("Muere el padre ID = %d\n\r", getpid());

	return(0);
} 

