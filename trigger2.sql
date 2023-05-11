create or replace function realizar_transaccion()
returns trigger as $$
begin
	if new.saldo<old.saldo then
		insert into movimientos (tipo,monto,cuenta_id) values ('retiro',old.saldo - new.saldo,new.cuenta);
		return new;
	elsif new.saldo>old.saldo then
		insert into movimientos (tipo,monto,cuenta_id) values ('ingreso',old.saldo + new.saldo,new.cuenta);
		return new;
	else
		return old;
	end if;
end;
$$ language plpgsql;
-- creacion trigger
create trigger tg_transaccion
before update
on cuentas
for each row
execute procedure realizar_transaccion();
--probar trigger
update cuentas set saldo = 1000 where cuenta = 2;
select * from cuentas order by cuenta;
select * from movimientos;