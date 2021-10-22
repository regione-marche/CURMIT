--
-- creazione modello dati
--

-- tabella Enti
create table wal_bodies (
    body_id         integer primary key
   ,body_name       varchar(200) not null
   -- altri dati da definire in seguito
);

-- tabella Provenienze
create table wal_sources (
    source_id       integer primary key
   ,source_name     varchar(50) not null
   ,prefix          varchar(4)
);

--insert into wal_sources (source_id, source_name) values (1, 'CURIT');

-- tabella Titolari
create table wal_holders (
    -- uguale a maintainer_id
    holder_id       integer primary key
   ,wallet_id       varchar(18) not null
   ,source_id       integer not null references wal_sources (source_id)
    -- nome del file di carico Lottomatica che ha generato questa riga
   ,filename        varchar(32)
    -- nome del file di carico Sisal che ha generato questa riga
   ,sisal_filename  varchar(32)
   ,name            varchar(200)
   ,fiscal_code     varchar(16)
   ,iva_code        varchar(11)
   ,city            varchar(40)
   ,cestec_user_name  varchar(75)
   ,iban              varchar(27)
   ,sisal_filename    varchar(32)
);

create unique index wal_holders_wallet_id_un on wal_holders(wallet_id);

-- tabella Tipi movimento
create table wal_transaction_types (
    tran_type_id    integer primary key
   ,tran_type_name  varchar(50) not null
   ,sign            char(1) not null check (sign in ('+', '-'))
);

-- tabella Tipi pagamento
create table wal_payment_types (
    pay_type_id     integer primary key
   ,pay_type_name   varchar(50) not null
);

-- Tabella "MOVIMENTI"
create sequence wal_transactions_seq start 1;
create table wal_transactions (
    tran_id         integer primary key
   ,holder_id       integer not null references wal_holders (holder_id)
   ,body_id         integer          references wal_bodies (body_id)
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
);

create index wal_transactions_idx_1 on wal_transactions(holder_id);

-- tabella Log di carico titolari a Lottomatica
create sequence wal_log_holders_seq start 1;
create table wal_log_holders (
    log_id          integer primary key
   ,filename        varchar(32)
   ,creation_date   date
   ,body_header     varchar(24)
   ,body_header_2   varchar(24)
   ,wallet_id       varchar(18)
   ,action          char(1)  
   ,cust_header     varchar(24)   
   ,cust_header_2   varchar(24) 
   ,cust_header_3   varchar(24) 
   ,cust_header_4   varchar(24)   
   ,fiscal_code     varchar(16)
   ,sisal_filename  varchar(32)
);  

-- tabella Log dei pagamenti ricevuti da Lottomatica
-- o da web service
create sequence wal_log_payments_seq start 1;
create table wal_log_payments (
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
);  

-- tabella Log di carico bonifici
create sequence wal_transfers_seq start 1;
create table wal_transfers (
    transfer_id     integer primary key
   ,filename        varchar(32)
   ,reference       varchar(50)      
   ,rec62_orig      text
   ,rec63_1_orig    text
   ,rec63_al_orig   text
   ,rec62_elab      text
   ,rec63_1_elab    text
   ,rec63_al_elab   text
   ,creation_date   date
   ,currency_date   date
   ,amount          decimal(11, 2)
   ,wallet_id       varchar(18)
   ,name            varchar(50)
   ,iban_code       varchar(27)
   ,cc_name         varchar(100)
   -- L=loaded, C=closed, P=pending
   ,status          char(1)  
   ,notes           text
   ,source_id       integer references wal_sources (source_id)
);  

