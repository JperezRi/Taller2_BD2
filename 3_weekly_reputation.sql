create table weekly_reputation (
	proveedor varchar (30) not null primary key unique,
	week_reputation varchar(11),
	foreign key(comprador) references proveedor (username)
);

create or replace procedure calc_reputacion (
username varchar(30),
sum_calificaciones int,
reputacion varchar(11)
)
language plpgsql
as $$
begin	
	if(sum_calificaciones <= 5)then
		reputacion = 'Baja';
	else if (sum_calificaciones <= 10)then
		reputacion = 'Baja-Media';
	else if (sum_calificaciones <= 15)then
		reputacion = 'Media';
	else if (sum_calificaciones <= 20)then
		reputacion = 'Media-Alta';
	else if (sum_calificaciones > 20)then
		reputacion = 'Alta';
	end if;
	end if;
	end if;
	end if;
	end if;
	if exists (select wr.proveedor from weekly_reputation as wr where wr.proveedor = username) then
		update weekly_reputation as wr
		set wr.reputacion = reputation
		where wr.comprador = username;
	else 
		insert into weekly_reputation values (username, reputacion);	
	end if;
	commit;
end; $$

call calc_reputacion('Paulita',5,'BAJA');
select * from weekly_reputation;

