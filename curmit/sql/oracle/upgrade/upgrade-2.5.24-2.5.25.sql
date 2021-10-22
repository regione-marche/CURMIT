
begin;

--Nicola 17/09/2015 Alter tabelle per dichiarazione frequenza ed elenco operazioni di manut.
--                  per la provincia di Pesaro e Urbino

--alter table coimdope_aimp add cod_documento          varchar(08);

alter table coimdimp      add dam_tipo_manutenzione char(1); -- M=Manutenzione programmata, N=Nuova installazione/ristrutturazione, R=Riattivazione impianto/generatore

alter table coimdimp      add dam_flag_osservazioni    boolean not null default 'f';
alter table coimdimp      add dam_flag_raccomandazioni boolean not null default 'f';
alter table coimdimp      add dam_flag_prescrizioni    boolean not null default 'f';

alter table coimdimp      add dam_cognome_dichiarante  varchar(100);
alter table coimdimp      add dam_nome_dichiarante     varchar(100);
alter table coimdimp      add dam_tipo_tecnico         char(01);  -- In qualita' di A=Affidatario della manutenzione, T=Terzo responsabile
 

\i ../coimdimp_gend.sql

insert
  into coimfunz
     ( nome_funz
     , desc_funz
     , tipo_funz
     , dett_funz
     , azione
     )
values
     ( 'dimp'
     , 'Gestione dichiarazione di avvenuta manutenzione'
     , 'secondario'
     , 'coimdimp-dam-gest'
     , 'src/'
     );

insert
  into coimfunz
     ( nome_funz
     , desc_funz
     , tipo_funz
     , dett_funz
     , azione
     )
values
     ( 'dimp'
     , 'Stampa dichiarazione di avvenuta manuntenzione'
     , 'secondario'
     , 'coimdimp-dam-layout'
     , 'src/'
     );


end;
