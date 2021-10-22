/*========================================================================*/
/* table coimrelg : RELazione biennale regione lombardia: scheda Generale */
/*========================================================================*/

create table coimrelg
     ( cod_relg               numeric(08)  not null
     , data_rel               date         not null
     , ente_istat             varchar(06)  not null
     , resp_proc              varchar(80)
     , nimp_tot_stim_ente     numeric(08)
     , nimp_tot_aut_ente      numeric(08)
     , nimp_tot_centr_ente    numeric(08)
     , nimp_tot_telerisc_ente numeric(08)
     , conv_ass_categ         date
     , conf_dgr7_7568         char(01)
     , npiva_ader_conv        numeric(05)
     , npiva_ass_acc_reg      numeric(05)
     , delib_autodic          char(01)
     , rifer_datai            date
     , rifer_dataf            date
     , valid_datai            date
     , valid_dataf            date
     , ntot_autodic_perv      numeric(08)
     , ntot_prescrizioni      numeric(08)
     , n_ver_interni          numeric(05)
     , n_ver_esterni          numeric(05)
     , n_accert_enea          numeric(05)
     , n_accert_altri         numeric(05)
     , nome_file_gen          varchar(50)
     , nome_file_tec          varchar(50)
     , data_ins               date
     , data_mod               date
     , utente                 varchar(10)
     );

create unique index coimrelg_00
    on coimrelg
     ( cod_relg
     );

create unique index coimrelg_01
    on coimrelg
     ( data_rel
     , ente_istat
     );
