
begin;

--
-- creazione modello dati
--

-- Tabella "MOVIMENTI"
create sequence wal_transactions_cait_seq start 1;
create table wal_transactions_cait (
    tran_id         integer primary key
   ,cait_id         integer not null references iter_cait (cait_id)
   ,holder_id       integer not null
   ,tran_type_id    integer not null references wal_transaction_types (tran_type_id)
   ,pay_type_id     integer not null references wal_payment_types (pay_type_id)
   ,payment_date    date    not null
   ,creation_date   date    not null
   ,description     text
   ,reference       varchar(50)
   ,amount          decimal(11, 2) not null
   -- Codifica CBI per trasferimento bonifici
   ,currency        char(1)
   ,currency_amount decimal(11,2)
   -- Nome del file di carico che ha generato questa riga
   -- se il movimento è stato generato da un web service
   -- allora il campo contiene l'id univoco del modello H 
   ,filename        varchar(32)
   ,currency_date   date    not null
   -- ( 15.09.2008 - Nelson ) Pro migliorie dati 'STORNO' del movimento
   ,reason          text
   -- id del movimento collegato in caso di storno
   ,ref_tran_id     integer
   ,status          char(1) -- L In lavorazione A Accreditato K Annullato
   ,num_reversale   varchar(100)
   ,anno_reversale  integer
   ,cro             varchar(100)
   ,num_ordine      varchar(100)   
   ,wallet_tran_id  integer references wal_transactions(tran_id)

);

create index wal_transactions_cait_idx_1 on wal_transactions_cait(holder_id);

create sequence wal_log_payments_cait_seq start 1;
create table wal_log_payments_cait (
    log_id          integer primary key
   ,filename        varchar(32)
   ,creation_date   date
   ,body_header     varchar(24)
   ,body_header_2   varchar(24)
   ,amount          decimal(11, 2)
   ,wallet_id       varchar(18)
   ,cust_header     varchar(24)   
   ,cust_header_2   varchar(24) 
   ,cust_header_3   varchar(24) 
   ,cust_header_4   varchar(24)   
   ,fiscal_code     varchar(16)
   ,payment_date    date
   ,pos             varchar(5)
   ,payment_type    char(1)
   ,reference       varchar(50)      
   -- ( 15.09.2008 - Nelson ) Pro migliorie dati 'STORNO' del movimento
   ,reason          text
   -- id del movimento collegato in caso di storno
   ,ref_tran_id    integer
   ,wallet_tran_id  integer references wal_transactions(tran_id)
   ,flag_storno     boolean default false 
);  

create table wal_recharge_cait (
    rec_id         integer primary key
   ,cait_id         integer not null references iter_cait (cait_id)
   ,tran_type_id    integer not null references wal_transaction_types (tran_type_id)
   ,pay_type_id     integer not null references wal_payment_types (pay_type_id)
   ,payment_date    date    not null
   ,creation_date   date    not null
   ,description     text
   ,amount          decimal(11, 2) not null
   ,currency_date   date    not null
   -- ( 15.09.2008 - Nelson ) Pro migliorie dati 'STORNO' del movimento
   ,reason          text
   -- id del movimento collegato in caso di storno
   ,ref_rec_id     integer
   ,num_reversale   varchar(100)
   ,anno_reversale  integer
   ,cro             varchar(100)
   ,num_ordine      varchar(100)   
   ,wallet_tran_id  integer references wal_transactions(tran_id)
   ,flag_storno     boolean default false
);



create sequence wal_recharge_cait_seq start 1;

end;
