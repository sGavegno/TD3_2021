
#include "../inc/ServidorWeb.h"

bool config_flag = false, max_connected = true, exit_flag = false;

void SIGINT_handler(int signbr)
{
    exit_flag = true;
    printf("\n");
    print_msg(__FILE__, "Exiting server and closing sensor process.");
}

void SIGCHLD_handler(int signbr)
{
    pid_t child_pid;
    int status_child;
    while ((child_pid = waitpid(-1, &status_child, WNOHANG)) > 0)
    {
        //   print_msg_wValue(__FILE__, "Dead child PID: %d", (long)child_pid);
    }
    return;
}

void SIGUSR1_handler(int signbr)
{
    config_flag = true;
    print_msg(__FILE__, "Updating configuration.");
    return;
}

/***********************************************************
* MAIN                                           
* Parametro: Numero de Puerto                               
***********************************************************/
int main(int argc, char *argv[])
{
    int sock;
    int pid, i;
    int semaforoID;
    struct sockaddr_in datosServidor;
    socklen_t longDirec;
    pid_t server_pid, httpClient_pid, sensor_query_pid;
    int sharMemId;
    void *sharMemAdd = (void *)0;

    if (argc != 2)
    {
        printf("\n\nFalta especificar el PUERTO\n\n");
        exit(1);
    }

    // Signal handlers
    signal(SIGINT, SIGINT_handler);
    signal(SIGCHLD, SIGCHLD_handler);
    signal(SIGUSR1, SIGUSR1_handler);

    // Creo la Shared memory de 4096 Byte
    sharMemId = shmget((key_t)1234, SHARED_SIZE, 0666 | IPC_CREAT);
    if (sharMemId == -1)
    {
        printf("ERROR: No se pudo crear la Shared Memory\n");
        return -1;
    }
    //addr apunta a la memoria compartida
    sharMemAdd = shmat(sharMemId, (void *)0, 0);
    if (sharMemAdd == (void *)-1)
    {
        printf("ERROR: No se pudo obtener el addres de la Shared Memory\n");
        return -1;
    }

    semaforoID = semget(KEY, 1, 0666 | IPC_CREAT); // semget crea 1 semáforo con permisos rw rw rw
    if (semaforoID < 0)
    {
        perror("ERROR: No se pudo abrir el semaforo\n");
        semctl(semaforoID, 0, IPC_RMID); //Cierro el semaforo
        exit(11);                        // Chequea que este bien creado el semáforo
    }

    union semun u; // Crea la union
    u.val = 1;     // Asigna un 1 al val
    // Inicializo el semáforo para utilizarlo
    if (semctl(semaforoID, 0, SETVAL, u) < 0)
    {
        perror("ERROR: No se pudo inicializar el semaforo");

        shmdt(sharMemAdd);                 //Separo la memoria del proceso
        semctl(semaforoID, 0, IPC_RMID);   //Cierro el semaforo
        shmctl(sharMemId, IPC_RMID, NULL); //Cierro la Shared Memory

        exit(12);
    }

    /**************************************************************
***************************************************************
********************AGREGAR CONFIGURACION**********************
***************************************************************
**************************************************************/

    // Creo el socket
    sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock == -1)
    {
        printf("ERROR: El socket no se ha creado correctamente!\n");
        shmdt(sharMemAdd); //Separo la memoria del proceso
        exit(1);
    }

    // Asigna el puerto indicado y una IP de la maquina
    datosServidor.sin_family = AF_INET;
    datosServidor.sin_port = htons(atoi(argv[1]));
    datosServidor.sin_addr.s_addr = htonl(INADDR_ANY);

    // Obtiene el puerto para este proceso.
    if (bind(sock, (struct sockaddr *)&datosServidor, sizeof(datosServidor)) == -1)
    {
        printf("ERROR: este proceso no puede tomar el puerto %s\n", argv[1]);
        shmdt(sharMemAdd);
        close(sock);
        exit(1);
    }
    printf("\nIngrese en el navegador http://dir ip servidor:%s\n", argv[1]);
    // Indicar que el socket encole hasta MAX_CONN pedidos
    // de conexion simultaneas.
    if (listen(sock, MAX_CONN) < 0)
    {
        perror("Error en listen");
        shmdt(sharMemAdd);
        close(sock);        
        exit(1);
    }



}
