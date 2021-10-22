-- Tabella regioni

create table coimregi
     (cod_regione       varchar(08) not null
     ,denominazione     varchar(40) not null
     ,flag_val          char(01)
     ,cod_istat         varchar(07)
     );

create unique index coimregi_00
    on coimregi
     ( cod_regione
     );

alter table coimregi 
  add constraint chk_flag_val_coimregi
check (flag_val in ('T', 'F'));