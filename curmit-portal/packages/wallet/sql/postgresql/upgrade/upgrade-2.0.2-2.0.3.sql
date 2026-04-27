
begin;

--l'upgrade aggiunge il parametro sw_multi_portafoglio  

ALTER TABLE wal_holders DROP CONSTRAINT wal_holders_pkey CASCADE;
alter table wal_holders add instance_name varchar(40);
create unique index wal_holders_idx_01 on wal_holders (holder_id, instance_name);

DROP INDEX wal_transactions_idx_1;
alter table wal_transactions add instance_name varchar(40);
create index wal_transactions_idx_01 on wal_transactions (holder_id, instance_name);
 
alter table wal_log_payments add column instance_name varchar(40) ;

end;
