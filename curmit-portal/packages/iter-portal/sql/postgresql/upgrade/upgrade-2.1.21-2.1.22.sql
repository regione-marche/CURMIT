begin;

alter table iter_maintainers add column data_accettazione_trattamento_dati_resp timestamp; 

alter table iter_maintainers add column email_trattamento_dati_resp varchar(256);

end;
