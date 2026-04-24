-- Gabriele 09/11/2016

begin;

--sim: con questo upgrade è stato aggiunto anche il parametro controlli_sottogruppi_flag

alter table wal_transactions add num_ordine      varchar(100);


end;
