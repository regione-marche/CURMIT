-- Simone 10/03/2017

begin;

--Aggiunti campi mancanti per rct legna (copiati dalla cimp)
alter table coimdimp add libretto_manutenz          varchar(2);
alter table coimdimp add doc_prev_incendi           char(1);
alter table coimdimp add dich_152_presente          char(1);
alter table coimdimp add doc_ispesl                 char(1);

alter table coimdimp_stn add libretto_manutenz      varchar(2);
alter table coimdimp_stn add doc_prev_incendi       char(1);
alter table coimdimp_stn add dich_152_presente      char(1);
alter table coimdimp_stn add doc_ispesl             char(1);


end;
