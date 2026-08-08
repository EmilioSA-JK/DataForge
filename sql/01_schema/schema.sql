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
    
REATE TABLE Produccion(
	n_produccion int AUTO_INCREMENT PRIMARY KEY,
    ced VARCHAR(30),
    cod int,
    saldo int,
    
    FOREIGN KEY (ced) REFERENCES Personas(ced)
    );
    
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
		cantidad int,
        
		FOREIGN KEY (cod) REFERENCES Inventario(cod),
		FOREIGN KEY (saldo) REFERENCES Inventario(saldo)
        
		
        );
    
