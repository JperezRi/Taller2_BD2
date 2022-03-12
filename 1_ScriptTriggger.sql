/**
* Creación de trigger insert,update.delete tabla producto
*/
CREATE FUNCTION before_producto() RETURNS trigger AS $before_producto$
   BEGIN

	IF (TG_OP= 'INSERT' ) THEN
	INSERT INTO producto_auditoria
	VALUES(new.id_pro,new.titulo,new.marca,new.categoria,new.descripcion,new.proveedor, 'INSERT', '/2002/02/03');
	RETURN NEW;
	ELSEIF (TG_OP= 'UPDATE' ) THEN
	INSERT INTO producto_auditoria
	VALUES(new.id_pro,new.titulo,new.marca,new.categoria,new.descripcion,new.proveedor, 'UPDATE','/2002/02/03');
	RETURN NEW;
	ELSEIF (TG_OP= 'DELETE' ) THEN
	INSERT INTO producto_auditoria
	VALUES(old.id_pro,old.titulo,old.marca,old.categoria,old.descripcion,old.proveedor, 'DELETE','/2002/02/03');
	RETURN OLD;
	END IF;
	RETURN NULL;
END;
$before_producto$ LANGUAGE plpgsql;

CREATE TRIGGER before_producto BEFORE INSERT OR UPDATE ON producto
    FOR EACH ROW EXECUTE PROCEDURE before_producto();

/**
* Creación de trigger insert,update.delete tabla variante
*/
CREATE FUNCTION before_variante() RETURNS trigger AS $before_variante$
   BEGIN

	IF (TG_OP= 'INSERT' ) THEN
	INSERT INTO variante_auditoria
	VALUES(new.numero,new.codigo,new.estado,new.stock,new.producto,new.carrocompra, 'INSERT', '/2002/02/03');
	RETURN NEW;
	ELSEIF (TG_OP= 'UPDATE' ) THEN
	INSERT INTO variante_auditoria
	VALUES(new.numero,new.codigo,new.estado,new.stock,new.producto,new.carrocompra, 'UPDATE','/2002/02/03');
	RETURN NEW;
	ELSEIF (TG_OP= 'DELETE' ) THEN
	INSERT INTO variante_auditoria
	VALUES(old.numero,old.codigo,old.estado,old.stock,old.producto,old.carrocompra, 'DELETE','/2002/02/03');
	RETURN OLD;
	END IF;
	RETURN NULL;
END;
$before_variante$ LANGUAGE plpgsql;

CREATE TRIGGER before_variante BEFORE INSERT OR UPDATE ON variante
    FOR EACH ROW EXECUTE PROCEDURE before_variante();

/**
* Eliminar triggers
*/
drop trigger before_producto_updateORinsert on producto_auditoria;  
drop trigger before_producto_delete on producto_auditoria;

/*
* Se incertan datos atablas correspondiente
*/
/**
* Informacion basica para generar un usuario
*/
insert into documento values (1,'Cedula');
insert into ciudad values ('Bogota','Lindis');
/**
* Se genera un usuario (proveedor)
*/
insert into usuario values ('Paulita','paula','Buitrago',1000272,'paub@hot.com',1,'Hola','Calle 23','Bogota');
insert into proveedor values ('Paulita',1,'Hola soy paulita');
/**
* Se inserta producto y variante
*/
insert into producto values (1,'carro2','toyota2','vehiculo2','carro lindo 2','Paulita');
insert into variante values (1,1010,'B',5,1,0);
/**
* Se genera un usuario (comprador)
*/
insert into usuario values ('Andresito','Andres','Galvis',10023949,'Galvisito@hot.com',1,'Hola','Calle','Bogota');
insert into comprador values ('Andresito','Hola soy andresito');
insert into carroCompra values (0,'Andresito','PCs','Asus','2','D','20/07/2003');


select * from variante_auditoria;
select * from carrocompra;

select * from producto_auditoria;
select * from documento;

/**
* Validación 
*/
select * from producto;
select * from producto_auditoria;
insert into producto values (2,'celular','apple','celulares','pequeño','Paulita');
select * from producto_auditoria;

select * from variante;
select * from variante_auditoria;
insert into variante values (2,1011,'B',2,2,0);
select * from variante_auditoria;
