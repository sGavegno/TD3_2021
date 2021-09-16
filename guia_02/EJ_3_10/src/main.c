
//#include "../inc/define.h"
#include "../inc/handler.h"
#include "../inc/init.h"

//-------Variables Externas--------------


//----- Variables Globales -----
char exitwhile = 1;

char buffer[200];
int pipebuff[2];

int idchld[MAXCHLD];

//----- FLAGS ------------
int FLAG_FIRST = 1;
int FLAG_CLOSE = 0;

//-- MAIN --
int main (int argc, char *argv[]) 
{
int i = 0;
char exitwhile = 1;



char buf[200];
unsigned char sizebufHijo;
unsigned char sizebufPadre;

	init_signal();

	pipe(pipebuff);

	pid = fork();
/*
	for(i = 0; i < MAXCHLD; i++)
	{
		if(pid > 0)
		{
        	if(cantchld < MAXCHLD)
        	{
            	pid = fork();
            	idchld[cantchld] = pid;
            	printf("Nacio el hijo ID=%d\r\n",idchld[cantchld]);
            	cantchld++;
        	} 
		}
	}
*/
	switch(pid)
	{
	case -1:
		
		break;
		
	case 0:
		//codigo del hijo
		close(pipebuff[0]);   /* CIERRO EXTREMO DE LECTURA */

		break;
		
	default:
		//Código del padre
		close(pipebuff[1]);   /* CIERRO EXTREMO DE ESCRITURA */

		break;
	}


	while(exitwhile)
	{
		if(pid == 0)
    	{
			//Código del hijo
			
			//getc(buf);
			read(0, buf, 20);

			sizebufHijo = (unsigned char)strlen(buf);
      		write(pipebuff[1], &sizebufHijo, 1);  /* ENVIO LONGITUD DEL BUFFER */
      		write(pipebuff[1], buf, sizebufHijo); /* ENVIO BUFFER */
			//printf("Proceso hijo ID=%d, mi padre es ID=%d, mi grupo ID=%d, var=%d\r\n", getpid(), getppid(), getpgrp(),var);
			sleep(10);
    	}
		else if(pid > 0)
		{
			//Código del padre
			read(pipebuff[0], &sizebufPadre, 1);  /* LEO LONGITUD DEL BUFFER */
      		read(pipebuff[0], buffer, sizebufPadre);  /* LEO BUFFER */
      		printf("%s\n\r", buffer);

			//printf("Yo soy tu padre %d, mi grupo ID=%d\n\r", getpid(), getpgrp());

			if(FLAG_KILL_PADRE == 1)
			{
				for(i=0; i < cantchld; i++)
				{
					kill(idchld[i], SIGKILL);
				}
				exitwhile = 0;
			}
			sleep(10);
		}
	}

	printf("Muere el padre ID = %d\n\r", getpid());

	return(0);
} 

