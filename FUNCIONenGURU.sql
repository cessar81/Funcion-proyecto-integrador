create database Guru;
use Guru;

create table if not exists usuario(
identificacion int not null auto_increment, 
t_identificacion varchar(30),
nombres varchar(50),
apellidos varchar(50),
telefonos int(30),
direcciones varchar(100),
correo varchar(100),
clave varchar(50),
nombre_usuario varchar(50),
primary key(identificacion)
);

create table if not exists compra(
id_comp int not null auto_increment,
estado_compra varchar(15),
descuento int,
direccion varchar(100),
fecha date,
identificacion int,
primary key(id_comp),
foreign key	(identificacion) references usuario(identificacion)
) ;
create table detalle_compra(
id_detallecom int not null auto_increment,
cantidad int,
variablesproducto varchar(50),
id_comp int not null,
id_prod int not null,
primary key(id_detallecom),
foreign key	(id_comp) references compra(id_comp),
foreign key (id_prod) references producto(id_prod)
);
create table producto(
id_prod int not null auto_increment,
nombre varchar(50),
descripcion varchar(1000),
comentarios varchar(1000),
estado_publicacion varchar(15),
categoria varchar(30),
puntuacion int,
precio int,
stock int,
idcategorias int,
primary key(id_prod),
foreign key (idcategorias) references categoria(idcategorias)
);
create table categoria(
idcategorias int not null auto_increment,
nombre_categoria varchar(50),
primary key(IDcategorias));

insert into usuario values (1029129,"Cedula","Jose","Alzate","312854","calle34","Josefo@hotmail.com","******","Josefo*-*"),
(1192897,"Cedula","Cesar","Martinez","322894","calle84","cesar81@gmail.com","******","cesar81"),
(1298721,"Tarjeta de identidad","Sofia","Castro","321611","avendia23","lasofi@yahho.com","******","lasofi23");

insert into compra values (1,"Completado",80,"calle34","2023-05-17",1029129),
(2,'En camino',10,'calle84','2023-04-25',1192897),
(3,'Reembolsado',0,'avendia23','2022-10-24',1298721);

insert into categoria values (1,'Joyeria'),
(2,'Tradicion Colombiana'),
 (3,'Textil');
 
insert into producto values (1,"Cadena",'el tiempo de transporte es de aproximadamente dos semanas. si usted está en necesidad urgente de recibir bienes, por favor póngase en contacto con el servicio de atención al cliente primero.','uena compra pero el producto . No  es  material plata ..plata  ..es cobre','Disponible','Joyeria',1,15.000,33,1),
(2,'Ruana','Nuestra Ruana es excelente elección para un Regalo ò uso propio en días de clima frio ò cálido , un color Azul Oscuro con líneas verticales Blancas y Marrón hacen Super combinación que perdura en el tiempo , las telas utilizadas en su proceso de fabricación son probadas para evitar que pierdan su tamaño original, es una prenda de excelente Calidad fabricada por manos Colombianas. Algo especial de la prenda es su cuello en V acanalado reforzado, Date el gusto de llevar una prenda de PRODUCCIÓN LIMITADA.','Muy bueno. Me gusto el material y el diseño con cremallera.','Exclusivo','Prendas',3,150.000,5,2),
(3,'Mochila Wayuu','Desde el 2013 trabajamos con las comunidades Wayuu para mejorar su calidad de vida. Por tal motivo ayudamos a estas comunidades a comercializar sus productos. Usted puede encontrarnos en internet y descubrir como está ayudando con su compra.','Hola esta mochila está disponible y seguro llega el martes si hago la compra hoy x q viajo el jueves gracias','Agotado','Cultural',2,129.000,0,3);

insert into detalle_compra values (1,2,'Pequeña',1,1),
 (2,1,'Azul',2,2),
(3,1,'Tradicional',3,3);


SELECT aplicar_descuento(1, 10); -- Esto aplicará un 10% de descuento a la compra con ID 1
use guru;

CREATE FUNCTION aplicar_descuento(id_comp INT, descuento DECIMAL(5,2)) RETURNS DECIMAL(10,2)
BEGIN
    DECLARE total DECIMAL(10,2);
    DECLARE descuento_aplicado DECIMAL(10,2);
    
    -- Obtener el total de la compra
    SELECT SUM(p.precio * dc.cantidad)
    INTO total
    FROM compra c
    INNER JOIN detalle_compra dc ON c.id_comp = dc.id_comp
    INNER JOIN producto p ON dc.id_prod = p.id_prod
    WHERE c.id_comp = id_comp;
    
    -- Calcular el descuento
    SET descuento_aplicado = total * (descuento / 100);
    
    -- Aplicar el descuento al total
    SET total = total - descuento_aplicado;
    
    RETURN total;
END;

select * from compra;