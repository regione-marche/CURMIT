-- Alessio 23/03/2017

begin;

--creo le potenze per il teleriscaldamento
insert into coimpote
 select 'T' || cod_potenza
      , descr_potenza
      , potenza_min
      , potenza_max
      , data_ins
      , data_mod
      , utente
      , 'T' 
from coimpote
where flag_tipo_impianto = 'R';

--aggiungo la tariffa per ogni potenza del teleriscaldamento
insert into coimtari
select 9
     , cod_potenza
     , '2017-01-01'
     , 14
     , 0
     , 'f' 
     , null
     , null
from coimpote
where flag_tipo_impianto = 'T';


-- Aggiunti campi mancanti per rct teleriscaldamento (copiati dalla cimp)

insert into coimfunz values ('dimp','Nuovi allegati','secondario','coimdimp-r3-gest','src/',null);
insert into coimfunz values ('dimp','Stampa allegati r3','secondario','coimdimp-r3-layout','src/',null);

insert into coimfunz values ('isrt_manu_te','Inserimento impianto di teleriscaldamento','primario','coimaimp-isrt-manu-te','src/',null);

insert into coimogge values ('2', '11', '50', '0', '0', 'funzione', 'Inserimento scheda tecnica per manut. -Teleriscaldamento', 'isrt_manu_te');

insert into coimmenu values ('system-admin', '2', '11', '50', '0', '0', '5', '9');
insert into coimmenu values ('ente-manutentore', '2', '11', '50', '0', '0', '3', '11');

alter table coimdimp add tel_stato_coibent_idoneo_imp              char(1);
alter table coimdimp add tel_linee_eletr_idonee                    char(1);
alter table coimdimp add tel_assenza_perdite_circ_idraulico        char(1);
alter table coimdimp add tel_potenza_compatibile_dati_prog         char(1);
alter table coimdimp add tel_stato_coibent_idoneo_scamb            char(1);
alter table coimdimp add tel_disp_regolaz_controll_funzionanti     char(1);
alter table coimdimp add tel_assenza_trafil_valv_regolaz           char(1);
alter table coimdimp add tel_temp_est                              integer;
alter table coimdimp add tel_temp_mand_prim                        integer;
alter table coimdimp add tel_temp_rit_prim                         integer;
alter table coimdimp add tel_potenza_termica                       integer;
alter table coimdimp add tel_portata_fluido_prim                   integer;
alter table coimdimp add tel_temp_mand_sec                         integer;
alter table coimdimp add tel_temp_rit_sec                          integer;
alter table coimdimp add tel_check_coerenza_paramentri             char(1);
alter table coimdimp add tel_check_perdite_h2o                     char(1);
alter table coimdimp add tel_check_install_involucro               char(1);
alter table coimdimp add tel_alimentazione                         char(1);
alter table coimdimp add tel_fluido_vett_term_uscita               char(1);
alter table coimdimp add tel_alimentazione_altro             varchar(4000);
alter table coimdimp add tel_fluido_altro                    varchar(4000);

alter table coimdimp_stn add tel_stato_coibent_idoneo_imp          char(1);
alter table coimdimp_stn add tel_linee_eletr_idonee                char(1);
alter table coimdimp_stn add tel_assenza_perdite_circ_idraulico    char(1);
alter table coimdimp_stn add tel_potenza_compatibile_dati_prog     char(1);
alter table coimdimp_stn add tel_stato_coibent_idoneo_scamb        char(1);
alter table coimdimp_stn add tel_disp_regolaz_controll_funzionanti char(1);
alter table coimdimp_stn add tel_assenza_trafil_valv_regolaz       char(1);
alter table coimdimp_stn add tel_temp_est                          integer;
alter table coimdimp_stn add tel_temp_mand_prim                    integer;
alter table coimdimp_stn add tel_temp_rit_prim                     integer;
alter table coimdimp_stn add tel_potenza_termica                   integer;
alter table coimdimp_stn add tel_portata_fluido_prim               integer;
alter table coimdimp_stn add tel_temp_mand_sec                     integer;
alter table coimdimp_stn add tel_temp_rit_sec                      integer;
alter table coimdimp_stn add tel_check_coerenza_paramentri         char(1);
alter table coimdimp_stn add tel_check_perdite_h2o                 char(1);
alter table coimdimp_stn add tel_check_install_involucro           char(1);
alter table coimdimp_stn add tel_alimentazione                     char(1);
alter table coimdimp_stn add tel_fluido_vett_term_uscita           char(1);
alter table coimdimp_stn add tel_alimentazione_altro         varchar(4000);
alter table coimdimp_stn add tel_fluido_altro                varchar(4000);

--modifica fatta da Sandro e già portato su Udine,Gorizia e Pordenone
insert into coimtdoc  values ( 'RC', 'Inserimento RCEE1', 'F'); 

end;
