\echo '1. Cargar el respaldo de la base de datos unidad2.sql.'

\c transacciones_unidad2;

\echo '2. El cliente usuario01 ha realizado la siguiente compra:'

BEGIN TRANSACTION;

    SELECT * FROM cliente 
      WHERE nombre = 'usuario01';

    SELECT * FROM producto 
      WHERE descripcion = 'producto9';

    INSERT INTO compra (cliente_id,fecha,id) VALUES (1,'2021-07-28',42);
    INSERT INTO detalle_compra (producto_id,compra_id,cantidad) VALUES (9,42,4);

    UPDATE producto SET stock = stock - 4 WHERE id = 9;

    SELECT * FROM producto 
      WHERE descripcion = 'producto9' ;

COMMIT;

\echo '3. El cliente usuario02 ha realizado la siguiente compra:'

BEGIN TRANSACTION;

    SELECT * FROM producto 
      WHERE descripcion = 'producto1' OR descripcion = 'producto2' OR descripcion = 'producto8';

    INSERT INTO compra(id, cliente_id, fecha) VALUES (43, 2,'2021-07-28');
    INSERT INTO detalle_compra(producto_id, compra_id, cantidad) VALUES (1,43,3);
    INSERT INTO detalle_compra(producto_id, compra_id, cantidad) VALUES(2,43,3);
    INSERT INTO detalle_compra(producto_id, compra_id, cantidad) VALUES(8,43,3);

    UPDATE producto SET stock = stock - 3 WHERE descripcion ='producto1';
    UPDATE producto SET stock = stock - 3 WHERE descripcion ='producto2';
    UPDATE producto SET stock = stock + 4 WHERE descripcion ='producto8';
    UPDATE producto SET stock = stock - 3 WHERE descripcion ='producto8';

COMMIT; 

\echo '4. Realizar las siguientes consultas:'

\set AUTOCOMMIT off

INSERT INTO cliente(id, nombre, email) VALUES (11, 'usuario11', 'usuario11@gmail.com');

\echo "La respuesta del INSERT fue de '0 1', lo que quiere decir que si se agrego a la tabla, pero falta realizar un COMMIT.";

ROLLBACK;

SELECT * FROM cliente;

\echo 'El usuario creado no se encuentra en la tabla. El ROLLBACK funciono.'

\set AUTOCOMMIT on