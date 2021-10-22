create table coimcitt_st as
select * from coimcitt
where 1 = 0; 
CREATE SEQUENCE coimcitt_st_seq start 1 increment 1;
alter table coimcitt_st add st_progressivo integer ;
alter table coimcitt_st alter column st_progressivo set not null;
alter table coimcitt_st alter column st_progressivo  set default nextval('coimcitt_st_seq');
alter table coimcitt_st add st_utente varchar(10);
alter table coimcitt_st add st_operazione char (1) check (st_operazione in ('I','M','C'));
alter table coimcitt_st add st_data_validita  timestamptz;

