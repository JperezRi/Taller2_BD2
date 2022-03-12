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

CREATE TRIGGER before_variante BEFORE INSERT OR UPDATE ON producto
    FOR EACH ROW EXECUTE PROCEDURE before_variante();
    
    
insert into producto values (1,'carro2','toyota2','vehiculo2','carro lindo 2','Paulita');

update producto 
set titulo='juanito999'
where id_pro=0;
select * from producto_auditoria;


insert into variante values (1,1010,'B',5,'vehiculo',0);

update variante 
set codigo= 1011
where numero=1;
select * from variante_auditoria;

/**
* Eliminar triggers
*/
drop trigger before_producto_updateORinsert on producto_auditoria;  
drop trigger before_producto_delete on producto_auditoria;
