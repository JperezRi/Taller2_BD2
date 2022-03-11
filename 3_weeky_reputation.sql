create table weekly_reputation (
	comprador varchar (30) not null primary key unique,
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
	
	if exists (select wr.comprador from weekly_reputation as wr where wr.comprador = username) then
		update weekly_reputation as wr
		set wr.reputacion = reputation
		where username = username;
	else 
		insert into weekly_reputation values (username, reputacion);
	commit;
end; $$




