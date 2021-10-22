create table coiminco_st as
select * from coiminco
where 1 = 0; 
CREATE SEQUENCE coiminco_st_seq start 1 increment 1;
alter table coiminco_st add st_progressivo integer ;
alter table coiminco_st alter column st_progressivo set not null;
alter table coiminco_st alter column st_progressivo  set default nextval('coiminco_st_seq');
alter table coiminco_st add st_utente varchar(10);
alter table coiminco_st add st_operazione char (1) check (st_operazione in ('I','M','C'));
alter table coiminco_st add st_data_validita  timestamptz;

