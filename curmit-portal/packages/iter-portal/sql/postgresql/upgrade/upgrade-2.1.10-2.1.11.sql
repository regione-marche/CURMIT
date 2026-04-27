
begin;

--campo aggiunto per le fatture con split payment
alter table coimfatt add column flag_split_payment varchar(1);

end;
