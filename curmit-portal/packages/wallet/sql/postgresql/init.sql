-- preparazione all'importazione iniziale da curit
begin;

delete from wal_log_payments;
delete from wal_transactions;
delete from wal_log_holders;
delete from wal_holders;

end;

-- ricordarsi di annullare id_wallet di iter_maintainers
