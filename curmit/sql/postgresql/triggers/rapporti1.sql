create table coimcimp_st as
select * from coimcimp
where 1 = 0; 
CREATE SEQUENCE coimcimp_st_seq start 1 increment 1;
alter table coimcimp_st add st_progressivo integer ;
alter table coimcimp_st alter column st_progressivo set not null;
alter table coimcimp_st alter column st_progressivo  set default nextval('coimcimp_st_seq');
alter table coimcimp_st add st_utente varchar(10);
alter table coimcimp_st add st_operazione char (1) check (st_operazione in ('M','C'));
alter table coimcimp_st add st_data_validita  timestamptz;

