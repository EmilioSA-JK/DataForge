
-- Todos estos datos no son reales, son solo prueba de conocimiento de estos comandos.

-- Se crea el usuario Dorian para que acceda a nivel local

CREATE USER 'Dorian'@'localhost' IDENTIFIED BY 'main_admin';

-- Se crea el usuario Milo, que podra acceder desde cualquier host

CREATE USER 'Milo'@'%' IDENTIFIED BY 'Global_admin';

-- Lista los usuarios de la instancia

SELECT User, Host FROM mysql.user;

-- Cambia la contraseña de un usuario

SET PASSWORD FOR 'Dorian@'@'localhost' = PASSWORD('CTPhpjx');

-- Hace que la contraseña de un usuario expire;

DROP USER 'Milo'@'%';




-- Se otorgan privilegios de escritura y lectura a el usuario Dorian en la tabla personas.

GRANT SELECT, INSERT ON PromesasIT.Personas TO 'Dorian'@'localhost';

-- Muestra los privilegios del usuario

SHOW GRANTS FOR 'Dorian'@'localhost';




-- Granularidad de privilegios

-- 1. Privilegios globales

GRANT CREATE USER ON *.* TO 'Dorian'@'localhost';

-- 2. Privilegios a nivel base de datos

GRANT ALL PRIVILEGES ON PromesasIT.* TO 'Dorian'@'localhost';

-- 3. Privilegios a nivel tabla

GRANT SELECT, INSERT ON PromesasIT.Rh TO 'Dorian'@'localhost';

-- 4. Privilegios a nivel columna

GRANT SELECT(ced,nombre) ON PromesasIT.Personas TO 'Dorian'@'localhost';



-- Revocacion de Privilegios

REVOKE ALL PRIVILEGES ON PromesasIT.Rh FROM 'Dorian'@'localhost';










