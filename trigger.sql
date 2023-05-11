create or replace function realizar_transaccion()
returns trigger as $$
begin
	if new.tipo = 'ingreso' then
		--sumar en cuenta
		update cuentas set saldo = saldo + new.monto where cuenta = new.cuenta_id;
		
	elsif new.tipo = 'retiro' then
		--verificar que haya suficiente dinero en la cuenta de origen
		if(select saldo from cuentas where cuenta = new.cuenta_id) < new.monto then
			rollback;
			raise exception 'No hay suficiente dinero en la cuenta de origen';
		end if;
		--restar en cuenta
		update cuentas set saldo = saldo - new.monto where cuenta = new.cuenta_id;
	else
		raise exception 'Tipo de movimiento no valido';
	end if;
	return new;
end;
$$ language plpgsql;
-- creacion trigger
create trigger tg_transaccion
after insert
on movimientos
for each row
execute procedure realizar_transaccion();
--probar trigger
insert into movimientos (tipo,monto,cuenta_id) values ('retiro',1000,2);
select * from cuentas order by cuenta;
select * from movimientos;