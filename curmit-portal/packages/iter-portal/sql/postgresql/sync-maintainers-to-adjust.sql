-- =================================================================================================================
-- Nelson ( 12.01.2008 ) - ... ( Modifica al 19.02.2009 )
-- =================================================================================================================

begin;
   alter table iter_maintainers_to_adjust add f_one_time    boolean;
   alter table iter_maintainers_to_adjust add one_time_date date;
   alter table iter_maintainers_to_adjust add one_time_user integer references users(user_id);
commit;

-- =================================================================================================================

-- begin;
--   drop table iter_maintainers_to_adjust; 
   -- Manutentori da bonificare
--   create table iter_maintainers_to_adjust (
--	  maintainers_adj_id    integer primary key
--        , iter_code             varchar(8)  not null
--	, password              varchar(8)
--	, instance_name  	varchar(40) not null
--   );
-- commit;

-- =================================================================================================================

