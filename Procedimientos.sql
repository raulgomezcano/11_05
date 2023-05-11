create or replace procedure realizar_transferencia(
in tipo_ varchar, 
in cuenta_ integer,
in monto_ numeric
) as $$
begin
	if tipo_ = 'ingreso' then
		--sumar en cuenta
		update cuentas set saldo = saldo + monto_ where cuenta = cuenta_;
		
	elsif tipo_ = 'retiro' then
		--verificar que haya suficiente dinero en la cuenta de origen
		if(select saldo from cuentas where cuenta = cuenta_) < monto_ then
			rollback;
			raise exception 'No hay suficiente dinero en la cuenta de origen';
		end if;
		--restar en cuenta
		update cuentas set saldo = saldo - monto_ where cuenta = cuenta_;
	else
		raise exception 'Tipo de movimiento no valido';
	end if;
	-- inserta un nuevo registro en la tabla "movimientos"
	INSERT INTO movimientos (tipo,monto) VALUES (tipo_,monto_);
	commit;
end;
$$ language plpgsql;
call realizar_transferencia('retiro',1,500);
select * from cuentas order by cuenta;
select * from movimientos;