/*========================================================================*/
/* table coimrelg : RELazione biennale regione lombardia: scheda Generale */
/*========================================================================*/

create table coimrelg
     ( cod_relg               number(08)   not null
     , data_rel               date         not null
     , ente_istat             varchar2(06) not null
     , resp_proc              varchar2(80)
     , nimp_tot_stim_ente     number(08)
     , nimp_tot_aut_ente      number(08)
     , nimp_tot_centr_ente    number(08)
     , nimp_tot_telerisc_ente number(08)
     , conv_ass_categ         date
     , conf_dgr7_7568         char(01)
     , npiva_ader_conv        number(05)
     , npiva_ass_acc_reg      number(05)
     , delib_autodic          char(01)
     , rifer_datai            date
     , rifer_dataf            date
     , valid_datai            date
     , valid_dataf            date
     , ntot_autodic_perv      number(08)
     , ntot_prescrizioni      number(08)
     , n_ver_interni          number(05)
     , n_ver_esterni          number(05)
     , n_accert_enea          number(05)
     , n_accert_altri         number(05)
     , nome_file_gen          varchar2(50)
     , nome_file_tec          varchar2(50)
     , data_ins               date
     , data_mod               date
     , utente                 varchar2(10)
     ) tablespace &ts_dat;

create unique index coimrelg_00
    on coimrelg
     ( cod_relg
     ) tablespace &ts_idx;


create unique index coimrelg_01
    on coimrelg
     ( data_rel
     , ente_istat
     ) tablespace &ts_idx;
