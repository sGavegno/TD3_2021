/*
*   Autor: Gavegno Sebastian
*   Fecha: 17/10/2021
*   Detalles: Driver para la lectura del sensor MPU6050 por medio de I2C
*/
#include "../inc/I2Cdriver.h"
#include "../inc/MPU6050.h"
#include "../inc/BBB_reg_I2C.h"

static void __iomem *cmper_baseAddr, *ctlmod_baseAddr, *i2c2_baseAddr;
volatile int virq;

uint8_t tx_registro = 0;
uint8_t tx_modo = 0;
uint8_t tx_data = 0;
uint8_t rx_data = 0;

char *MPUpage;

// queue
volatile int queue_cond = 0;
wait_queue_head_t queue = __WAIT_QUEUE_HEAD_INITIALIZER(queue);
wait_queue_head_t queue_in = __WAIT_QUEUE_HEAD_INITIALIZER(queue_in);
wait_queue_head_t queue_ctrlopen = __WAIT_QUEUE_HEAD_INITIALIZER(queue_ctrlopen);

// variables para config
int Gscale = GFS_250DPS;
int Ascale = AFS_2G;
int Aaxis = AXIS_X;

/*  ID table */
static struct of_device_id MPU6050_id[] = {
	{
		.compatible = COMPATIBLE,
	},
	{}};

MODULE_DEVICE_TABLE(of, MPU6050_id);

//driver functions
static struct platform_driver I2C_MPU6050_pd = {
	.probe = I2C_MPU6050_probe,
	.remove = I2C_MPU6050_remove,
	.driver = {
		.name = COMPATIBLE,
		.of_match_table = of_match_ptr(MPU6050_id)},
};

int I2C_MPU6050_open(struct inode *inode, struct file *file)
{
	pr_alert("%s: I2C driver open\n", ID);

	// pido una pagina para usar como espacio lectura (vector)
	if ((MPUpage = (char *)__get_free_page(GFP_KERNEL)) < 0)
	{
		pr_alert("%s: Falla al pedir memoria\n", ID);
		return -1;
	}
	pr_alert("%s: I2C driver open exit\n", ID);

	return 0;
}

int I2C_MPU6050_release(struct inode *inode, struct file *file)
{
	pr_alert("%s: I2C driver close\n", ID);
	// libero la pagina que tome para lectura
	free_page((unsigned long)MPUpage);
	return 0;
}

ssize_t I2C_MPU6050_write(struct file *file, const char __user *userbuff, size_t tamano, loff_t *offset)
{
	pr_alert("%s: I2C driver write\n", ID);
	return 0;
}

ssize_t I2C_MPU6050_read(struct file *file, char __user *userbuff, size_t tamano, loff_t *offset)
{
	uint8_t aux_H, aux_L;

	pr_alert("%s: I2C driver read\n", ID);

	if (access_ok(VERIFY_WRITE, userbuff, tamano) == 0)
	{
		pr_alert("%s: Falla buffer de usuario\n", ID);
		return -1;
	}
	//Nunca leer mas del tamaño limite de memoria de datos.
	if (tamano > sizeof(datosI2C))
	{
		tamano = sizeof(datosI2C); //Si me pasan un tamaño mayor al de la estructura lo seteo con el maximo
	}
	pr_alert("%sdato: Lectura MPU6050\n", ID);
	pr_alert("%sdato:----------------------------------------\n", ID);
	// leo HSB acelerometro
	MPU6050_writebyte(ACCEL_XOUT_H, 0x00, Tx_MODO_LECTURA);
	aux_H = MPU6050_readbyte();
	// leo LSB acelerometro
	MPU6050_writebyte(ACCEL_XOUT_L, 0x00, Tx_MODO_LECTURA);
	aux_L = MPU6050_readbyte();
	// Dato de 16 bits
	datosI2C.accel_xout = (uint16_t)((aux_H << 8) | aux_L);
	pr_alert("%sdato: Acelerometro eje X:  %d\n", ID, datosI2C.accel_xout);

	// leo HSB acelerometro
	MPU6050_writebyte(ACCEL_YOUT_H, 0x00, Tx_MODO_LECTURA);
	aux_H = MPU6050_readbyte();
	// leo LSB acelerometro
	MPU6050_writebyte(ACCEL_YOUT_L, 0x00, Tx_MODO_LECTURA);
	aux_L = MPU6050_readbyte();
	// Dato de 16 bits
	datosI2C.accel_yout = (uint16_t)((aux_H << 8) | aux_L);
	pr_alert("%sdato: Acelerometro eje Y:  %d\n", ID, datosI2C.accel_yout);

	// leo HSB acelerometro
	MPU6050_writebyte(ACCEL_ZOUT_H, 0x00, Tx_MODO_LECTURA);
	aux_H = MPU6050_readbyte();
	// leo LSB acelerometro
	MPU6050_writebyte(ACCEL_ZOUT_L, 0x00, Tx_MODO_LECTURA);
	aux_L = MPU6050_readbyte();
	// Dato de 16 bits
	datosI2C.accel_zout = (uint16_t)((aux_H << 8) | aux_L);
	pr_alert("%sdato: Acelerometro eje Z:  %d\n", ID, datosI2C.accel_zout);

	// leo HSB Temperatura
	MPU6050_writebyte(TEMP_OUT_H, 0x00, Tx_MODO_LECTURA);
	aux_H = MPU6050_readbyte();
	// leo LSB Temperatura
	MPU6050_writebyte(TEMP_OUT_L, 0x00, Tx_MODO_LECTURA);
	aux_L = MPU6050_readbyte();
	// Dato de 16 bits
	datosI2C.temp_out = (uint16_t)((aux_H << 8) | aux_L);
	pr_alert("%sdato: Temperatura:  %d\n", ID, datosI2C.temp_out);

	// leo HSB Gyroscopio
	MPU6050_writebyte(GYRO_XOUT_H, 0x00, Tx_MODO_LECTURA);
	aux_H = MPU6050_readbyte();
	// leo LSB Gyroscopio
	MPU6050_writebyte(GYRO_XOUT_L, 0x00, Tx_MODO_LECTURA);
	aux_L = MPU6050_readbyte();
	// Dato de 16 bits
	datosI2C.gyro_xout = (uint16_t)((aux_H << 8) | aux_L);
	pr_alert("%sdato: Gyroscopio eje X:  %d\n", ID, datosI2C.gyro_xout);

	// leo HSB Gyroscopio
	MPU6050_writebyte(GYRO_YOUT_H, 0x00, Tx_MODO_LECTURA);
	aux_H = MPU6050_readbyte();
	// leo LSB Gyroscopio
	MPU6050_writebyte(GYRO_YOUT_L, 0x00, Tx_MODO_LECTURA);
	aux_L = MPU6050_readbyte();
	// Dato de 16 bits
	datosI2C.gyro_yout = (uint16_t)((aux_H << 8) | aux_L);
	pr_alert("%sdato: Gyroscopio eje Y:  %d\n", ID, datosI2C.gyro_yout);

	// leo HSB Gyroscopio
	MPU6050_writebyte(GYRO_ZOUT_H, 0x00, Tx_MODO_LECTURA);
	aux_H = MPU6050_readbyte();
	// leo LSB Gyroscopio
	MPU6050_writebyte(GYRO_ZOUT_L, 0x00, Tx_MODO_LECTURA);
	aux_L = MPU6050_readbyte();
	// Dato de 16 bits
	datosI2C.gyro_zout = (uint16_t)((aux_H << 8) | aux_L);
	pr_alert("%sdato: Gyroscopio eje Z:  %d\n", ID, datosI2C.gyro_zout);
	pr_alert("%sdato: ----------------------------------------\n", ID);

	pr_alert("%s: copy_to_user\n", ID);
	if (copy_to_user(userbuff, &datosI2C, tamano) > 0) //en copia correcta devuelve 0
	{
		pr_alert("%s: Falla en copia de buffer de kernel a buffer de usuario\n", ID);
		return -1;
	}

	return 0;
}

irqreturn_t i2c_irq_handler(int irq, void *dev_id, struct pt_regs *regs)
{
	static uint8_t cont = 0;
	uint32_t irq_status;
	uint32_t reg_valor;

	pr_alert("%s: Entro IRQ handler\n", ID);

	// check tipo de irq
	irq_status = ioread32(i2c2_baseAddr + I2C_IRQSTATUS);

	if (irq_status & I2C_IRQENABLE_CLR_ACK)
	{
		pr_alert("%s: IRQ handler ACK\n", ID);
	}

	if (irq_status & I2C_IRQSTATUS_RRDY)
	{
		// leo dato
		rx_data = ioread8(i2c2_baseAddr + I2C_DATA);
		pr_alert("%s: IRQ handler source -> RX: %#04x\n", ID, rx_data);
		// borro flags
		reg_valor = ioread32(i2c2_baseAddr + I2C_IRQSTATUS);
		reg_valor |= 0x27;
		iowrite32(reg_valor, i2c2_baseAddr + I2C_IRQSTATUS);

		// desabilito interupcion rx
		reg_valor = ioread32(i2c2_baseAddr + I2C_IRQENABLE_CLR);
		reg_valor |= I2C_IRQSTATUS_RRDY;
		iowrite32(reg_valor, i2c2_baseAddr + I2C_IRQENABLE_CLR);

		// wake up read
		queue_cond = 1;
		wake_up_interruptible(&queue);
	}

	if (irq_status & I2C_IRQSTATUS_XRDY)
	{
		if (tx_modo == Tx_MODO_ESCRITURA)
		{
			if (cont > 0)
			{
				pr_alert("%s: IRQ handler source -> TX_dato: %#04x\n", ID, tx_data);
				// escribo dato
				iowrite8(tx_data, i2c2_baseAddr + I2C_DATA);
				cont = 0;

				// desabilito interupcion tx
				reg_valor = ioread32(i2c2_baseAddr + I2C_IRQENABLE_CLR);
				reg_valor |= I2C_IRQSTATUS_XRDY;
				iowrite32(reg_valor, i2c2_baseAddr + I2C_IRQENABLE_CLR);

				// wake up write
				queue_cond = 1;
				wake_up(&queue_in); //ininterumpible
				//wake_up_interruptible(&queue);
			}
			else
			{
				pr_alert("%s: IRQ handler source -> TX_reg: %#04x\n", ID, tx_registro);
				// write registro
				iowrite8(tx_registro, i2c2_baseAddr + I2C_DATA);
				cont++;
			}
		}
		if (tx_modo == Tx_MODO_LECTURA)
		{
			pr_alert("%s: IRQ handler source -> TX_reg: %#04x\n", ID, tx_registro);
			// escribo registro
			iowrite8(tx_registro, i2c2_baseAddr + I2C_DATA);
			// wake up write
			queue_cond = 1;
			wake_up(&queue_in); //ininterumpible
			//wake_up_interruptible(&queue);
		}

		// Borro flags
		reg_valor = ioread32(i2c2_baseAddr + I2C_IRQSTATUS);
		reg_valor |= 0x36;
		iowrite32(reg_valor, i2c2_baseAddr + I2C_IRQSTATUS);
	}

	// Borro todos los flags
	irq_status = ioread32(i2c2_baseAddr + I2C_IRQSTATUS);
	irq_status |= 0x3F;
	iowrite32(irq_status, i2c2_baseAddr + I2C_IRQSTATUS);

	pr_alert("%s: IRQ handler OK\n", ID);
	return IRQ_HANDLED;
}

/*
* Función para verificar que el dispositivo esté presente dentro del platform-bus, se reservan los recursos de hardware
* del sistema que sean necesarios (Memoria de kernel, IRQ line, handler de interrupción, …) 
* y se configura el platform device para el funcionamiento del mismo
*/
int I2C_MPU6050_probe(struct platform_device *i2c_pd)
{
	int estado = 0;
	uint8_t aux;

	pr_alert("%s: I2C driver probe\n", ID);
	// ----Mapeo el registro CM_PER----
	if ((cmper_baseAddr = ioremap(CM_PER, CM_PER_LEN)) == NULL)
	{
		pr_alert("%s: No pudo mapear CM_PER\n", ID);
		return 1;
	}
	pr_info("%s: cmper_baseAddr: 0x%X\n", ID, (unsigned int)cmper_baseAddr);

	// ----Mapeo el registro CONTROL MODULE----
	if ((ctlmod_baseAddr = ioremap(CTRL_MODULE_BASE, CTRL_MODULE_LEN)) == NULL)
	{
		pr_alert("%s: No pudo mapear CONTROL MODULE\n", ID);
		iounmap(cmper_baseAddr);
		return 1;
	}
	pr_info("%s: ctlmod_baseAddr: 0x%X\n", ID, (unsigned int)ctlmod_baseAddr);

	// ----Habilito el clock del I2C----
	aux = ioread32(cmper_baseAddr + IDCM_PER_I2C2_CLKCTRL);
	aux |= 0x02; //MODULEMODE - 0x2 = ENABLE
	iowrite32(aux, cmper_baseAddr + IDCM_PER_I2C2_CLKCTRL);

	msleep(10); // Espero a que este listo el clock

	// ----Habilito pines de SDA y SCL-----		 pinmux: perifericos de i2c2 usa pinout de uart1 (page1368)
	iowrite32(0x33, ctlmod_baseAddr + CTRL_MODULE_UART1_CTSN); //pin 20 = sda
	iowrite32(0x33, ctlmod_baseAddr + CTRL_MODULE_UART1_RTSN); //pin 19 = scl

	// ----Mapeo el registro I2C2----
	if ((i2c2_baseAddr = ioremap(I2C2, I2C2_LEN)) == NULL)
	{
		pr_alert("%s: No pudo mapear I2C\n", ID);
		iounmap(cmper_baseAddr);
		iounmap(ctlmod_baseAddr);
		return 1;
	}
	pr_info("%s: i2c2_baseAddr: 0x%X\n", ID, (unsigned int)i2c2_baseAddr);

	// ----Configuracion de VirtualIRQ----
	// Pido un número de interrupcion
	if ((virq = platform_get_irq(i2c_pd, 0)) < 0)
	{
		pr_alert("%s: No se le pudo asignar una VIRQ\n", ID);
		iounmap(cmper_baseAddr);
		iounmap(ctlmod_baseAddr);
		iounmap(i2c2_baseAddr);
		return 1;
	}

	// Lo asigno a mi handler
	if (request_irq(virq, (irq_handler_t)i2c_irq_handler, IRQF_TRIGGER_RISING, COMPATIBLE, NULL))
	{
		pr_alert("%s: No se le pudo bindear VIRQ con handler\n", ID);
		iounmap(cmper_baseAddr);
		iounmap(ctlmod_baseAddr);
		iounmap(i2c2_baseAddr);
		return 1;
	}
	pr_info("%s: Numero de IRQ %d\n", ID, virq);

	// ----Seteo de Registros de los pines I2C----
	// config registro -> desabilito I2C2
	iowrite32(0x00, i2c2_baseAddr + I2C_CON);
	// config prescaler a 12MHz
	iowrite32(0x03, i2c2_baseAddr + I2C_PSC); //Prescaler de 3 -> div 4

	// config SCL
	iowrite32(0x08, i2c2_baseAddr + I2C_SCLL); // SCL_LOW = (SCLL + 7)* 1 / 12Mhz =  1,25uS   (MPU6050 -> MAX 2,5 us - MIN 0,6us)
	iowrite32(0x14, i2c2_baseAddr + I2C_SCLH); // SCL_HIGH = (SCLH + 7)* 1 / 12Mhz = 1,666666us (MPU6050 -> MAX 2,5 us - MIN 1,3us)

	// set a random own address
	//iowrite32(0x77, i2c2_baseAddr + I2C_OA);

	// slave address -> MPU6050
	iowrite32(MPU6050_DEFAULT_ADDRESS, i2c2_baseAddr + I2C_SA);

	// config registro -> ENABLE & MASTER & RX & STOP
	iowrite32(0x8000, i2c2_baseAddr + I2C_CON);

	// inicializacion IMU MPU6050
	initMPU6050();

	pr_info("%s: Termina PROBE ..\n", ID);
	return estado;
}

//remove function
/*
* Función para remover un dispositivo dentro del platform-bus
*/
int I2C_MPU6050_remove(struct platform_device *i2c_pd)
{
	int estado = 0;

	pr_alert("%s: I2C driver remove\n", ID);

	iounmap(cmper_baseAddr);
	iounmap(ctlmod_baseAddr);
	iounmap(i2c2_baseAddr);

	free_irq(virq, NULL);

	pr_alert("%s: Salí del REMOVE\n", ID);
	return estado;
}

static int I2C_MPU6050_devnode(struct device *dev, struct kobj_uevent_env *env)
{
	add_uevent_var(env, "DEVMODE=%#o", 0666);
	return 0;
}

static int __init I2C_MPU6050_init(void)
{
	int retorno = 0;
	pr_alert("%s: Asignar memoria al Char Device\n", ID);

	//Asigna un rango de números de char device.
	if ((retorno = alloc_chrdev_region(&dev.I2C_MPU6050, FIRST_MINOR, CANT_DISP, NOMBRE)) < 0)
	{
		pr_alert("%s: No es posible asignar el numero mayor\n", ID);
		return retorno;
	}
	pr_alert("%s: Numero mayor asignado %d 0x%X\n", ID, MAJOR(dev.I2C_MPU6050), MAJOR(dev.I2C_MPU6050));

	dev.I2C_MPU6050_cdev = cdev_alloc();
	if (dev.I2C_MPU6050_cdev < 0)
	{
		pr_alert("%s: No se pudo realizar cdev_alloc\n", ID);
		unregister_chrdev_region(dev.I2C_MPU6050, CANT_DISP);
		return -1;
	}

	//Inicializa cdev, recordando fops, preparándolo para añadirlo al sistema con cdev_add.
	cdev_init(dev.I2C_MPU6050_cdev, &I2C_MPU6050_ops); // Equivale a:  dev.I2C_MPU6050cdev->ops = &I2C_MPU6050_ops;

	// añadir un char device al sistema
	if ((retorno = cdev_add(dev.I2C_MPU6050_cdev, dev.I2C_MPU6050, CANT_DISP)) < 0) // Equivale a: dev.I2C_MPU6050cdev->owner = THIS_MODULE;
	{																				// 	         dev.I2C_MPU6050cdev->dev = dev.I2C_MPU6050;
		// anular el registro de un rango de números de char device
		cdev_del(dev.I2C_MPU6050_cdev);
		unregister_chrdev_region(dev.I2C_MPU6050, CANT_DISP);
		pr_alert("%s: No es no es posible registrar el dispositivo\n", ID);
		return retorno;
	}

	// Creo clase de dispositivo
	if ((dev.I2C_MPU6050_clase = class_create(THIS_MODULE, CLASS_NAME)) == NULL)
	{
		pr_alert("%s: No se pudo crear la estructura class\n", ID);
		cdev_del(dev.I2C_MPU6050_cdev);
		unregister_chrdev_region(dev.I2C_MPU6050, CANT_DISP);
		return EFAULT;
	}

	// cambiar el permiso
	dev.I2C_MPU6050_clase->dev_uevent = I2C_MPU6050_devnode;

	// Creo device
	dev.I2C_MPU6050_device = device_create(dev.I2C_MPU6050_clase, NULL, dev.I2C_MPU6050, NULL, COMPATIBLE);
	if (dev.I2C_MPU6050_device == NULL)
	{
		pr_alert("%s: No se pudo crear el Device\n", ID);
		class_destroy(dev.I2C_MPU6050_clase);
		cdev_del(dev.I2C_MPU6050_cdev);
		unregister_chrdev_region(dev.I2C_MPU6050, CANT_DISP);
		return EFAULT;
	}

	pr_alert("%s: Inicializacion del modulo I2C \n", ID);

	if ((retorno = platform_driver_register(&I2C_MPU6050_pd)) < 0)
	{
		pr_alert("%s: No se pudo registrar el platformDevice\n", ID);
		device_destroy(dev.I2C_MPU6050_clase, dev.I2C_MPU6050);
		class_destroy(dev.I2C_MPU6050_clase);
		cdev_del(dev.I2C_MPU6050_cdev);
		unregister_chrdev_region(dev.I2C_MPU6050, CANT_DISP);
		return retorno;
	}

	pr_alert("%s: I2C driver instalado\n", ID);
	return 0;
}

static void __exit I2C_MPU6050_exit(void)
{
	pr_alert("%s: Cerrando el CharDriver\n", ID);
	cdev_del(dev.I2C_MPU6050_cdev);
	unregister_chrdev_region(dev.I2C_MPU6050, CANT_DISP);
	device_destroy(dev.I2C_MPU6050_clase, dev.I2C_MPU6050);
	class_destroy(dev.I2C_MPU6050_clase);
	platform_driver_unregister(&I2C_MPU6050_pd);
	pr_alert("%s: I2C driver desinstalado\n", ID);
}

module_init(I2C_MPU6050_init);
module_exit(I2C_MPU6050_exit);

// FUNCIONES AUXILIARES

void initMPU6050(void)
{
	uint16_t aux = 0;
	pr_alert("%s: Inicializacion del MPU6050\n", ID);

	MPU6050_writebyte(WHO_AM_I, 0x00, Tx_MODO_LECTURA);
	aux = MPU6050_readbyte();
	pr_alert("%s: WHO_AM_I: %#04x\n", ID, aux);

	//  wake up device-don't need this here if using calibration function below
	MPU6050_writebyte(PWR_MGMT_1, 0x00, Tx_MODO_ESCRITURA); // Clear sleep mode bit (6), enable all sensors

	msleep(100); // Delay 100 ms for PLL to get established on x-axis gyro; should check for PLL ready interrupt

	// get stable time source
	MPU6050_writebyte(PWR_MGMT_1, 0x01, Tx_MODO_ESCRITURA); // Set clock source to be PLL with x-axis gyroscope reference, bits 2:0 = 001

	// Set sample rate = gyroscope output rate/(1 + SMPLRT_DIV)
	MPU6050_writebyte(SMPLRT_DIV, 0x04, Tx_MODO_ESCRITURA); // Use a 200 Hz sample rate

	// Set gyroscope configuration
	MPU6050_writebyte(GYRO_CONFIG, 0x00, Tx_MODO_ESCRITURA); // Set full scale range for the gyro

	// Set accelerometer configuration
	MPU6050_writebyte(ACCEL_CONFIG, 0x18, Tx_MODO_ESCRITURA); // Set full scale range for the accelerometer

	// Configure Interrupts and Bypass Enable
	// Set interrupt pin active high, push-pull, and clear on read of INT_STATUS,
	// enable I2C_BYPASS_EN so additional chips
	// can join the I2C bus and all can be controlled by the Arduino as master
	MPU6050_writebyte(INT_PIN_CFG, 0x02, Tx_MODO_ESCRITURA);

	// Enable data ready (bit 0) interrupt
	MPU6050_writebyte(INT_ENABLE, 0x01, Tx_MODO_ESCRITURA);

	pr_alert("%s: Inicializacion del MPU6050 FIN\n", ID);
}

void MPU6050_writebyte(uint8_t registro, uint8_t data, uint8_t modo)
{
	uint32_t i = 0;
	uint32_t reg_valor = 0;
	//uint32_t estado = 0;

	// Chequeo si la línea esta BUSY
	reg_valor = ioread32(i2c2_baseAddr + I2C_IRQSTATUS_RAW);
	while ((reg_valor >> 12) & 1)
	{
		msleep(100);
		pr_alert("%s: writebyte ERROR Device busy\n", ID);
		i++;

		if (i == 4)
		{
			return;
		}
	}
	pr_alert("%s: writebyte\n", ID);

	// cargo datos a transmitir
	tx_data = data;
	tx_registro = registro;
	tx_modo = modo;

	if (modo == Tx_MODO_ESCRITURA)
	{
		//Tx por escritura
		// data len = 2 byte
		iowrite32(2, i2c2_baseAddr + I2C_CNT);
	}
	if (modo == Tx_MODO_LECTURA)
	{
		//Tx por lectura
		// data len = 1 byte
		iowrite32(1, i2c2_baseAddr + I2C_CNT);
	}

	// config registro -> ENABLE & MASTER & TX
	reg_valor = ioread32(i2c2_baseAddr + I2C_CON);
	reg_valor |= 0x600;
	iowrite32(reg_valor, i2c2_baseAddr + I2C_CON);

	// habilito tx interupcion
	iowrite32(I2C_IRQSTATUS_XRDY, i2c2_baseAddr + I2C_IRQENABLE_SET);

	// Genero condición de START
	reg_valor = ioread32(i2c2_baseAddr + I2C_CON);
	reg_valor |= I2C_CON_START;
	iowrite32(reg_valor, i2c2_baseAddr + I2C_CON);

	// Pongo el proceso UNINTERRUPTABLE (por estar escribiendo registros) a esperar a que la IRQ termine de transmitir.
	wait_event(queue_in, queue_cond > 0);			//ininterumpible
/*
	if ((estado = wait_event_interruptible(queue, queue_cond > 0)) < 0)
	{
		queue_cond = 0;
		pr_alert("%s: writebyte ERROR read\n", ID);
		return;
	}
*/

	queue_cond = 0;

	// Genero condición de STOP
	reg_valor = ioread32(i2c2_baseAddr + I2C_CON);
	reg_valor &= 0xFFFFFFFE;
	reg_valor |= I2C_CON_STOP;
	iowrite32(reg_valor, i2c2_baseAddr + I2C_CON);

	pr_alert("%s: writebyte OK\n", ID);

	msleep(1);
}

uint8_t MPU6050_readbyte(void)
{
	uint32_t i = 0;
	uint32_t reg_valor = 0;
	uint32_t estado = 0;
	uint8_t nuevo_dato;

	// Chequeo si la línea esta BUSY
	reg_valor = ioread32(i2c2_baseAddr + I2C_IRQSTATUS_RAW);
	while ((reg_valor >> 12) & 1)
	{
		msleep(100);

		pr_alert("%s: readbyte ERROR Device busy\n", ID);

		i++;
		if (i >= 4)
		{
			return -1;
		}
	}

	pr_alert("%s: readbyte\n", ID);

	// data = 1 byte
	iowrite32(1, i2c2_baseAddr + I2C_CNT);

	// config registro -> ENABLE & MASTER & RX
	reg_valor = ioread32(i2c2_baseAddr + I2C_CON);
	reg_valor = 0x8400;
	iowrite32(reg_valor, i2c2_baseAddr + I2C_CON);

	// Habilito interupcion rx
	iowrite32(I2C_IRQSTATUS_RRDY, i2c2_baseAddr + I2C_IRQENABLE_SET);

	// Genero condición de START
	reg_valor = ioread32(i2c2_baseAddr + I2C_CON);
	reg_valor &= 0xFFFFFFFC;
	reg_valor |= I2C_CON_START;
	iowrite32(reg_valor, i2c2_baseAddr + I2C_CON);

	// Espero a que la recepción finalice poniendo en espera el proceso.
	if ((estado = wait_event_interruptible(queue, queue_cond > 0)) < 0)
	{
		queue_cond = 0;
		pr_alert("%s: readbyte ERROR read\n", ID);
		return estado;
	}

	queue_cond = 0;

	// Genero condición de STOP
	reg_valor = ioread32(i2c2_baseAddr + I2C_CON);
	reg_valor &= 0xFFFFFFFE;
	reg_valor |= I2C_CON_STOP;
	iowrite32(reg_valor, i2c2_baseAddr + I2C_CON);

	pr_alert("%s: readbyte OK\n", ID);
	nuevo_dato = rx_data;

	return nuevo_dato;
}