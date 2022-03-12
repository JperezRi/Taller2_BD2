create table Producto_auditoria(
    id_pro int not null ,
    titulo varchar(20),
    marca varchar(10),
    fotos bytea,
    categoria varchar(10),
    descripcion varchar(50),
    proveedor varchar(30),
    event_type  varchar(30),
    event_datetime date,
    foreign key (proveedor)
    references proveedor(username),
    primary key (id_pro)
);


create table Variante_auditoria(
    numero int not null primary key unique,
    expiracion int not null,
    codigo int not null,
    estado varchar(1),
    stock int not null,
    producto int not null,
    carroCompra int not null,
    event_type  varchar(30),
    event_datetime date,
    foreign key (producto)
    references producto(id_pro),
    foreign key (carroCompra)
	references carroCompra(id_carro)
);
