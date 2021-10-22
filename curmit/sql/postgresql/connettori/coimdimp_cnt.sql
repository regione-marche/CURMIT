/*==============================================================*/
/* table coimdimp_cnt: tabella modelli H                            */
/*==============================================================*/

create table coimdimp_cnt
     ( cod_dimp         varchar(08) not null
     , cod_impianto     varchar(08) not null 
     , data_controllo   date         not null
    -- tolto il not null a 5 campi successivi
     , gen_prog         numeric(08)
     , cod_manutentore  varchar(08)
     , cod_responsabile varchar(08)
     , cod_proprietario varchar(08)
     , cod_occupante    varchar(08)
     , cod_documento    varchar(08)
     , flag_status      char(01)
     , garanzia         char(01)
     , conformita       char(01)
     , lib_impianto     char(01)
     , lib_uso_man      char(01)
     , inst_in_out      char(01)
     , idoneita_locale  char(01)
     , ap_ventilaz      char(01)
     , ap_vent_ostruz   char(01)
     , pendenza         char(01)
     , sezioni          char(01)
     , curve            char(01)
     , lunghezza        char(01)
     , conservazione    char(01)
     , scar_ca_si       char(01)
     , scar_parete      char(01)
     , riflussi_locale  char(01)
     , assenza_perdite  char(01)
     , pulizia_ugelli   char(01)
     , antivento        char(01)
     , scambiatore      char(01)
     , accens_reg       char(01)
     , disp_comando     char(01)
     , ass_perdite      char(01)
     , valvola_sicur    char(01)
     , vaso_esp         char(01)
     , disp_sic_manom   char(01)
     , organi_integri   char(01)
     , circ_aria        char(01)
     , guarn_accop      char(01)
     , assenza_fughe    char(01)
     , coibentazione    char(01)
     , eff_evac_fum     char(01)
     , cont_rend        char(01)
     , pot_focolare_mis numeric(6,2)
     , portata_comb_mis numeric(6,2)
     , temp_fumi        numeric(6,2)
     , temp_ambi        numeric(6,2)
     , o2               numeric(6,2)
     , co2              numeric(6,2)
     , bacharach        numeric(6,2)
     , co               numeric(10,4)
     , rend_combust     numeric(6,2)
     , osservazioni     varchar(4000)
     , raccomandazioni  varchar(4000)
     , prescrizioni     varchar(4000)
     , data_utile_inter date
     , n_prot           varchar(20)
     , data_prot        date
     , delega_resp      varchar(50)
     , delega_manut     varchar(50)
     , num_bollo        varchar(20)    -- non usato, vedi riferimento_pag
     , costo            numeric(6,2)
     , tipologia_costo  varchar(2)
     , riferimento_pag  varchar(20)
     , utente           varchar(10)
     , data_ins         date
     , data_mod         date
     , potenza          numeric(9,2) 
     , flag_pericolosita  char(01) -- (T,F)
     , flag_co_perc       char(01)
     , flag_tracciato     varchar(02)
     , cod_docu_distinta  varchar(08)
     , scar_can_fu        char(01)
     , tiraggio           numeric(9,2)
     , ora_inizio         varchar(08)
     , ora_fine           varchar(08)
     , rapp_contr         char(01)
     , rapp_contr_note    varchar(4000)
     , certificaz         char(01)
     , certificaz_note    varchar(4000)
     , dich_conf          char(01)
     , dich_conf_note     varchar(4000)
     , libretto_bruc      char(01)
     , libretto_bruc_note varchar(4000)
     , prev_incendi       char(01)
     , prev_incendi_note  varchar(4000)
     , lib_impianto_note  varchar(4000)
     , ispesl             char(01)
     , ispesl_note        varchar(4000)
     , data_scadenza      date
     , num_autocert       varchar(20)
     , esame_vis_l_elet   char(01)
     , funz_corr_bruc     char(01)
     , lib_uso_man_note   varchar(4000)
     , volimetria_risc    numeric(9,2)
     , consumo_annuo      numeric(9,2)
     );

create unique index coimdimp_cnt_00
    on coimdimp_cnt
     ( cod_dimp
     ); 

create        index coimdimp_cnt_01
    on coimdimp_cnt
     ( cod_impianto
     , data_controllo
     ); 

create        index coimdimp_cnt_02
    on coimdimp_cnt
     ( riferimento_pag
     , tipologia_costo
     );
