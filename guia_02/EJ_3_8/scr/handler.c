
#include "../inc/handler.h"

extern int CANTCHLD;

void SIGCHLD_handler(int sig)
{
    while (waitpid(-1, NULL, WNOHANG) != 0)
    {
        printf("handler SIGCHLD %d\r\n", getpid());
    }
}

void SIGTERM_handler(int sig)
{
    printf("handler SIGTERM %d\r\n", getpid());
}

void SIGUSR1_handler(int sig)
{
int pid,i;
static int cantPid=0;

    if(cantPid < 5)
    {
        pid = fork();
        cantPid++;
    }
    if(pid == 0)
    {
		//Código del hijo

        for(i=0; i < 5; i++)
        {
            printf("Proceso hijo ID=%d, mi parde es ID=%d, var=%d\r\n", getpid(), getppid(),i);
            sleep(5);
        }

        kill(getpid(), SIGKILL);
		//exit(0);		
    }
}

void SIGINT_handler(int sig)
{
    printf("Soy inmortal %d\r\n", getpid());
    sleep(1);
}
