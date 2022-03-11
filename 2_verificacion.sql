create function verificar() returns trigger AS $before_insert_orden$
	begin 
		if exists (select cp.id_carro from carrocompra as cp where cp.id_carro = id_compra) then
			raise exception 'paila';
			rollback;
		else
			raise 'inserción satisfactoria';
		end if;
	end
$before_insert_orden$ language plpgsql;


create trigger before_insert_orden before update on compra
	for each row execute procedure verificar();
