begin;

/* but01 30/09/2024  Aggiunto il campo email_operator nella tabella iter_operators  */

ALTER TABLE iter_operators ADD COLUMN email_operator varchar(100);

end;
