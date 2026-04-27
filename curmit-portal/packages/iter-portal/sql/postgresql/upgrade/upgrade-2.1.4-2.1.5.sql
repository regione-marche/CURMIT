-- Simone 12/10/2016

begin;

--con questo upgrade viene creato il parametro email_from 

alter table wal_transactions add status          char(1); -- L In lavorazione A Accreditato K Annullato
alter table wal_transactions add num_reversale   varchar(100);
alter table wal_transactions add anno_reversale  integer;
alter table wal_transactions add cro             varchar(100);

update wal_transactions set status='A' where status is null;

end;
