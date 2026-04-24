-- ========================================================================================================
-- ( 20.05.2009 - Claudio )
-- ========================================================================================================

begin;

alter table wal_holders add sisal_filename  varchar(32);
alter table wal_log_holders add sisal_filename  varchar(32);

commit;

