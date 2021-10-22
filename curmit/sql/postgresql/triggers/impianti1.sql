create table coimaimp_st as
select * from coimaimp
where 1 = 0; 
CREATE SEQUENCE coimaimp_st_seq start 1 increment 1;
alter table coimaimp_st add st_progressivo integer ;
alter table coimaimp_st alter column st_progressivo set not null;
alter table coimaimp_st alter column st_progressivo  set default nextval('coimaimp_st_seq');
alter table coimaimp_st add st_utente varchar(10);
alter table coimaimp_st add st_operazione char (1) check (st_operazione in ('I','M','C'));
alter table coimaimp_st add st_data_validita  timestamptz;

