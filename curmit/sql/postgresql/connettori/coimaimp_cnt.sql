/*==============================================================*/
/* table coimaimp_cnt: tabella anagrafica impianti                  */
/*==============================================================*/

create table coimaimp_cnt
     ( cod_impianto       varchar(08)  not null
     , cod_impianto_est   varchar(20)
     , cod_impianto_prov  varchar(08)
     , descrizione        varchar(50)
    -- provenienza_dati decodificato in coimtppr (1=Archivio fornitore...)
     , provenienza_dati   char(01)   
     , cod_combustibile   varchar(08)
     , cod_potenza        varchar(08)
     -- potenza termica focolare nominale totale
     , potenza            numeric(9,2) 
     -- potenza termica utile nominale totale
     , potenza_utile      numeric(9,2)
     , data_installaz     date         
     , data_attivaz       date
     , data_rottamaz      date
     , note               varchar(4000)
     , stato              char(01)
     , flag_dichiarato    char(01)
     , data_prima_dich    date
     , data_ultim_dich    date
     -- tipologia da tabella coimtpim
     , cod_tpim           varchar(08)
     , consumo_annuo      numeric(9,2)
     , n_generatori       numeric(2)
     -- tariffa 03 = riscald. superiore 100kw
     --         04 = riscald. autonomo e acqua calda
     --         05 = riscald. centralizzato
     --         07 = riscald. centralizzato piccoli condomini
     , stato_conformita   char(01)
     -- codice categoria edificio
     , cod_cted           varchar(08)
     , tariffa            varchar(08)
     , cod_responsabile   varchar(08)
     , flag_resp          char(01)
     , cod_intestatario   varchar(08)
     , flag_intestatario  char(01)
     , cod_proprietario   varchar(08)
     , cod_occupante      varchar(08)
     , cod_amministratore varchar(08)
     , cod_manutentore    varchar(08)
     , cod_installatore   varchar(08)
     , cod_distributore   varchar(08)
     , cod_progettista    varchar(08)
     , cod_amag           varchar(10)
     , cod_ubicazione     varchar(08)
     , localita           varchar(40)
     , cod_via            varchar(08)
     , toponimo           varchar(20)
     , indirizzo          varchar(100)
     , numero             varchar(08)
     , esponente          varchar(03)
     , scala              varchar(05)
     , piano              varchar(05)
     , interno            varchar(03)
     , cod_comune         varchar(08)
     , cod_provincia      varchar(08)
     , cap                varchar(05)
     , cod_catasto        varchar(20)
     , cod_tpdu           varchar(08)
     , cod_qua            varchar(08)
     , cod_urb            varchar(08)
     , data_ins           date
     , data_mod           date
     , utente             varchar(10)
     , flag_dpr412        char(01)
     , cod_impianto_dest  varchar(08)
     , anno_costruzione   date
-- marcatura efficienza energetica
     , marc_effic_energ   varchar(10)
     , volimetria_risc    numeric (9,2)
     , gb_x               varchar(50)
     , gb_y               varchar(50)
     , data_scad_dich     date
     );

create unique index coimaimp_cnt_00
    on coimaimp_cnt
     ( cod_impianto
     );

create unique index coimaimp_cnt_01
    on coimaimp_cnt
     ( cod_impianto_est
     );

create index coimaimp_cnt_02
    on coimaimp_cnt
     ( cod_responsabile
     );

create index coimaimp_cnt_03
    on coimaimp_cnt
     ( cod_comune
     , cod_via
     );

create index coimaimp_cnt_04
    on coimaimp_cnt
     ( indirizzo
     );

create index coimaimp_cnt_05
    on coimaimp_cnt
     ( cod_comune
     , cod_qua
     );

create index coimaimp_cnt_06
    on coimaimp_cnt
     ( cod_distributore
     , cod_amag
     );

create index coimaimp_cnt_07
    on coimaimp_cnt
     ( cod_impianto_prov
     );

create index coimaimp_cnt_08
    on coimaimp_cnt
     ( cod_intestatario
     );

create index coimaimp_cnt_09
    on coimaimp_cnt
     ( cod_proprietario
     );

create index coimaimp_cnt_10
    on coimaimp_cnt
     ( cod_occupante
     );

create index coimaimp_cnt_11
    on coimaimp_cnt
     ( cod_amministratore
     );


alter table coimaimp_cnt
  add constraint chk_flag_dichiarato_coimaimp_cnt
check (flag_dichiarato in ('S', 'N', 'C'));

create function coimaimp_cnt_upper_pr() returns opaque as '
declare
begin
    new.cod_impianto_est := upper(new.cod_impianto_est);
    new.toponimo         := upper(new.toponimo);
    new.indirizzo        := upper(new.indirizzo);
    return new;
end;
' language 'plpgsql';

create trigger coimaimp_cnt_upper_tr
    before insert or update on coimaimp_cnt
    for each row
        execute procedure coimaimp_cnt_upper_pr();
