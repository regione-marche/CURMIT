-- Tabella Comuni

create table coimcomu
     (cod_comune       varchar(08) not null
     ,cod_provincia    varchar(08) not null
     ,denominazione    varchar(40) not null
     ,flag_val         char(01)
     ,cap              varchar(05)
     ,id_belfiore      varchar(04)
     ,cod_istat        varchar(07)
     ,popolaz_citt     numeric(07)
     ,popolaz_aimp     numeric(07)
     ,progressivo      numeric(07)
     ,flag_viario_manutentore char(01) not null default 'T'
     ,pec              varchar(100) --rom01
  );


create unique index coimcomu_00
    on coimcomu
     ( cod_comune
     );

alter table coimcomu 
  add constraint chk_flag_val_coimcomu
check (flag_val in ('T', 'F'));

alter table coimcomu
  add constraint chk_flag_viario_manutentore
check (flag_viario_manutentore in ('T', 'F'));
