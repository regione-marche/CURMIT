
begin;

--04/02/2016 Nicola per coimtgen.lun_num_cod_imp_est usato per regione Marche
alter table coimtgen add lun_num_cod_imp_est numeric(02) not null default 6;

end;
