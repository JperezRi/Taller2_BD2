/**
* Creación de trigger insert or update
*/
CREATE FUNCTION before_producto_updateORinsert() RETURNS trigger AS $before_producto_updateORinsert$
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
$before_producto_updateORinsert$ LANGUAGE plpgsql;

CREATE TRIGGER before_producto_updateORinsert BEFORE INSERT OR UPDATE ON producto
    FOR EACH ROW EXECUTE PROCEDURE before_producto_updateORinsert();


/**
* Eliminar triggers
*/
drop trigger before_producto_updateORinsert on producto_auditoria;  
drop trigger before_producto_delete on producto_auditoria;
