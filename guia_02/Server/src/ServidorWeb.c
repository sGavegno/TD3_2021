
#include "../inc/ServidorWeb.h"
#include "../inc/funciones.h"

/*---------------------FLAGS-------------------*/
bool config_flag = false, max_connected = true, exit_flag = false;

bool FLAG_EXIT = false;

/*---------------Variables Globales----------------*/
int semaforoID;
struct confServer *configuracionServer;
struct MPU6050_REGS *SensorData;
struct calibValues *calibration_data;

struct sembuf p = {0, -1, SEM_UNDO}; // Estructura para tomar el semáforo
struct sembuf v = {0, +1, SEM_UNDO}; // Estructura para liberar el semáforo

/***********************************************************
* MAIN                                           
* Parametro: Numero de Puerto                               
***********************************************************/
int main(int argc, char *argv[])
{
    int sock;
    int sensorPID;
    struct sockaddr_in datosServidor;
    socklen_t longDirec;
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
    sharMemId = shmget((key_t)KEY, SHARED_SIZE, 0666 | IPC_CREAT);
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

    // Point the struct to the corresponding shared memory.
    SensorData = (struct MPU6050_REGS *)sharMemAdd;
    calibration_data = (struct calibValues *)(sharMemAdd + sizeof(struct MPU6050_REGS) + MARGEN_DATOS);
    configuracionServer = (struct confServer *)(calibration_data + sizeof(struct calibValues) + MARGEN_DATOS);

    //Creacion del semaforo
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
*******************AGREGAR CONFIGURACION DEL SENSOR************
**************************************************************/

    // -------> Calibracion del sensor <-------
    semop(semaforoID, &p, 1); //Tomo el semaforo
    calibration_data->X_min = 0;
    calibration_data->Y_min = 0;
    calibration_data->Z_min = 0;
    calibration_data->X_max = 0;
    calibration_data->Y_max = 0;
    calibration_data->Z_max = 0;
    calibration_data->firstCalibFlag = true;
    semop(semaforoID, &v, 1); //Libreo el semaforo
    // ------------REVISAR CALIBRACION----------------
    // -----------MUY PROBABLE QUE SE BORRE-----------------

    //--------Configuracion del Server----------
    if (leerConfServer() < 0)
    {                             //no se encontro el archivo o no se pudo leer
        semop(semaforoID, &p, 1); //Tomo el semaforo
        configuracionServer->backlog = 20;
        configuracionServer->conexiones_actuales = 0;
        configuracionServer->conexiones_max = 100;
        configuracionServer->muestreo = 2;
        semop(semaforoID, &v, 1); //Libreo el semaforo
    }

    // Creo el socket
    sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock == -1)
    {
        printf("ERROR: El socket no se ha creado correctamente!\n");
        shmdt(sharMemAdd);                 //Separo la memoria del proceso
        semctl(semaforoID, 0, IPC_RMID);   //Cierro el semaforo
        shmctl(sharMemId, IPC_RMID, NULL); //Cierro la Shared Memory
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
        shmdt(sharMemAdd);                 //Separo la memoria del proceso
        semctl(semaforoID, 0, IPC_RMID);   //Cierro el semaforo
        shmctl(sharMemId, IPC_RMID, NULL); //Cierro la Shared Memory
        close(sock);
        exit(1);
    }
    char ipAddr[20];
    strcpy(ipAddr, inet_ntoa(datosServidor.sin_addr));
    printf("\nIngrese en el navegador http://%s:%s\n", ipAddr, argv[1]);

    int auxBacklog = 0;
    // Indicar que el socket encole hasta backlog pedidos
    // de conexion simultaneas.
    semop(semaforoID, &p, 1); //Tomo el semaforo
    auxBacklog = configuracionServer->backlog;
    semop(semaforoID, &v, 1); //Libreo el semaforo

    if (listen(sock, auxBacklog) < 0)
    {

        perror("Error en listen");
        shmdt(sharMemAdd);                 //Separo la memoria del proceso
        semctl(semaforoID, 0, IPC_RMID);   //Cierro el semaforo
        shmctl(sharMemId, IPC_RMID, NULL); //Cierro la Shared Memory
        close(sock);
        exit(1);
    }

    // child configuracion
    sensorPID = fork();
    if (sensorPID < 0)
    {
        shmdt(sharMemAdd);                 //Separo la memoria del proceso
        semctl(semaforoID, 0, IPC_RMID);   //Cierro el semaforo
        shmctl(sharMemId, IPC_RMID, NULL); //Cierro la Shared Memory
        close(sock);
        exit(1);
    }
    if (sensorPID == 0)
    {
        //Funcion para manejar el sensor
        ManejadorSensor();

        shmdt(sharMemAdd);               //Separo la memoria del proceso
        semctl(semaforoID, 0, IPC_RMID); //Cierro el semaforo
        close(sock);
        exit(1);
    }

    // child que controla es sensor
    sensorPID = fork();
    if (sensorPID < 0)
    {
        shmdt(sharMemAdd);                 //Separo la memoria del proceso
        semctl(semaforoID, 0, IPC_RMID);   //Cierro el semaforo
        shmctl(sharMemId, IPC_RMID, NULL); //Cierro la Shared Memory
        close(sock);
        exit(1);
    }
    if (sensorPID == 0)
    {
        //Funcion para manejar el sensor
        ManejadorSensor();

        shmdt(sharMemAdd);               //Separo la memoria del proceso
        semctl(semaforoID, 0, IPC_RMID); //Cierro el semaforo
        close(sock);
        exit(1);
    }

    // Permite atender a multiples usuarios
    while (!FLAG_EXIT)
    {
        int clientePID, sock_aux;
        struct sockaddr_in datosCliente;
        // La funcion accept rellena la estructura address con
        // informacion del cliente y pone en longDirec la longitud
        // de la estructura.
        longDirec = sizeof(datosCliente);
        sock_aux = accept(sock, (struct sockaddr *)&datosCliente, &longDirec);
        if (sock_aux < 0)
        {
            perror("Error en accept");
            shmdt(sharMemAdd);               //Separo la memoria del proceso
            semctl(semaforoID, 0, IPC_RMID); //Cierro el semaforo
            close(sock);
            exit(1);
        }
        clientePID = fork();
        if (clientePID < 0)
        {
            perror("No se puede crear un nuevo proceso mediante fork");
            close(sock);
            exit(1);
        }
        if (clientePID == 0)
        { // Proceso hijo.
            ProcesarCliente(sock_aux, &datosCliente, atoi(argv[1]));
            exit(0);
        }
        close(sock_aux); // El proceso padre debe cerrar el socket
                         // que usa el hijo.
    }

    //Falta cerrar los semaforos y sharedmemory
    shmdt(sharMemAdd);                      //Separo la memoria del proceso
    semctl(semaforoID, 0, IPC_RMID);        //Cierro el semaforo
    shmctl(sharMemId, IPC_RMID, NULL);      //Cierro la Shared Memory
    close(sock);

    wait(NULL);
}

/**
 * @fn void ProcesarCliente(int s_aux, struct sockaddr_in *pDireccionCliente, int puerto)
 * @brief 
 * @details 
 * @param s_aux
 * @param pDireccionCliente puntero a la direccion IP del servidor 
 * @param puerto Puerto utilizado por el servidor
 * @return void
**/
void ProcesarCliente(int s_aux, struct sockaddr_in *pDireccionCliente, int puerto)
{
    char bufferComunic[8162]; //8KB       antes 4KB 4096
    char ipAddr[20];
    int Port;
    char HTML[4096];           //1KB       antes 4KB 4096
    char encabezadoHTML[1024]; //1KB       antes 4KB 4096

    strcpy(ipAddr, inet_ntoa(pDireccionCliente->sin_addr));
    Port = ntohs(pDireccionCliente->sin_port);
    // Recibe el mensaje del cliente
    if (recv(s_aux, bufferComunic, sizeof(bufferComunic), 0) == -1)
    {
        perror("Error en recv");
        exit(1);
    }
    printf("* Recibido del navegador Web %s:%d:\n%s\n",
           ipAddr, Port, bufferComunic);

    // Generar HTML.
    // El viewport es obligatorio para que se vea bien en
    // dispositivos móviles.
    semop(semaforoID, &p, 1); //Tomo el semaforo
    sprintf(encabezadoHTML, "<html><head><title>ServerWeb</title>"
                            "<meta name=\"viewport\" "
                            "content=\"width=device-width, initial-scale=2.0\">"
                            "</head>"
                            "<h1>ServerWeb</h1>");

    sprintf(HTML,
            "%s<p> Hola, soy Dario Cecilio Alpern.</p>"
            "<p> Esta es una prueba del Servidor Web.</p>"
            "<p> Esta pagina es muy reconocida por instituciones gubernamentales de EEUU.</p>"
            "<p> Valores del sensor: </p>"
            "<p> accel_Xout = %d</p>"
            "<p> accel_Yout = %d</p>"
            "<p> accel_Zout = %d</p>"
            "<p> temp_out   = %d</p>"
            "<p> gyro_xout  = %d</p>"
            "<p> gyro_xout  = %d</p>"
            "<p> gyro_xout  = %d</p>",
            encabezadoHTML, SensorData->accel_xout, SensorData->accel_yout, SensorData->accel_zout,
            SensorData->temp_out, SensorData->gyro_xout, SensorData->gyro_yout, SensorData->gyro_zout);

    sprintf(bufferComunic,
            "HTTP/1.1 200 OK\n"
            "Content-Length: %ld\n"
            "Content-Type: text/html; charset=utf-8\n"
            "Connection: Closed\n\n%s",
            strlen(HTML), HTML);
    semop(semaforoID, &v, 1); //Libreo el semaforo

    printf("* Enviado al navegador Web %s:%d:\n%s\n",
           ipAddr, Port, bufferComunic);

    // Envia el mensaje al cliente
    if (send(s_aux, bufferComunic, strlen(bufferComunic), 0) == -1)
    {
        perror("Error en send");
        exit(1);
    }
    // Cierra la conexion con el cliente actual
    close(s_aux);
}

void ManejadorSensor(void)
{
    srand(300); // Inicializa generador de numeros random. Podria haberle pasado cualquier número.
    signal(SIGINT, SIGINT_handler_Sensor);

    printf("Manejador del Sensor\n");

    while (!FLAG_EXIT)
    {
        semop(semaforoID, &p, 1); //Tomo el semaforo
        SensorData->accel_xout = rand();
        SensorData->accel_yout = rand();
        SensorData->accel_zout = rand();
        SensorData->temp_out = rand();
        SensorData->gyro_xout = rand();
        SensorData->gyro_yout = rand();
        SensorData->gyro_zout = rand();
        semop(semaforoID, &v, 1); //Libreo el semaforo

        sleep(0.001);
    }
    exit(0);
}

void SIGINT_handler_Sensor(int signbr)
{
    FLAG_EXIT = true;
}

void SIGINT_handler(int signbr)
{
    FLAG_EXIT = true;
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
    //actualizar configuracion
    return;
}