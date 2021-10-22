/*==============================================================*/
/* table coimaimp: tabella anagrafica impianti riassuntiva      */
/*==============================================================*/

create table coimimpr
( cod_ente varchar (8) not null
, cod_impianto varchar (8) not null
, cod_impianto_est varchar (20)
, potenza numeric (9,2)
, potenza_utile numeric (9,2)
, cod_potenza varchar (8)
, tipo_impianto varchar (1)
, n_generatori numeric (2)
, flag_dpr412 varchar (1)
, cod_combustibile varchar (8)
, stato varchar (1)
, cod_via varchar  (8)
, localita varchar (40)
, toponimo varchar (20)
, indirizzo varchar (50)
, numero varchar (8)
, esponente varchar (3)
, scala varchar (5)
, piano varchar (5)
, interno varchar (5)
, cod_qua varchar (5)
, cod_urb varchar (5)
, cod_comune varchar (8)
, cod_provincia varchar (8)
, cap varchar (5)
, gb_x varchar(50)
, gb_y varchar(50)
, flag_gb varchar(2)
, flag_dichiarato varchar (1)
, anno_costruzione date   
, data_installaz date   
, data_attivaz date   
, data_rottamaz date   
, stato_conformita varchar (1)
, cod_cted varchar (8)
, cod_tpdu varchar (5)
, marc_effic_energ varchar (5)
, volimetria_risc numeric (9,2)
, consumo_annuo numeric (9,2)
, funz_consumo_um varchar (3)
, data_ins date   
, data_mod date   
, utente varchar (10)
, tot_autocert numeric (5)
, data_prima_autocert date
, data_ultim_autocert date   
, data_scad_autocert date   
, f_osservazioni_autocert varchar (1)
, f_raccomandazioni_autocert varchar (1)
, f_prescrizioni_autocert varchar (1)
, f_anomalie_autocert varchar (1)
, tot_rapporti numeric (5)
, data_primo_rapporto date
, data_ultim_rapporto date   
, f_osservazioni_rapporto varchar (1)
, esito_verifica varchar (2)
, f_anomalie_rapporto varchar (1)
, data_rif_impr date
);

create unique index coimimpr_00
    on coimimpr
     ( cod_ente
     , cod_impianto
     );

