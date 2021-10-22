-- Tabella province

create table coimprov
     (cod_provincia     varchar(08) not null
     ,denominazione     varchar(40) not null
     ,cod_regione       varchar(08) not null
     ,flag_val          char(01)
     ,cod_istat         varchar(07)
     ,sigla             varchar(04) not null
     );

create unique index coimprov_00
    on coimprov
     ( cod_provincia
     );

alter table coimprov
  add constraint chk_flag_val_coimprov
check (flag_val in ('T', 'F'));