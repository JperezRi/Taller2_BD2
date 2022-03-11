/**
* Creación de trigger insert or update
*/
CREATE FUNCTION before_producto_updateORinsert() RETURNS trigger AS $before_producto_updateORinsert$
   BEGIN
     IF NEW.id_pro IS NULL THEN
            RAISE EXCEPTION 'cannot be null';
	 END IF;
     IF NEW.titulo IS NULL THEN
         RAISE EXCEPTION '% cannot be null', NEW.id_pro;
     END IF;
    END;
$before_producto_updateORinsert$ LANGUAGE plpgsql;

CREATE TRIGGER before_producto_updateORinsert BEFORE INSERT OR UPDATE ON producto_auditoria
    FOR EACH ROW EXECUTE PROCEDURE before_producto_updateORinsert();

/**
* Creación de trigger delete
*/
CREATE FUNCTION before_producto_delete() RETURNS trigger AS $before_producto_delete$
   BEGIN
     DELETE FROM producto_auditoria WHERE id_pro = null;
    END;
$before_producto_delete$ LANGUAGE plpgsql;
CREATE TRIGGER before_producto_delete BEFORE DELETE 
    ON producto_auditoria FOR EACH ROW 
    EXECUTE PROCEDURE before_producto_delete();

/**
* Eliminar triggers
*/
drop trigger before_producto_updateORinsert on producto_auditoria;  
drop trigger before_producto_delete on producto_auditoria;