create table coimgend_st as
select * from coimgend
where 1 = 0; 
CREATE SEQUENCE coimgend_st_seq start 1 increment 1;
alter table coimgend_st add st_progressivo integer ;
alter table coimgend_st alter column st_progressivo set not null;
alter table coimgend_st alter column st_progressivo  set default nextval('coimgend_st_seq');
alter table coimgend_st add st_utente varchar(10);
alter table coimgend_st add st_operazione char (1) check (st_operazione in ('I','M','C'));
alter table coimgend_st add st_data_validita  timestamptz;

