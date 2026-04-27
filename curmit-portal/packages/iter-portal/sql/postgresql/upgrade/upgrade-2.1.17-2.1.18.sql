begin;

--but01. 09/02/2024 upgrade per aggiungere user_id  dei manutentori.

alter table wal_transactions add column approve_user_id integer;

end;

