use PromesasIT;

INSERT INTO Personas (ced, nombre, ape01, ape02, relacion, fecha_nacimiento) VALUES

('1-1111-1111', 'Andrés',   'Solano',   'Vega',     'Empleado', '1985-03-12'),
('2-2222-2222', 'María',    'Jiménez',  'Rojas',    'Empleado', '1990-07-25'),
('3-3333-3333', 'Carlos',   'Mora',     'Campos',   'Empleado', '1988-11-02'),
('4-4444-4444', 'Laura',    'Chacón',   'Vindas',   'Empleado', '1995-01-18'),
('5-5555-5555', 'José',     'Araya',    'Salas',    'Empleado', '1992-06-09'),
('6-6666-6666', 'Fernanda', 'Quesada',  'Alfaro',   'Empleado', '1998-09-30'),
('7-7777-7777', 'Luis',     'Brenes',   'Núñez',    'Empleado', '1983-04-14'),
('8-8888-8888', 'Gabriela', 'Fallas',   'Vargas',   'Empleado', '1991-12-05'),
('9-9999-9999', 'Ricardo',  'Cordero',  'Zamora',   'Empleado', '1987-02-27'),
('1-0101-0101', 'Daniela',  'Montero',  'Herrera',  'Empleado', '1996-08-20'),

('2-0202-0202', 'Pablo',    'Sánchez',  'Ureña',    'Cliente',  '1980-05-15'),
('3-0303-0303', 'Sofía',    'Barrantes','Gómez',    'Cliente',  '1993-10-08'),
('4-0404-0404', 'Diego',    'Castillo', 'Pérez',    'Cliente',  '1975-03-22'),
('5-0505-0505', 'Valeria',  'Rodríguez','Solís',    'Cliente',  '1999-01-11'),
('6-0606-0606', 'Esteban',  'Vargas',   'Monge',    'Cliente',  '1989-07-03'),
('7-0707-0707', 'Camila',   'Ramírez',  'Blanco',   'Cliente',  '1994-11-29'),

('8-0808-0808', 'Manuel',   'Guzmán',   'Torres',   'Proveedor','1978-02-16'),
('9-0909-0909', 'Natalia',  'Villalobos','Cruz',    'Proveedor','1982-09-07'),
('1-1010-1010', 'Alberto',  'Segura',   'Marín',    'Proveedor','1976-06-24'),
('2-1111-2222', 'Karla',    'Delgado',  'Miranda',  'Proveedor','1984-04-19');

INSERT INTO Rh (carnet, ced, salario, fecha_ingreso, puesto) VALUES
(1, '1-1111-1111', 850000.00, '2020-01-15', 'Administrador'),
(2, '2-2222-2222', 450000.00, '2021-03-10', 'Vendedor'),
(3, '3-3333-3333', 450000.00, '2021-06-01', 'Vendedor'),
(4, '4-4444-4444', 460000.00, '2022-02-20', 'Vendedor'),
(5, '5-5555-5555', 420000.00, '2020-09-05', 'Cocinera'),
(6, '6-6666-6666', 425000.00, '2021-11-12', 'Cocinera'),
(7, '7-7777-7777', 430000.00, '2023-01-08', 'Cocinera'),
(8, '8-8888-8888', 380000.00, '2020-05-17', 'Guarda'),
(9, '9-9999-9999', 385000.00, '2022-07-22', 'Guarda'),
(10, '1-0101-0101', 370000.00, '2023-04-03', 'Miscelanea');


