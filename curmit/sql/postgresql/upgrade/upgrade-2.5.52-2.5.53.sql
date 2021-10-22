
begin;

--l'upgrade aggiunge il parametro dbname_portale

--Luca R. I menù di inserimento impianto verranno richiamati da un'unico programma di scelta del tipo impianto da inserire

delete from coimmenu 
USING coimogge ogg
where coimmenu.livello = ogg.livello
  and coimmenu.scelta_1 = ogg.scelta_1
  and coimmenu.scelta_2 = ogg.scelta_2
  and coimmenu.scelta_3 = ogg.scelta_3
  and coimmenu.scelta_4 = ogg.scelta_4
  and ogg.nome_funz in ('isrt_manu_fr' , 'isrt_manu_te');

update coimogge 
--set descrizione = 'Inserimento scheda tecnica' 
set descrizione = 'Inserisci nuovo Impianto' --Luca R.
where nome_funz = 'isrt_manu' ;

delete from coimogge 
where nome_funz in ('isrt_manu_fr' , 'isrt_manu_te' ) ;

update coimfunz 
   set tipo_funz = 'secondario' 
     , nome_funz = 'isrt_manu'     
where nome_funz in ('isrt_manu' , 'isrt_manu_fr' , 'isrt_manu_te') ;

insert into coimfunz 
       (nome_funz
       , desc_funz
       , tipo_funz
       , dett_funz
       , azione) 
values ( 'isrt_manu'
--     , 'Inserimento scheda tecnica'
       , 'Inserisci nuovo Impianto' --Luca R.
       , 'primario'
       , 'coimaimp-isrt-manu-chose'
       , 'src/' ) ;


--    COGENERAZIONE

--Gac01 alter per cogenerazione
alter table coimgend add tipologia_cogenerazione varchar(1); -- M motore endotermico, C Caldaia cogenerativa, T turbogas e A altro
alter table coimgend add temp_h2o_uscita_min decimal(18,2);
alter table coimgend add temp_h2o_uscita_max decimal(18,2);
alter table coimgend add temp_h2o_ingresso_min decimal(18,2);
alter table coimgend add temp_h2o_ingresso_max decimal(18,2);
alter table coimgend add temp_h2o_motore_min decimal(18,2);
alter table coimgend add temp_h2o_motore_max decimal(18,2);
alter table coimgend add temp_fumi_valle_min decimal(18,2);
alter table coimgend add temp_fumi_valle_max decimal(18,2);
alter table coimgend add temp_fumi_monte_min decimal(18,2);
alter table coimgend add temp_fumi_monte_max decimal(18,2);
alter table coimgend add emissioni_monossido_co_max decimal(18,2);
alter table coimgend add emissioni_monossido_co_min decimal(18,2);

--Luca R. insert su coimfunz per cogenerazione
insert into coimfunz 
          ( nome_funz
          , desc_funz
          , tipo_funz
          , dett_funz
          , azione 
          ) values 
          ( 'isrt_manu'
          , 'Inserimento impianto di cogenerazione'
          , 'secondario'
          , 'coimaimp-isrt-manu-co'
          , 'src/' ) ;

--Luca R. insert fasca di potenza del cogeneratore
 insert into coimpote 
           ( cod_potenza
           , descr_potenza
           , potenza_min
           , potenza_max
           , data_ins
           , utente
	   , flag_tipo_impianto
	   ) values
	   ( 'CA'
           , 'POTENZA DA O A 999 KW'		   
           , 0.00     	    
           , 999.00		   
           , '2018-02-12'		   
           , 'romitti'
           , 'C'
           ) ;

--Luca R. insert per tariffa cogenerazione
insert into coimtari
          ( tipo_costo
          , cod_potenza			 
          , data_inizio				 
          , importo					 
          , cod_listino						 
          , flag_tariffa_impianti_vecchi				 
          ) values 
	  ( 10
	  , 'CA'
	  , '2018-01-01'
	  , 56.00
	  , '0'
	  , 'f'
	  ) ;

insert into coimfunz 
          ( nome_funz
 	  , desc_funz
	  , tipo_funz
	  , dett_funz
	  , azione
	  ) values
	  ( 'dimp'
	  , 'Nuovi allegati'
	  , 'secondario'
	  , 'coimdimp-r4-gest'
	  , 'src/' 
	  ) ;

insert into coimfunz 
          ( nome_funz
 	  , desc_funz
	  , tipo_funz
	  , dett_funz
	  , azione
	  ) values
	  ( 'dimp'
	  , 'Nuovi allegati'
	  , 'secondario'
	  , 'coimdimp-r4-layout'
	  , 'src/' 
	  ) ;


--Luca R. alter su coimdimp per i nuovi campi per cogenerazione.

alter table coimdimp add cog_capsula_insonorizzata varchar(1);
alter table coimdimp add cog_tenuta_circ_idraulico varchar(1);
alter table coimdimp add cog_tenuta_circ_olio varchar(1);
alter table coimdimp add cog_tenuta_circ_alim_combustibile varchar(1);
alter table coimdimp add cog_funzionalita_scambiatore varchar(1);
alter table coimdimp add cog_potenza_assorbita_comb  decimal(18,2);
alter table coimdimp add cog_potenza_termica_piena_pot decimal(18,2);
alter table coimdimp add cog_emissioni_monossido_co decimal(18,2);
alter table coimdimp add cog_temp_aria_comburente  decimal(18,2);
alter table coimdimp add cog_temp_h2o_uscita  decimal(18,2);
alter table coimdimp add cog_temp_h2o_ingresso  decimal(18,2);
alter table coimdimp add cog_potenza_morsetti_gen decimal(18,2);
alter table coimdimp add cog_temp_h2o_motore  decimal(18,2);
alter table coimdimp add cog_temp_fumi_valle decimal(18,2);
alter table coimdimp add cog_temp_fumi_monte decimal(18,2);

--Luca R. alter su coimdimp_stn  per i nuovi campi per cogenerazione.

alter table coimdimp_stn add cog_capsula_insonorizzata varchar(1);
alter table coimdimp_stn add cog_tenuta_circ_idraulico varchar(1);
alter table coimdimp_stn add cog_tenuta_circ_olio varchar(1);
alter table coimdimp_stn add cog_tenuta_circ_alim_combustibile varchar(1);
alter table coimdimp_stn add cog_funzionalita_scambiatore varchar(1);
alter table coimdimp_stn add cog_potenza_assorbita_comb  decimal(18,2);
alter table coimdimp_stn add cog_potenza_termica_piena_pot decimal(18,2);
alter table coimdimp_stn add cog_emissioni_monossido_co decimal(18,2);
alter table coimdimp_stn add cog_temp_aria_comburente  decimal(18,2);
alter table coimdimp_stn add cog_temp_h2o_uscita  decimal(18,2);
alter table coimdimp_stn add cog_temp_h2o_ingresso  decimal(18,2);
alter table coimdimp_stn add cog_potenza_morsetti_gen decimal(18,2);
alter table coimdimp_stn add cog_temp_h2o_motore  decimal(18,2);
alter table coimdimp_stn add cog_temp_fumi_valle decimal(18,2);
alter table coimdimp_stn add cog_temp_fumi_monte decimal(18,2);


end;
