# Se crea la base de datos y se pone en uso

CREATE DATABASE PromesasIT;
use PromesasIT;

CREATE TABLE Personas(
ced varchar(30) PRIMARY KEY,
nombre varchar(40),
ape01 varchar(40),
ape02 varchar(40),
relacion varchar(60),
fecha_nacimiento date
	);
    
    

# Se empieza a crear el schema inicial 

CREATE TABLE Rh(
	carnet INT PRIMARY KEY AUTO_INCREMENT,
    ced VARCHAR(30),
    salario decimal(10,2),
    fecha_ingreso date,
    puesto varchar(60),
	
	FOREIGN KEY (ced) REFERENCES Personas(ced)
	);
    
    
CREATE TABLE Compras(
	n_factura int PRIMARY KEY AUTO_INCREMENT,
    proveedor varchar(30),
    fecha date,
    sub_total decimal(10,2),
    IVA decimal(10,2),
    total decimal(10,2),
    
    FOREIGN KEY(proveedor) REFERENCES Personas(ced)
    
    );
    
CREATE TABLE Inventario(
	cod int PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(60),
    costo decimal(10,2),
    precio decimal(10,2),
    carnet varchar(30),
    saldo int,
    
    FOREIGN KEY(carnet) REFERENCES Personas(ced)
    );
    
CREATE TABLE detalle_compras(
	consecutivo INT PRIMARY KEY AUTO_INCREMENT,
    n_factura INT,
    linea INT,
    cod INT,
    cantidad INT,
    
    FOREIGN KEY (n_factura) REFERENCES Compras(n_factura),
    FOREIGN KEY (cod) REFERENCES Inventario(cod)
    
	);
    
CREATE TABLE Avance(
	carnet varchar(30) PRIMARY KEY,
    saldo INT,
    
    FOREIGN KEY (carnet) REFERENCES Personas(ced)
    );
    
CREATE TABLE PIT_Logs(
	cod_log INT AUTO_INCREMENT PRIMARY KEY,
    tabla VARCHAR(50) NOT NULL,
    tipo_operacion ENUM('INSERT','UPDATE','DELETE') NOT NULL,
    fecha_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    detalle VARCHAR(255)
    );
    
CREATE TABLE Oferta(
	cod INT PRIMARY KEY,
    cantidad INT NOT NULL DEFAULT 0,
    ultima_fecha_compra DATE,
    FOREIGN KEY (cod) REFERENCES Inventario(cod)
    );
    
CREATE TABLE Produccion(
	n_produccion int AUTO_INCREMENT PRIMARY KEY,
    ced VARCHAR(30),
    cod int,
    saldo int,
    
    FOREIGN KEY (ced) REFERENCES Personas(ced)
    );





#Se agregan otras columnas a la tabla Avance que funcionaran como fk a Personas e Inventario   
ALTER TABLE Avance ADD COLUMN (ced VARCHAR(30)), ADD CONSTRAINT FOREIGN KEY (ced) REFERENCES Personas(ced);
ALTER TABLE Avance ADD COLUMN (cod int), ADD CONSTRAINT FOREIGN KEY (cod) REFERENCES Inventario(cod);

CREATE TABLE Log_inventario(
	n_log int AUTO_INCREMENT PRIMARY KEY,
    cod int,
    saldo int,
    ced VARCHAR(30),
    
    FOREIGN KEY (cod) REFERENCES Inventario(cod)
	);
    
CREATE TABLE Ventas (
	n_factura_compra int AUTO_INCREMENT PRIMARY KEY,
    cod int,
    ced VARCHAR(30),
    fecha date,
    sub_total DECIMAL(10,2),
    IVA  DECIMAL(10,2),
    total DECIMAL(10,2),
    
    
    
    FOREIGN KEY (cod) REFERENCES Inventario(cod),
    FOREIGN KEY (ced) REFERENCES Personas(ced)
		);


        
#Se define la columna linea como UNIQUE como corrección a un error de tipo de dato.        
ALTER TABLE detalle_compras CHANGE COLUMN linea linea int UNIQUE;
       
CREATE TABLE Detalle_ventas(
	consecutivo int AUTO_INCREMENT PRIMARY KEY,
    n_factura_compra int,
    linea int,
    cod int,
    cantidad int,
    
    FOREIGN KEY (n_factura_compra) REFERENCES Ventas(n_factura_compra),
    FOREIGN KEY (linea) REFERENCES detalle_compras(linea)
	
	);
    
CREATE TABLE Log_ventas_comisiones(
		n_comisiones int PRIMARY KEY,
		cod int,
		saldo int,
        
		FOREIGN KEY (cod) REFERENCES Inventario(cod),
		FOREIGN KEY (saldo) REFERENCES Inventario(saldo)
        
    );



#Se hace una corrección ya que compras.proveedor tenía que ser una Foreign Key y estaba definida solo como VARCHAR(30)

ALTER TABLE Compras CHANGE COLUMN proveedor proveedor VARCHAR(30), ADD CONSTRAINT fk_proveedor FOREIGN KEY (proveedor) REFERENCES Personas(ced);


#Se agrega Carnet a Ventas como una decision de diseño, esto funcionara pasa saber el tipo de puesto de quien hizo la venta y sus datos
ALTER TABLE Ventas ADD COLUMN carnet INT NOT NULL, ADD CONSTRAINT FOREIGN KEY (carnet) REFERENCES Rh(carnet);

#Vamos a Insertar una nueva tabla, la cual va a funcionar para calcular los tiempos de entrega de los cocineros, esto será así para calcular sus comisiones
CREATE TABLE Entregas (
	n_entrega INT AUTO_INCREMENT PRIMARY KEY,
    n_factura_compra INT NOT NULL,
    carnet INT NOT NULL,
    tiempo_entrega_min DECIMAL(10,2) NOT NULL,
    fecha_entrega DATE NOT NULL,
    
    FOREIGN KEY (n_factura_compra) REFERENCES Ventas(n_factura_compra),
    FOREIGN KEY (carnet) REFERENCES Rh(carnet)
    );



# Se modifica la tabla para poder generar comisiones funcionales según la decisión de como pagar las comisiones(para mas información, ir al markdown llamado "decisiones.md" en la parte de docs
ALTER TABLE Log_ventas_comisiones 
	ADD COLUMN carnet INT NOT NULL AFTER n_comisiones,
    ADD COLUMN tipo_comision ENUM('Venta', 'Entrega') NOT NULL AFTER carnet,
    MODIFY COLUMN cod INT NULL,
    ADD COLUMN sub_total DECIMAL(10,2) NOT NULL,
    ADD COLUMN IVA DECIMAL(10,2) NOT NULL,
    ADD COLUMN total DECIMAL(10,2) NOT NULL,
    ADD COLUMN fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ADD CONSTRAINT fk_carnet_lvc FOREIGN KEY (carnet) REFERENCES Rh(carnet);

#Se agrega la columna específica para saber el monto de la comision
ALTER TABLE Log_ventas_comisiones ADD COLUMN monto_comision DECIMAL(10,2) NOT NULL;

ALTER TABLE Log_ventas_comisiones
	MODIFY COLUMN saldo INT NULL;

