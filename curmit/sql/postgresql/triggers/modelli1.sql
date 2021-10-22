create table coimdimp_st as
select * from coimdimp
where 1 = 0; 
CREATE SEQUENCE coimdimp_st_seq start 1 increment 1;
alter table coimdimp_st add st_progressivo integer ;
alter table coimdimp_st alter column st_progressivo set not null;
alter table coimdimp_st alter column st_progressivo  set default nextval('coimdimp_st_seq');
alter table coimdimp_st add st_utente varchar(10);
alter table coimdimp_st add st_operazione char (1) check (st_operazione in ('I','M','C'));
alter table coimdimp_st add st_data_validita  timestamptz;

