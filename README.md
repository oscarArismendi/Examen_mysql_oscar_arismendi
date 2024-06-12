# Examen_mysql_oscar_arismendi

## ***Tech Haven***
***NOTA: Este readme esta hecho de forma que se pone el enunciado de la consulta,subconsulta o procedimiento, se proporciona el codigo en mysql y se da el resultado.***
## Consultas

1. Obtener la lista de todos los productos con sus precio

   ```mysql
   SELECT
   	pro.nombre,
   	pro.precio
   FROM
   	productos pro;
   +-------------------------+---------+
   | nombre                  | precio  |
   +-------------------------+---------+
   | iPhone 13               |  799.99 |
   | Samsung Galaxy S21      |  699.99 |
   | Sony WH-1000XM4         |  349.99 |
   | MacBook Pro             | 1299.99 |
   | Dell XPS 13             |  999.99 |
   | GoPro HERO9             |  399.99 |
   | Amazon Echo Dot         |   49.99 |
   | Kindle Paperwhite       |  129.99 |
   | Apple Watch Series 7    |  399.99 |
   | Bose QuiteComfort 35 II |  299.99 |
   | Nintendo Switch         |  299.99 |
   | Fitbit Charge 5         |  179.95 |
   +-------------------------+---------+
   12 rows in set (0,00 sec)
   
   
   ```

   

2. Encontrar todos los pedidos realizados por un usuario específico, por ejemplo, Juan Perez

```mysql
SELECT
	pe.id,
	pe.fecha,
	pe.total
FROM
	usuarios usu
INNER JOIN
	pedidos pe ON usu.id = pe.id_usuario
WHERE
	usu.nombre = "Juan Perez" AND usu.id = 1;
+----+------------+---------+
| id | fecha      | total   |
+----+------------+---------+
|  1 | 2024-02-25 | 1049.98 |
+----+------------+---------+
1 row in set (0,01 sec)

```



3. Listar los detalles de todos los pedidos, incluyendo el nombre del producto, cantidad y precio
   unitario

```mysql
SELECT
	pe.id AS PedidoId,
	pro.nombre AS Producto,
	depe.cantidad,
	depe.precio_unitario
FROM
	pedidos pe
INNER JOIN
	detallespedidos depe ON depe.id_pedido = pe.id
INNER JOIN
	productos pro ON depe.id_producto = pro.id;
+----------+-------------------------+----------+-----------------+
| PedidoId | Producto                | cantidad | precio_unitario |
+----------+-------------------------+----------+-----------------+
|        1 | iPhone 13               |        1 |          799.99 |
|        1 | Amazon Echo Dot         |        5 |           49.99 |
|        2 | MacBook Pro             |        1 |         1299.99 |
|        2 | Kindle Paperwhite       |        1 |          129.99 |
|        3 | Samsung Galaxy S21      |        1 |          699.99 |
|        3 | Apple Watch Series 7    |        1 |          399.99 |
|        4 | Dell XPS 13             |        1 |          999.99 |
|        4 | Bose QuiteComfort 35 II |        1 |          299.99 |
|        5 | Sony WH-1000XM4         |        1 |          349.99 |
|        5 | Nintendo Switch         |        1 |          299.99 |
|        6 | GoPro HERO9             |        1 |          399.99 |
+----------+-------------------------+----------+-----------------+
11 rows in set (0,00 sec)


```



4. Calcular el total gastado por cada usuario en todos sus pedidos

``` mysql
SELECT
	usu.nombre,
	SUM(pe.total) AS TotalGastado
FROM
	usuarios usu
INNER JOIN
	pedidos pe ON pe.id_usuario = usu.id
GROUP BY
	usu.id;
+----------------+--------------+
| nombre         | TotalGastado |
+----------------+--------------+
| Juan Perez     |      1049.98 |
| Maria Lopez    |      1349.98 |
| Carlos Mendoza |      1249.99 |
| Ana Gonzalez   |       449.98 |
| Luis Torres    |       699.99 |
| Laura Rivera   |       399.99 |
+----------------+--------------+
6 rows in set (0,00 sec)

```



5. Encontrar los productos más caros (precio mayor a $500)

```mysql
SELECT
	pro.nombre,
	pro.precio
FROM
	productos pro
WHERE
	pro.precio > 500;
+--------------------+---------+
| nombre             | precio  |
+--------------------+---------+
| iPhone 13          |  799.99 |
| Samsung Galaxy S21 |  699.99 |
| MacBook Pro        | 1299.99 |
| Dell XPS 13        |  999.99 |
+--------------------+---------+
4 rows in set (0,00 sec)

```



6. Listar los pedidos realizados en una fecha específica, por ejemplo, 2024-03-10

```mysql
SELECT	
	pe.id,
	pe.id_usuario,
	pe.fecha,
	pe.total
FROM
	pedidos pe
WHERE
	pe.fecha = "2024-03-10";
+----+------------+------------+---------+
| id | id_usuario | fecha      | total   |
+----+------------+------------+---------+
|  2 |          2 | 2024-03-10 | 1349.98 |
+----+------------+------------+---------+
1 row in set (0,00 sec)


```



7. Obtener el número total de pedidos realizados por cada usuario

```mysql
SELECT
	usu.nombre,
	COUNT(usu.id) AS NumeroDePedidos
FROM
	usuarios usu
INNER JOIN
	pedidos pe ON pe.id_usuario = usu.id
GROUP BY
	usu.id;
+----------------+-----------------+
| nombre         | NumeroDePedidos |
+----------------+-----------------+
| Juan Perez     |               1 |
| Maria Lopez    |               1 |
| Carlos Mendoza |               1 |
| Ana Gonzalez   |               1 |
| Luis Torres    |               1 |
| Laura Rivera   |               1 |
+----------------+-----------------+
6 rows in set (0,00 sec)

```



8. Encontrar el nombre del producto más vendido (mayor cantidad total vendida)

```mysql
SELECT
	pro.nombre,
	SUM(depe.cantidad) AS CantidadTotal
FROM
	detallespedidos depe
INNER JOIN
	productos pro ON depe.id_producto = pro.id
GROUP BY
	pro.id
ORDER BY
	CantidadTotal DESC
LIMIT 1;
+-----------------+---------------+
| nombre          | CantidadTotal |
+-----------------+---------------+
| Amazon Echo Dot |             5 |
+-----------------+---------------+
1 row in set (0,00 sec)


```



9. Listar todos los usuarios que han realizado al menos un pedido

```mysql
SELECT
	usu.nombre,
	usu.correo_electronico
FROM
	usuarios usu
INNER JOIN
	pedidos pe ON pe.id_usuario = usu.id
GROUP BY
	usu.id;
+----------------+----------------------------+
| nombre         | correo_electronico         |
+----------------+----------------------------+
| Juan Perez     | juan.perez@example.com     |
| Maria Lopez    | maria.lopez@example.com    |
| Carlos Mendoza | carlos.mendoza@example.com |
| Ana Gonzalez   | ana.gonzalez@example.com   |
| Luis Torres    | luis.torres@example.com    |
| Laura Rivera   | laura.rivera@example.com   |
+----------------+----------------------------+
6 rows in set (0,00 sec)
```



10. Obtener los detalles de un pedido específico, incluyendo los productos y cantidades, por
    ejemplo, pedido con id 1

```mysql
SELECT
	pe.id AS PedidoID,
	usu.nombre AS Usuario,
	pro.nombre ASProducto,
	depe.cantidad,
	depe.precio_unitario
FROM
	detallespedidos depe
INNER JOIN
	productos pro ON depe.id_producto = pro.id
INNER JOIN
	pedidos pe ON depe.id_pedido = pe.id
INNER JOIN
	usuarios usu ON pe.id_usuario = usu.id
WHERE
	pe.id = 1;
+----------+------------+-----------------+----------+-----------------+
| PedidoID | Usuario    | ASProducto      | cantidad | precio_unitario |
+----------+------------+-----------------+----------+-----------------+
|        1 | Juan Perez | iPhone 13       |        1 |          799.99 |
|        1 | Juan Perez | Amazon Echo Dot |        5 |           49.99 |
+----------+------------+-----------------+----------+-----------------+
2 rows in set (0,00 sec)
```



## Subconsultas

1. Encontrar el nombre del usuario que ha gastado más en total

   ```mysql
   SELECT
   	usuMain.nombre
   FROM
   	usuarios usuMain
   INNER JOIN (
       SELECT
           usu.id
       FROM
           usuarios usu
       INNER JOIN
           pedidos pe ON pe.id_usuario = usu.id
       GROUP BY
           usu.id
        ORDER BY
           SUM(pe.total) DESC
        LIMIT 1
       ) AS sub ON sub.id = usuMain.id;
   +-------------+
   | nombre      |
   +-------------+
   | Maria Lopez |
   +-------------+
   1 row in set (0,00 sec)
   
   	
   ```

   

2. Listar los productos que han sido pedidos al menos una vez

```mysql
SELECT
	pro.nombre
FROM
	productos pro
INNER JOIN (
	SELECT
    	depe.id_producto
    FROM
    	detallespedidos depe
   	GROUP BY
    	depe.id_producto
) AS sub ON sub.id_producto = pro.id;
+-------------------------+
| nombre                  |
+-------------------------+
| iPhone 13               |
| Samsung Galaxy S21      |
| Sony WH-1000XM4         |
| MacBook Pro             |
| Dell XPS 13             |
| GoPro HERO9             |
| Amazon Echo Dot         |
| Kindle Paperwhite       |
| Apple Watch Series 7    |
| Bose QuiteComfort 35 II |
| Nintendo Switch         |
+-------------------------+
11 rows in set (0,01 sec)

```



3. Obtener los detalles del pedido con el total más alto

```mysql
SELECT
	peMain.id,
	usu.id AS id_usuario,
	peMain.fecha,
	peMain.total
FROM
	pedidos peMain
INNER JOIN
	usuarios usu ON peMain.id_usuario = usu.id
INNER JOIN(
	SELECT
    	pe.id
    FROM
    	pedidos pe
    ORDER BY
    	pe.total DESC
    LIMIT 1
) AS sub ON sub.id = peMain.id;
+----+------------+------------+---------+
| id | id_usuario | fecha      | total   |
+----+------------+------------+---------+
|  2 |          2 | 2024-03-10 | 1349.98 |
+----+------------+------------+---------+
1 row in set (0,00 sec)


```



4. Listar los usuarios que han realizado más de un pedido

```mysql
SELECT
	usuMain.nombre,
	usuMain.correo_electronico
FROM
	usuarios usuMain
INNER JOIN(
    SELECT
    	usu.id,
        usu.nombre,
        COUNT(usu.id) AS NumeroDePedidos
    FROM
        usuarios usu
    INNER JOIN
        pedidos pe ON pe.id_usuario = usu.id
    GROUP BY
        usu.id
    HAVING
    	NumeroDePedidos > 1
) AS sub ON sub.id = usuMain.id;
Empty set (0,00 sec)
```



5. Encontrar el producto más caro que ha sido pedido al menos una vez

```mysql
SELECT
	pro.nombre,
	pro.precio
FROM
	productos pro
INNER JOIN(
	SELECT
    	depe.id_producto
    FROM
    	detallespedidos depe
    GROUP BY
    	depe.id_producto
) AS sub ON sub.id_producto = pro.id
ORDER BY
 pro.precio DESC
LIMIT 1;
+-------------+---------+
| nombre      | precio  |
+-------------+---------+
| MacBook Pro | 1299.99 |
+-------------+---------+
1 row in set (0,01 sec)

```

## Procedimientos Almacenados

### Crear un procedimiento almacenado para agregar un nuevo producto

**Enunciado**: Crea un procedimiento almacenado llamado **AgregarProducto** que reciba como
parámetros el nombre, descripción y precio de un nuevo producto y lo inserte en la tabla
**Productos** .

```mysql
DELIMITER $$
DROP PROCEDURE IF EXISTS AgregarProducto;
CREATE PROCEDURE AgregarProducto(
    IN nombre_in VARCHAR(100),
    IN precio_in decimal(10,2),
    IN descripcion_in text
)
BEGIN
	DECLARE mensaje VARCHAR(100);
	INSERT INTO productos(nombre,precio,descripcion) VALUE (nombre_in,precio_in,descripcion_in);
	IF ROW_COUNT() > 0 THEN
		SET mensaje = "El producto ha sido insertado en productos exitosamente";
	ELSE
		SET mensaje = "El producto no ha podido ser insertado";
	END IF;
	SELECT mensaje AS "mensaje";
END $$
DELIMITER ;

CALL AgregarProducto("AlienWare R7",2999.99,"Computador portatil con procesador I7");
+---------------------------------------------------------+
| mensaje                                                 |
+---------------------------------------------------------+
| El producto ha sido insertado en productos exitosamente |
+---------------------------------------------------------+
1 row in set (0,00 sec)

Query OK, 0 rows affected (0,00 sec)
```

### Crear un procedimiento almacenado para obtener los detalles de un pedido

**Enunciado**: Crea un procedimiento almacenado llamado **ObtenerDetallesPedido** que reciba
como parámetro el ID del pedido y devuelva los detalles del pedido, incluyendo el nombre del
producto, cantidad y precio unitario.

```mysql
DELIMITER $$
DROP PROCEDURE IF EXISTS ObtenerDetallesPedido;
CREATE PROCEDURE ObtenerDetallesPedido(
	IN id_in INT	
)
BEGIN
	SELECT
		pro.nombre AS producto,
		depe.cantidad,
		depe.precio_unitario
	FROM
		detallespedidos depe
	INNER JOIN
		productos pro ON pro.id = depe.id_producto
	WHERE depe.id_pedido = id_in;
END $$
DELIMITER ;

CALL ObtenerDetallesPedido(1);
+-----------------+----------+-----------------+
| producto        | cantidad | precio_unitario |
+-----------------+----------+-----------------+
| iPhone 13       |        1 |          799.99 |
| Amazon Echo Dot |        5 |           49.99 |
+-----------------+----------+-----------------+
2 rows in set (0,00 sec)

Query OK, 0 rows affected (0,00 sec)


```

### Crear un procedimiento almacenado para actualizar el precio de un producto

**Enunciado**: Crea un procedimiento almacenado llamado **ActualizarPrecioProducto** que reciba
como parámetros el ID del producto y el nuevo precio, y actualice el precio del producto en la
tabla **Productos** .

```mysql
DELIMITER $$
DROP PROCEDURE IF EXISTS ActualizarPrecioProducto;
CREATE PROCEDURE ActualizarPrecioProducto(
    IN id_in INT,
    IN precio_in decimal(10,2)
)
BEGIN
	DECLARE mensaje VARCHAR(100);
	UPDATE productos SET precio = precio_in WHERE id=id_in;
	IF ROW_COUNT() > 0 THEN
		SET mensaje = CONCAT("Se ha actualizado el precio del producto con la id ",id_in," exitosamente");
	ELSE
		SET mensaje = CONCAT("No se ha podido actualizar el producto con la id ",id_in);
	END IF;
	SELECT mensaje AS "mensaje";
END $$
DELIMITER ;

CALL ActualizarPrecioProducto(1,199.99);
+-------------------------------------------------------------------+
| mensaje                                                           |
+-------------------------------------------------------------------+
| Se ha actualizado el precio del producto con la id 1 exitosamente |
+-------------------------------------------------------------------+
1 row in set (0,00 sec)

Query OK, 0 rows affected (0,00 sec)
```

### Crear un procedimiento almacenado para eliminar un producto

**Enunciado**: Crea un procedimiento almacenado llamado **EliminarProducto** que reciba como
parámetro el ID del producto y lo elimine de la tabla **Productos** .

```mysql
DELIMITER $$
DROP PROCEDURE IF EXISTS EliminarProducto;
CREATE PROCEDURE EliminarProducto(
    IN id_in INT
)
BEGIN
	DECLARE mensaje VARCHAR(100);
	DELETE FROM productos pro WHERE pro.id = id_in;
	IF ROW_COUNT() > 0 THEN
		SET mensaje = CONCAT("Se ha eliminado el producto con la id ",id_in);
	ELSE
		SET mensaje = CONCAT("No se ha encontrado un producto con la id ",id_in);
	END IF;
	SELECT mensaje AS "mensaje";
END $$
DELIMITER ;

CALL EliminarProducto(1);
+------------------------------------------+
| mensaje                                  |
+------------------------------------------+
| Se ha eliminado el producto con la id 1  |
+------------------------------------------+
1 row in set (0,01 sec)

Query OK, 0 rows affected (0,01 sec)
```

### Crear un procedimiento almacenado para obtener el total gastado por un usuario

**Enunciado**: Crea un procedimiento almacenado llamado **TotalGastadoPorUsuario** que reciba
como parámetro el ID del usuario y devuelva el total gastado por ese usuario en todos sus
pedidos.

```mysql
DELIMITER $$
DROP PROCEDURE IF EXISTS TotalGastadoPorUsuario;
CREATE PROCEDURE TotalGastadoPorUsuario(
    IN id_in INT
)
BEGIN
	SELECT
        SUM(pe.total) AS TotalGastado
    FROM
        usuarios usu
    INNER JOIN
        pedidos pe ON usu.id = pe.id_usuario
    WHERE
        usu.id = id_in
    GROUP BY
    	usu.id;
END $$
DELIMITER ;

CALL TotalGastadoPorUsuario(2);
+--------------+
| TotalGastado |
+--------------+
|      1349.98 |
+--------------+
1 row in set (0,00 sec)

Query OK, 0 rows affected (0,00 sec)
```

