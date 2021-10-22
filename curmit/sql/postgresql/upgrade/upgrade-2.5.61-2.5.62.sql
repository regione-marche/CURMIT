 begin;

--L'upgrade aggiunge il parametro tabella_caricamento_rcee_tipo_1

--Luca R. sdoppiamento del menù "Selezione impianto con dichiarazione in scadenza".
insert into coimfunz 
select 'maim-dich'
     , desc_funz
     , tipo_funz 
     , dett_funz
     , azione
     , 'tipo_filtro=DICH'
  from coimfunz 
 where nome_funz='maim'
   and tipo_funz = 'primario';

update coimfunz 
   set parametri = 'tipo_filtro=MAN'
where nome_funz='maim'
   and tipo_funz = 'primario';

insert into coimogge 
       ( livello
       , scelta_1
       , scelta_2
       , scelta_3
       , scelta_4
       , tipo
       , descrizione
       , nome_funz)
select livello
     , scelta_1
     , max(scelta_2::integer) + 1
     , scelta_3
     , scelta_4
     , 'funzione'
     , 'Selezione impianto con dichiarazione in scadenza'
     , 'maim-dich'
from coimogge
where livello = '2'
  and scelta_1='11'
  and scelta_3='0'
  and scelta_4='0'
group by livello
     , scelta_1
     , scelta_3
     , scelta_4;

update coimogge
   set descrizione='Selezione impianto con manutenzione in scadenza'
 where nome_funz='maim';

insert into coimmenu
select a.nome_menu
  , o.livello
  , o.scelta_1
  , o.scelta_2
  , o.scelta_3
  , o.scelta_4
  , a.lvl
  , (a.seq -1)
from coimogge o
,(select m.lvl
     , m.nome_menu
      , m.seq
from coimogge o
   ,coimmenu m
where nome_funz='maim'
and m.livello      = o.livello      
and m.scelta_1     = o.scelta_1     
and m.scelta_2     = o.scelta_2     
and m.scelta_3     = o.scelta_3     
and m.scelta_4     = o.scelta_4  ) a
where nome_funz='maim-dich';


--Luca R. aggiunto flag su coimtgen.
alter table coimtgen add flag_single_sign_on char(1) default 'f';

--Luca R. upgrade di 2 voci di menù. Bisogna chiedere a Sandro se vanno bene per tutti gli enti o se bisogna lanciarli manualmente.
update coimogge 
   set descrizione= 'Creazione distinta consegna per manutentore' 
 where livello ='3' 
   and scelta_1='11' 
   and scelta_2='55'
   and scelta_3='20' 
   and scelta_4='0' ;

update coimogge 
   set descrizione= 'Creazione distinta consegna per amministratore' 
 where livello ='3' 
   and scelta_1='11' 
   and scelta_2='55' 
   and scelta_3='15' 
   and scelta_4='0' ;
 


--GACALIN SVILUPPO SCHEDA 1 BIS LIBRETTO 
\i ../coimcondu.sql

alter table coimaimp add unita_immobiliari_servite char(1);
alter table coimaimp add cod_conduttore varchar (8);
--GACALIN FINE SVILUPPO SCHEDA 1 BIS

--Luca R. svilupo Scheda 4.1Bis
alter table coimgend add column funzione_grup_ter varchar(1) ;
alter table coimgend add column funzione_grup_ter_note_altro varchar(400) ;
alter table coimgend add column flag_caldaia_comb_liquid varchar(1) ;
alter table coimgend add column rend_ter_max numeric(9,2) ;

insert into coimfunz 
    values (
       'impianti'
     , 'Gestione Impianti 1Bis'
     , 'secondario'
     , 'coimaimp-bis-gest'
     , 'src/'
     , null);

insert into coimfunz 
    values (
       'impianti'
     , 'Ricerca conduttori impianto'
     , 'secondario'
     , 'coimcondu-filter'
     , 'src/'
     , null);

insert into coimfunz 
    values (
       'impianti'
     , 'Gestione conduttori impianto'
     , 'secondario'
     , 'coimcondu-gest'
     , 'src/'
     , null);

insert into coimfunz
    values (
       'impianti'
     , 'Inserimento conduttori impianto'
     , 'secondario'
     , 'coimcondu-isrt'
     , 'src/'
     , null);

insert into coimfunz
    values (
       'impianti'
     , 'Lista conduttori impianto'
     , 'secondario'
     , 'coimcondu-list'
     , 'src/'
     , null);

insert into coimfunz
    values (
       'impianti'
     , 'Lista generatori da scheda 1bis impianto'
     , 'secondario'
     , 'coimgend-1bis-list'
     , 'src/'
     , null);


update coimogge set descrizione='Ricerca impianti già in carico al Manutentore'  where nome_funz='impianti' ;

--GACALIN INSERIMENTO E UPDATE DEI COMBUSTIBILI
insert into coimcomb
 values(
  '8'
  ,upper('propano')
  ,current_date
  ,null
  ,'gacalin'
  ,'G'
  );

insert into coimcomb
 values(
  '9'
  ,upper('butano')
  ,current_date
  ,null
  ,'gacalin'
  ,'G'
  );		

insert into coimcomb
 values(
  '10'
  ,upper('biogas')
  ,current_date
    ,null
    ,'gacalin'
    ,'G'
    );			
    			
insert into coimcomb
 values(
  '13'
  ,upper('syngas')
  ,current_date
  ,null
  ,'gacalin'
  ,'G'
  );		

insert into coimcomb
 values(
  '14'
  ,upper('aria propanata')
  ,current_date
  ,null
  ,'gacalin'
  ,'G'
  );		
  
insert into coimcomb
 values(
  '15'
  ,upper('kerosene')
  ,current_date
  ,null
  ,'gacalin'
  ,'L'
  );		
  
insert into coimcomb
 values(
  '16'
  ,upper('olio vegetale')
  ,current_date
  ,null
  ,'gacalin'
  ,'L'
  );		
  
insert into coimcomb
 values(
  '17'
  ,upper('biodisel')
  ,current_date
  ,null
  ,'gacalin'
  ,'L'
  );			

insert into coimcomb
 values(
  '18'
  ,upper('bricchette')
  ,current_date
  ,null
  ,'gacalin'
  ,'S'
  );		

insert into coimcomb
 values(
  '19'
  ,upper('carbone')
  ,current_date
  ,null
  ,'gacalin'
  ,'S'
  );		

update coimcomb set tipo = 'G' where cod_combustibile = '4';         --G=Gassoso - L=Liquido - S=Solido - A=Altro GPL
update coimcomb set tipo = 'G' where cod_combustibile = '5';         --G=Gassoso - L=Liquido - S=Solido - A=Altro Metano
update coimcomb set tipo = 'L' where cod_combustibile = '3';         --G=Gassoso - L=Liquido - S=Solido - A=Altro Gasolio
update coimcomb set tipo = 'L' where cod_combustibile = '1';         --G=Gassoso - L=Liquido - S=Solido - A=Altro Olio
update coimcomb set tipo = 'S' where cod_combustibile = '6';         --G=Gassoso - L=Liquido - S=Solido - A=Altro Legna
update coimcomb set tipo = 'S' where cod_combustibile = '12';        --G=Gassoso - L=Liquido - S=Solido - A=Altro Combustibile solido
update coimcomb set tipo = 'A' where cod_combustibile = '7';         --G=Gassoso - L=Liquido - S=Solido - A=Altro Teleriscaldamento
--update coimcomb set tipo = 'G' where cod_combustibile = '88';        --G=Gassoso - L=Liquido - S=Solido - A=Altro Pompe di calore
update coimcomb set tipo = 'A' where cod_combustibile = '0';         --G=Gassoso - L=Liquido - S=Solido - A=Altro Non noto  
update coimcomb set tipo = 'A' where cod_combustibile = '2';         --G=Gassoso - L=Liquido - S=Solido - A=Altro Altro     
update coimcomb set tipo = 'A' where cod_combustibile = '11';        --G=Gassoso - L=Liquido - S=Solido - A=Altro Nafta 


--GACALIN QUESTE SONO LE INSERT GIA PRESENTI SU ITER-DEV	
insert into coimcomb
 values(
  '112'
  ,upper('cippato')
  ,'2017-03-09'
  ,null
  ,'sandro'
  ,'S'
  );		

insert into coimcomb
 values(
  '211'
  ,upper('pellet')
  ,'2017-03-09'
  ,null
  ,'sandro'
  ,'S'
  );		

insert into coimcomb
 values(
  '11'
  ,upper('nafta')
  ,'2017-05-23'
  ,null
  ,'sandro'
  ,null
  );		
--GACALIN QUESTE SONO LE INSERT GIA PRESENTI SU ITER-DEV

--AGGIUNTI CAMPI ACQUISTI, ACQUISTI2, SCORTA O LETTURA INIZIALE, SCORTA O LETTURA INIZIALE2, SCORTA O LETTURA FINALE e SCORTA O LETTURA FINALE2
alter table coimdimp add acquisti numeric(10,2);
alter table coimdimp add scorta_o_lett_iniz numeric(10,2);
alter table coimdimp add scorta_o_lett_fin numeric(10,2);
alter table coimdimp_stn add acquisti numeric(10,2);
alter table coimdimp_stn add scorta_o_lett_iniz numeric(10,2);
alter table coimdimp_stn add scorta_o_lett_fin numeric(10,2);
alter table coimdimp add acquisti2 numeric(10,2);
alter table coimdimp add scorta_o_lett_iniz2 numeric(10,2);
alter table coimdimp add scorta_o_lett_fin2 numeric(10,2);
alter table coimdimp_stn add acquisti2 numeric(10,2);
alter table coimdimp_stn add scorta_o_lett_iniz2 numeric(10,2);
alter table coimdimp_stn add scorta_o_lett_fin2 numeric(10,2);

alter table coimcomb alter column um type varchar(10);

--campi aggiunti su richiesta di Sandro il 07/05/2018
alter table coimgend add rif_uni_10389 char(1);      --scheda 4.1
alter table coimgend add altro_rif varchar(20);

alter table coimdimp add bacharach2 numeric(6,2);    
alter table coimdimp add bacharach3 numeric(6,2);
alter table coimdimp add portata_comb numeric(10,2);
alter table coimdimp add rispetta_indice_bacharach char(1);
alter table coimdimp add co_fumi_secchi char(1);
alter table coimdimp add rend_magg_o_ugua_rend_min char(1);

alter table coimdimp_stn add bacharach2 numeric(6,2);
alter table coimdimp_stn add bacharach3 numeric(6,2);
alter table coimdimp_stn add portata_comb numeric(10,2);
alter table coimdimp_stn add rispetta_indice_bacharach char(1);
alter table coimdimp_stn add co_fumi_secchi char(1);
alter table coimdimp_stn add rend_magg_o_ugua_rend_min char(1);

alter table coimdimp_prfumi add bacharach2 numeric(6,2);      --aggiunti per gestire più prove fumi 
alter table coimdimp_prfumi add bacharach3 numeric(6,2);      --aggiunti per gestire più prove fumi
alter table coimdimp_prfumi add portata_comb numeric(10,2);   --aggiunti per gestire più prove fumi
--FINE GACALIN

--Inizio gestione tipologie controlli:

\i ../coimtprc.sql

insert into coimtprc values ('CADALLE','Cadenza secondo Allegato 3 - L.R. 19/2015',false);
insert into coimtprc values ('REGINAD','Regolarizzazione inadempienze rispetto alla cadenza prevista dall''Allegato 3 - L.R. 19/2015',false);
insert into coimtprc values ('PRIMMES','Prima messa in servizio (nuova installazione)',true);
insert into coimtprc values ('SOSTGEN','Sostituzione del generatore',true);
insert into coimtprc values ('RISTRUT','Ristrutturazione dell''impianto',true);
insert into coimtprc values ('RIATTIV','Riattivazione dell''impianto',true);
insert into coimtprc values ('MANSTRA','Manutenzione straordinaria passibile di modificare l''efficienza energetica',true);

alter table coimdimp add cod_tprc varchar(08);
alter table coimdimp_stn add cod_tprc varchar(08);



--Luca R. 08/05/2018 Aggiunto campo data_libretto per la stampa del libretto della Regione Marche
alter table coimaimp add column data_libretto date ;

--Gacalin L. 10/05/2018 Aggiunto nuovo campi alla coimdimp, coimdimp_stn e coimdimp_prfumi
alter table coimdimp add portata_termica_effettiva numeric(6,2);
alter table coimdimp_stn add portata_termica_effettiva numeric(6,2);
alter table coimdimp_prfumi add portata_termica_effettiva numeric(6,2);

--Luca R. 28/05/2018 modifica e insert della tabella coimfuge  
insert into coimfuge 
       	  ( cod_fuge
          , descr_fuge
          , data_ins
          , utente ) 
            values 
          ( '4' 
          , 'Acqua surriscaldata' 
          , '2018-05-28'
          , 'romitti' );
insert into coimfuge 
          ( cod_fuge 
          , descr_fuge
          , data_ins
          , utente) 
            values 
          ( '5' 
          , 'Vapore' 
          , '2018-05-28'
          , 'romitti');
insert into coimfuge 
          ( cod_fuge
          , descr_fuge
          , data_ins
          , utente
          ) values 
          ( '6' 
          , 'Olio diatermico'
          , '2018-05-28'
          , 'romitti');
update coimfuge 
   set descr_fuge = 'Aria'
     , data_mod   = '2018-05-28' 
 where cod_fuge ='2' ;

alter table coimgend add column altro_funz varchar(20) ;
alter table coimdimp add column co_fumi_secchi_ppm decimal(10,4) ;
alter table coimdimp_prfumi add column co_fumi_secchi_ppm decimal(10,4) ;

--Gacalin 06/06/2018
alter table coimaimp add column tipologia_generatore char(5);
alter table coimaimp add column integrazione_per char(5);
alter table coimaimp add column altra_tipologia_generatore varchar(200);

--simone 07/06/2018 nuovi campi per cogenerazione
alter table coimdimp add cog_sovrafreq_soglia1    numeric(6,2);
alter table coimdimp add cog_sovrafreq_tempo1     numeric(6,2);
alter table coimdimp add cog_sottofreq_soglia1    numeric(6,2);
alter table coimdimp add cog_sottofreq_tempo1     numeric(6,2);
alter table coimdimp add cog_sovraten_soglia1     numeric(6,2);
alter table coimdimp add cog_sovraten_tempo1      numeric(6,2);
alter table coimdimp add cog_sottoten_soglia1     numeric(6,2);
alter table coimdimp add cog_sottoten_tempo1      numeric(6,2); 
alter table coimdimp add cog_sovrafreq_soglia2    numeric(6,2);
alter table coimdimp add cog_sovrafreq_tempo2     numeric(6,2);
alter table coimdimp add cog_sottofreq_soglia2    numeric(6,2);
alter table coimdimp add cog_sottofreq_tempo2     numeric(6,2);
alter table coimdimp add cog_sovraten_soglia2     numeric(6,2);
alter table coimdimp add cog_sovraten_tempo2      numeric(6,2);
alter table coimdimp add cog_sottoten_soglia2     numeric(6,2);
alter table coimdimp add cog_sottoten_tempo2      numeric(6,2); 
alter table coimdimp add cog_sovrafreq_soglia3    numeric(6,2);
alter table coimdimp add cog_sovrafreq_tempo3     numeric(6,2);
alter table coimdimp add cog_sottofreq_soglia3    numeric(6,2);
alter table coimdimp add cog_sottofreq_tempo3     numeric(6,2);
alter table coimdimp add cog_sovraten_soglia3     numeric(6,2);
alter table coimdimp add cog_sovraten_tempo3      numeric(6,2);
alter table coimdimp add cog_sottoten_soglia3     numeric(6,2);
alter table coimdimp add cog_sottoten_tempo3      numeric(6,2);

alter table coimdimp_stn add cog_sovrafreq_soglia1    numeric(6,2);
alter table coimdimp_stn add cog_sovrafreq_tempo1     numeric(6,2);
alter table coimdimp_stn add cog_sottofreq_soglia1    numeric(6,2);
alter table coimdimp_stn add cog_sottofreq_tempo1     numeric(6,2);
alter table coimdimp_stn add cog_sovraten_soglia1     numeric(6,2);
alter table coimdimp_stn add cog_sovraten_tempo1      numeric(6,2);
alter table coimdimp_stn add cog_sottoten_soglia1     numeric(6,2);
alter table coimdimp_stn add cog_sottoten_tempo1      numeric(6,2); 
alter table coimdimp_stn add cog_sovrafreq_soglia2    numeric(6,2);
alter table coimdimp_stn add cog_sovrafreq_tempo2     numeric(6,2);
alter table coimdimp_stn add cog_sottofreq_soglia2    numeric(6,2);
alter table coimdimp_stn add cog_sottofreq_tempo2     numeric(6,2);
alter table coimdimp_stn add cog_sovraten_soglia2     numeric(6,2);
alter table coimdimp_stn add cog_sovraten_tempo2      numeric(6,2);
alter table coimdimp_stn add cog_sottoten_soglia2     numeric(6,2);
alter table coimdimp_stn add cog_sottoten_tempo2      numeric(6,2); 
alter table coimdimp_stn add cog_sovrafreq_soglia3    numeric(6,2);
alter table coimdimp_stn add cog_sovrafreq_tempo3     numeric(6,2);
alter table coimdimp_stn add cog_sottofreq_soglia3    numeric(6,2);
alter table coimdimp_stn add cog_sottofreq_tempo3     numeric(6,2);
alter table coimdimp_stn add cog_sovraten_soglia3     numeric(6,2);
alter table coimdimp_stn add cog_sovraten_tempo3      numeric(6,2);
alter table coimdimp_stn add cog_sottoten_soglia3     numeric(6,2);
alter table coimdimp_stn add cog_sottoten_tempo3      numeric(6,2);
 
--Gacalin nuovi campi RCEE e DAM
alter table coimdimp add elet_esercizio_1 char(4);
alter table coimdimp add elet_esercizio_2 char(4);
alter table coimdimp add elet_esercizio_3 char(4);
alter table coimdimp add elet_esercizio_4 char(4);
alter table coimdimp add elet_lettura_iniziale    numeric(6,2);
alter table coimdimp add elet_lettura_finale      numeric(6,2);
alter table coimdimp add elet_consumo_totale      numeric(6,2);
alter table coimdimp add elet_lettura_iniziale_2  numeric(6,2);
alter table coimdimp add elet_lettura_finale_2    numeric(6,2);
alter table coimdimp add elet_consumo_totale_2    numeric(6,2);

alter table coimdimp_stn add elet_esercizio_1 char(4);
alter table coimdimp_stn add elet_esercizio_2 char(4);
alter table coimdimp_stn add elet_esercizio_3 char(4);
alter table coimdimp_stn add elet_esercizio_4 char(4);
alter table coimdimp_stn add elet_lettura_iniziale     numeric(6,2);
alter table coimdimp_stn add elet_lettura_finale      numeric(6,2);
alter table coimdimp_stn add elet_consumo_totale      numeric(6,2);
alter table coimdimp_stn add elet_lettura_iniziale_2  numeric(6,2);
alter table coimdimp_stn add elet_lettura_finale_2    numeric(6,2);
alter table coimdimp_stn add elet_consumo_totale_2    numeric(6,2); 

delete from wal_bodies where body_id=2;
update wal_bodies set body_name='Ente' where body_id=1;
update wal_bodies set body_name='Regione' where body_id=3;

alter table coimcitt add patentino boolean not null default 'f';            --gac01
alter table coimcitt add patentino_fgas boolean not null default 'f';       --gac01
alter table coimcitt alter column pec type varchar(100);

--Gacalin 13/06/2018: riporto le query già lanciate da Simone
delete from coimtipo_grup_termico where cod_grup_term in ('GTM2','GTM3');
update coimtipo_grup_termico  set desc_grup_term = 'Gruppo termico 
modulare' where cod_grup_term='GTM1';
update coimgend set cod_grup_term='GTM1' where cod_grup_term in 
('GTM2','GTM3');

--Rom 18/06/2018 Aggiunto campo Tipologia Intervento sulla coimaimp
alter table coimaimp add column tipologia_intervento char(5);

--Nuovo programma per visualizzazione schede libretto
insert into coimfunz values ('impianti','Lista Schede Libretto'    ,'secondario','coimaimp-schede-libretto-list'   ,'src','');

--Luca R. nuova tabella coimgend_pote per inserire le singole potenze delle prove_fumi
\i ../coimgend_pote.sql

insert into coimfunz 
          ( nome_funz
          , desc_funz
          , tipo_funz
          , dett_funz
          , azione
          ) values
          ('datigen'
          ,'Potenze singoli moduli'
          , 'secondario'
          , 'coimgend-pote'
          , 'src/') ;

--Gacalin 28/06/2018 inseriti campi coimaimp
alter table coimaimp add column integrazione char (1);
alter table coimaimp add column superficie_integrazione numeric(6,2);
alter table coimaimp add column nota_altra_integrazione varchar(200);
alter table coimaimp add column pot_utile_integrazione numeric (6,2);

--Gacalin 29/06/2018 aggiunto tipo combustibile cogeneratore
--insert into coimcomb
-- values(
--  '20'
--  ,upper('cogeneratore')
--  ,'2018-06-29'
--  ,null
--  ,'gacalin'
--  ,null
--  );

--Gacalin 02/07/2018 riporto le update e le insert lanciate per modificare la tendina Destinazione d'uso scheda 4/4.1bis
update coimutgi set descr_utgi = 'Produzione di acqua calda sanitaria' where cod_utgi = 'D';
update coimutgi set descr_utgi = 'Climatizzazione invernale + produzione ACS' where cod_utgi = 'E';
update coimutgi set descr_utgi = 'Climatizzazione estiva' where cod_utgi = 'F';
update coimutgi set descr_utgi = 'Climatizzazione invernale' where cod_utgi = 'R';
insert into coimutgi values('I', 'Climatizzazione invernale + Estiva', '2018-07-02', null, 'gacalin', 'Climatizzazione invernale + Estiva');

--Gacalin 19/07/2018 creata nuova tabella coimoper per gestione campo operazione nelle dichiarazioni di avvenuta manutenzione
\i ../coimoper.sql

insert into coimfunz
    values (
       'operazioni'
     , 'Tipi di operazioni'
     , 'primario'
     , 'coimoper-list'
     , 'tabgen/'
     , null);

insert into coimfunz
    values (
       'operazioni'
     , 'Tipi di operazioni'
     , 'secondario'
     , 'coimoper-gest'
     , 'tabgen/'
     , null);

--Gacalin 20/07/2018 inserita nuova voce menu tipo operazioni
insert into coimogge
          ( livello
          , scelta_1
          , scelta_2
          , scelta_3
          , scelta_4
          , tipo
          , descrizione
          , nome_funz )
 select a.livello
      , a.scelta_1
      , a.scelta_2
      , max(b.scelta_3::integer) +1
      , a.scelta_4
      , a.tipo
      , 'Tipi Operazioni'
      , 'operazioni'
   from coimogge as a	
      , coimogge as b
  where b.livello= a.livello
    and b.scelta_1 =a.scelta_1
    and a.nome_funz = 'combustibile'
  group by a.livello
      , a.scelta_1
      , a.scelta_2
      , a.scelta_4
      , a.tipo;	  
	      
insert into coimmenu
select a.nome_menu
     , o.livello
     , o.scelta_1
     , o.scelta_2
     , o.scelta_3
     , o.scelta_4
     , a.lvl
     , (a.seq -1)
  from coimogge o
     ,(select m.lvl
     , m.nome_menu
     , m.seq
  from coimogge o
     ,coimmenu m
 where nome_funz='combustibile'
   and m.livello      = o.livello
   and m.scelta_1     = o.scelta_1
   and m.scelta_2     = o.scelta_2
   and m.scelta_3     = o.scelta_3
   and m.scelta_4     = o.scelta_4  ) a
 where nome_funz='operazioni';

--Gacalin 23/08/2018 aggiungo cod manutentore alla tabella degli strumenti
--alter table iter_tools add column cod_manutentore varchar(8); 
--Gacalin 23/08/2018 Creo nuova tabella strumenti del manutentore
\i ../coimstru_manu.sql
alter table coimdimp add cod_strumento_01 varchar(8);
alter table coimdimp add cod_strumento_02 varchar(8);

alter table coimdimp_stn add cod_strumento_01 varchar(8);
alter table coimdimp_stn add cod_strumento_02 varchar(8);

\i ../coimgend_stesso_ambiente.sql
			
insert into coimfunz values ('datigen','Inserisci generatori stesso ambiente','secondario','coimgend-stesso-ambiente','src/','') ;
insert into coimfunz values ('datigen','Inserisci generatori stesso ambiente','secondario','coimgend-stesso-ambiente-gest','src/','') ;

alter table coimaimp add column sezione varchar(20) ;  --LucaR.

--LucaR. 05/09/2018
alter table coimrecu_cond_aimp add column "flag_sostituito" boolean default false ; 
alter table coimaltr_gend_aimp add column "flag_sostituito" boolean default false ;
alter table coimpomp_circ_aimp add column "flag_sostituito" boolean default false ;
alter table coimaccu_aimp      add column "flag_sostituito" boolean default false ;
alter table  coimraff_aimp     add column "flag_sostituito" boolean default false ;
alter table coimscam_calo_aimp add column "flag_sostituito" boolean default false ;
alter table coimcirc_inte_aimp add column "flag_sostituito" boolean default false ;
alter table coimtrat_aria_aimp add column "flag_sostituito" boolean default false ;
alter table coimrecu_calo_aimp add column "flag_sostituito" boolean default false ;
alter table coimvent_aimp      add column "flag_sostituito" boolean default false ;
alter table coimtorr_evap_aimp add column "flag_sostituito" boolean default false ;

--LucaR. 26/09/2018
alter table coimgend add column flag_sostituito char(1) default 'N';
drop index coimgend_01;
--sim successivamente si è deciso che i sostituiti tengono lo stesso gen_prog_est quindi elimino solo il vincolo e non lo ricreo
--create unique index coimgend_01
--    on coimgend
--     ( cod_impianto
--     , gen_prog_est
--     , flag_sostituito
--     , flag_attivo  
--     );

--LucaR. 04/10/2018
alter table coimaimp add column flag_ibrido char(1) ;

--LucaR. 10/10/2018 ATTENZIONE: TUTTI GLI ENTI DOVRANNO AVERE IL CAMPO email VALORIZZATO!!!!!!!!!
alter table coimdesc add column email varchar(150) ;

--LucaR. 17/10/2018 
alter table coim_as_resp add column flag_as_resp char(1) ;
--LucaR. 07/11/2018
alter table coimaimp           add column tratt_acqua_raff_filtraz_note_altro  varchar(1000);
alter table coimaimp           add column tratt_acqua_raff_tratt_note_altro    varchar(1000);
alter table coimaimp           add column tratt_acqua_raff_cond_note_altro     varchar(1000);
alter table coimrecu_cond_aimp add column gt_collegato                         integer;
alter table coimcamp_sola_aimp add column data_installaz_nuova_conf            date;
alter table coimcamp_sola_aimp add column flag_sostituito                      boolean default false ;
alter table coimaimp           add column sistem_emis_radiatore                char(1);
alter table coimaimp           add column sistem_emis_termoconvettore          char(1);
alter table coimaimp           add column sistem_emis_ventilconvettore         char(1);
alter table coimaimp           add column sistem_emis_pannello_radiante        char(1);
alter table coimaimp           add column sistem_emis_bocchetta                char(1);
alter table coimaimp           add column sistem_emis_striscia_radiante        char(1);
alter table coimaimp           add column sistem_emis_trave_fredda             char(1);
alter table coimaimp           add column sistem_emis_altro                    char(1);
alter table coimaimp           add column regol_curva_ind_iniz_num_sr          integer;
alter table coimaimp           add column regol_curva_ind_iniz_flag_sostituito boolean default false;
alter table coimaimp           add column regol_valv_ind_num_vr                integer;
alter table coimaimp           add column regol_valv_ind_flag_sostituito       boolean default false;
\i ../coimaimp_sistemi_regolazione.sql
\i ../coimaimp_valvole_regolazione.sql
insert into coimfunz values ('impianti','Gestione Sistemi di Regolazione','secondario','coimsist-reg-gest','src','');
insert into coimfunz values ('impianti','Gestione Valvole di Regolazione','secondario','coimvalv-reg-gest','src','');
alter table coimutgi alter column descr_utgi type varchar(250);
insert into coimutgi values ('RA' ,'Riscaldamento ambienti',current_date,null,'romitti','Riscaldamento ambienti');
insert into coimutgi values ('RAD','Riscaldamento ambienti + Produzione di acqua calda sanitaria',current_date,null,'romitti','Riscaldamento ambienti + Produzione di acqua calda sanitaria');

--Gacalin 08/11/2018
alter table coimgend           add column flag_clima_invernale char(1);
alter table coimgend           add column flag_prod_acqua_calda char(1);
alter table coimdimp           add column data_ultima_manu date;
alter table coimdimp_stn       add column data_ultima_manu date;
alter table coimdimp           add column flag_pagato char(1);
alter table coimdimp_stn       add column flag_pagato char(1);

--Gacalin 21/11/2018
alter table coimnoveb add column flag_dichiarante char(1);
alter table coimnoveb add column flag_rispetta_val_min char(1);
alter table coimnoveb add column cognome_dichiarante varchar(200);
alter table coimnoveb add column nome_dichiarante varchar(200);

--LucaR. 29/11/2018
alter table coimgend add column flag_clim_est char(1);
alter table coimgend add column flag_altro char(1);
alter table coimgend add column motivazione_disattivo char(1) ;
--LucaR. 21/12/2018
alter table coimrecu_cond_aimp add column num_rc_sostituente integer;
alter table coimcamp_sola_aimp add column num_cs_sostituente integer ;
alter table coimaltr_gend_aimp add column num_ag_sostituente integer ;
alter table coimaimp_sistemi_regolazione add column num_sr_sostituente integer;
alter table coimaimp add column num_sr_sostituente integer;
alter table coimaimp add column num_vr_sostituente integer;
alter table coimaimp_valvole_regolazione add column num_vr_sostituente integer;
alter table coimpomp_circ_aimp add column num_po_sostituente integer;
alter table coimvent_aimp add column num_vm_sostituente integer;
alter table coimaccu_aimp add column num_ac_sostituente integer ;
alter table coimtorr_evap_aimp add column num_te_sostituente integer;
alter table coimrecu_calo_aimp add column num_rc_sostituente integer;
alter table coimscam_calo_aimp add column num_sc_sostituente integer;
alter table coimtrat_aria_aimp add column num_ut_sostituente integer;
alter table coimraff_aimp add column num_rv_sostituente integer;
alter table coimcirc_inte_aimp add column num_ci_sostituente integer;

--LUCAR. 04/01/2019
alter table coimtpco alter column  descr_tpco type varchar(400);
update coimtpco set descr_tpco = 'Ad assorbimento a fiamma diretta', data_mod = current_date where cod_tpco = '1' ;
update coimtpco set descr_tpco = 'A ciclo di compressione con motore elettrico', data_mod = current_date where cod_tpco = '2' ;
update coimtpco set descr_tpco = 'Ad assorbimento per recupero di calore', data_mod = current_date where cod_tpco = '3' ;
update coimtpco set descr_tpco = 'A ciclo di compressione con motore endotermico', data_mod = current_date where cod_tpco = '4' ;
--LUCAR. 07/01/2019
alter table coimaimp alter column integrazione_per type varchar(20);
--LUCAR. 15/01/2019
alter table coimgend add column cod_installatore varchar(8) ;
alter table coimgend add column sorgente_lato_esterno varchar(2);
alter table coimgend add column fluido_lato_utenze    varchar(2);
--LUCAR. 19/01/2019
update coimtppr set descr_tppr = 'RCEE', data_mod=current_date, utente='romitti' where cod_tppr = '3';
update coimtppr set descr_tppr = 'Ispezione in campo', data_mod=current_date, utente='romitti' where cod_tppr = '5';
alter table coimaimp add column volimetria_raff numeric(9,2) ;
--LUCAR. 11-02-2019
update coimtppr set descr_tppr = 'Precedente database' , data_mod=current_date, utente='romitti' where cod_tppr = '0' ;
update coimtppr set descr_tppr = 'Distributore di combustibile' , data_mod=current_date, utente='romitti' where cod_tppr = '1' ;
alter table coimtppr alter column descr_tppr type varchar(200);
update coimtppr set descr_tppr = 'Nuova Installazione/Ristrutturazione' , data_mod=current_date, utente='romitti' where cod_tppr = '2' ;
update coimtppr set descr_tppr = 'Caricamento impianto esistente da parte del manutentore' , data_mod=current_date, utente='romitti' where cod_tppr = '7';
--LUCAR. 13/02/2019
insert into coimutgi (cod_utgi, descr_utgi, descr_e_utgi, data_ins, utente) values ('FD','Climatizzazione estiva + produzione ACS','Climatizzazione estiva + produzione ACS',current_date,'romitti');
insert into coimutgi (cod_utgi, descr_utgi, descr_e_utgi, data_ins, utente) values ('FRD','Climatizzazione estiva + Climatizzazione invernale + produzione ACS','Climatizzazione estiva + Climatizzazione invernale + produzione ACS',current_date,'romitti');
--LUCAR. 21/02/2019
alter table coimgend add column tel_alimentazione varchar(1);

--aggiunto il campo per gestire i documenti su file system e non sul database
alter table coimdocu add column path_file varchar(4000);


--LUCAR. 07/03/2019
update coimtpes set descr_tpes  = 'Impianti senza REE'                where cod_tpes  = '4';
update coimogge set descrizione = 'Caricamento rapporti di Ispezione' where nome_funz = 'cari-controlli';
update coimogge set descrizione = 'Spostamento RCEE'                  where nome_funz = 'coimdimp-dest'; 
--LUCAR. 11/03/2019
insert into coimtpes values('19','Impianti senza DAM',current_date,null,'romitti');

--simone sistemo le potenze come indicato in fase di collaudo 
update coimpote set potenza_min='0.01' where cod_potenza='FB';
update coimpote set potenza_min='5' where cod_potenza='B';

--simone corretto problema su permessi lista "Selezione impianto con dichiarazione in scadenza" emerso in fase di collaudo
insert into coimfunz
values ('maim'
   ,'Gestione Impianti'
   ,'secondario'
   ,'coimaimp-gest'
   ,'src/'
   ,null);
	       

--se non servono, vanno tolti i permessi al menu' Amministrazione --> Lista Movimenti

--LucaR. 13/06/2019 
insert into coimfunz values ('estr-stampa','Stampa estrazione impianti per controlli','primario','coimestr-stampa-filter','src/','');

insert into coimogge values ('2','16','39','0','0','funzione','Stampa estrazione impianti per controlli','estr-stampa');

insert into coimmenu (
     select nome_menu
          , '2'
          , '16'
          , '39'
          , scelta_3
          , scelta_4
          , lvl
          , seq
       from coimmenu
      where livello  = '2'
        and scelta_1 = '16'
        and scelta_2 = '12');

insert into coimfunz values ('estr-stampa','Stampa estrazione impianti per controlli','secondario','coimestr-stampa','src/','');

--simone aggiunto nuovo menu per caricamento del freddo
insert into coimogge
        values ('3','23','11','48','0','funzione','Caricamento RCEE di tipo 2','cari-rcee-tipo-2');

insert into coimfunz
        values ('cari-rcee-tipo-2','Caricamento RCEE di tipo 2 da file esterno','primario','coimcari-rcee-tipo-2-gest','src/',null);
	
delete from coimogge where descrizione='Caricamento modelli F' or descrizione='Caricamento modelli G';

--Gacalin 05/07/2019 aggiunto nome_funz per il freddo per richiamare il programma coimcorr-anom-gest
insert into coimfunz
        values ('cari-rcee-tipo-2','correzione anomalie importazione','secondario','coimcorr-anom-gest','src/',null);
insert into coimfunz
        values ('cari-rcee-tipo-1','correzione anomalie importazione','secondario','coimcorr-altre-anom-gest','src/',null);
insert into coimfunz
        values ('cari-rcee-tipo-2','correzione anomalie importazione','secondario','coimcorr-altre-anom-gest','src/',null);
		


alter table coimesit alter column url type varchar(250);

--sim modifica per gestire i sostituiti
alter table coimgend add column gen_prog_originario integer;

--rom modifica per rapporti ispezione
alter table coimcimp add column int_rend_term char(1);
alter table coimcimp add column int_rend_term_note varchar(4000);

--gac01 aggiunti campi patentino e patentino_fgas
alter table coimopma add patentino boolean not null default 'f';
alter table coimopma add patentino_fgas boolean not null default 'f';

alter table coiminco add flag_blocca_rcee boolean default 'f';

insert into coimmenu
select a.nome_menu
     , o.livello	
     , o.scelta_1
     , o.scelta_2
     , o.scelta_3
     , o.scelta_4
     , a.lvl
     , (a.seq -1)
  from coimogge o
     ,(select m.lvl
            , m.nome_menu
            , m.seq
	 from coimogge o
	    , coimmenu m
        where nome_funz='cari-rcee-tipo-1'
          and m.livello      = o.livello
          and m.scelta_1     = o.scelta_1
          and m.scelta_2     = o.scelta_2
          and m.scelta_3     = o.scelta_3
          and m.scelta_4     = o.scelta_4  ) a
  where nome_funz='cari-rcee-tipo-2';

--query sviluppate in fase di messa in prod per correggere i dati della coimcomb
update coimcomb set tipo='A',um='Kg' where cod_combustibile='20'; --cogeneratore	
update coimcomb set tipo='L' where cod_combustibile='20'; --nafta			
update coimcomb set tipo='X', descr_comb='NON NOTO TOGLIERE' where cod_combustibile='0' ; --non noto
update coimcomb set tipo='S', descr_comb='ALTRO TOGLIERE' where cod_combustibile='2' ; --altro
update coimcomb set um='m&#179;' where cod_combustibile='3'; --gasolio
update coimcomb set um='kg' where cod_combustibile='211'; --pellet
update coimcomb set um='kg' where cod_combustibile='15'; --KEROSENE
update coimcomb set um='m³/kg' where cod_combustibile='88'; --pompa di calore
update coimcomb set um='m³' where cod_combustibile='4'; --gpl

alter table coimstru_manu alter column marca_strum    type varchar(200);
alter table coimstru_manu alter column modello_strum  type varchar(200);
alter table coimstru_manu alter column matr_strum     type varchar(200);

--inserisco i campi per i caricamenti massivi
insert into coimtabs values ('rce1','cod_impianto_est','CODICE IMPIANTO','varchar','20','S','','','1000');
insert into coimtabs values ('rce1','targa','TARGA','varchar','20','S','','','1010');
insert into coimtabs values ('rce1','data_controllo','DATA CONTROLLO','date','','S','','','1020');
insert into coimtabs values ('rce1','flag_status','ESITO CONTROLLO','varchar','2','S','','P,N','1030');
insert into coimtabs values ('rce1','gen_prog','PROGRESSIVO GENERATORE','numeric','8,0','S','1','','1040');
insert into coimtabs values ('rce1','pdr','PDR','varchar','20','S','','','1050');
insert into coimtabs values ('rce1','pod','POD','varchar','20','N','','','1060');
insert into coimtabs values ('rce1','comune','COMUNE','varchar','40','S','','','1070');
insert into coimtabs values ('rce1','toponimo','TOPONIMO','varchar','10','S','','','1080');
insert into coimtabs values ('rce1','indirizzo','VIA','varchar','30','S','','','1090');
insert into coimtabs values ('rce1','civico','CIVICO','varchar','5','N','','','1100');
insert into coimtabs values ('rce1','matricola','MATRICOLA','varchar','40','S','','','1120');
insert into coimtabs values ('rce1','modello','MODELLO','varchar','40','S','','','1130');
insert into coimtabs values ('rce1','cod_manutentore','CODICE MANUTENTORE','varchar','8','S','','','1150');
insert into coimtabs values ('rce1','cognome_manu','COGNOME MANUTENTORE O RAGIONE SOCIALE','varchar','100','N','','','1170');
insert into coimtabs values ('rce1','nome_manu','NOME MANUTENTORE','varchar','100','N','','','1180');
insert into coimtabs values ('rce1','indirizzo_manu','INDIRIZZO MANUTENTORE','varchar','40','N','','','1190');
insert into coimtabs values ('rce1','comune_manu','COMUNE MANUTENTORE','varchar','40','N','','','1200');
insert into coimtabs values ('rce1','telefono_manu','TELEFONO MANUTENTORE','varchar','15','N','','','1210');
insert into coimtabs values ('rce1','cap_manu','CAP MANUTENTORE','varchar','5','N','','','1220');
insert into coimtabs values ('rce1','cod_fiscale_manu','IDENTIFICATIVO FISCALE MANUTENTORE','varchar','16','N','','','1230');
insert into coimtabs values ('rce1','cod_opmanu_new','CODICE OPERATORE MANUTENTORE','varchar','16','S','','','1240');
insert into coimtabs values ('rce1','flag_responsabile','FLAG RESPONSABILE','varchar','1','S','','T,A,O,P','1250');
insert into coimtabs values ('rce1','nome_resp','NOME RESPONSABILE','varchar','100','S','','','1260');
insert into coimtabs values ('rce1','cognome_resp','COGNOME RESPONSABILE','varchar','100','S','','','1270');
insert into coimtabs values ('rce1','indirizzo_resp','INDIRIZZO RESPONSABILE','varchar','40','S','','','1280');
insert into coimtabs values ('rce1','comune_resp','COMUNE RESPONSABILE','varchar','40','S','','','1290');
insert into coimtabs values ('rce1','provincia_resp','PROVINCIA RESPONSABILE','varchar','4','S','','','1300');
insert into coimtabs values ('rce1','natura_giuridica_resp','NATURA GIURIDICA RESPONSABILE','varchar','1','S','','G,F','1310');
insert into coimtabs values ('rce1','cap_resp','CAP RESPONSABILE ','varchar','5','S','','','1320');
insert into coimtabs values ('rce1','cod_fiscale_resp','IDENTIFICATIVO FISCALE RESPONSABILE','varchar','16','S','','','1330');
insert into coimtabs values ('rce1','telefono_resp','TELEFONO RESPONSABILE ','varchar','15','N','','','1340');
insert into coimtabs values ('rce1','ora_inizio','ORARIO INIZIO CONTROLLO','varchar','8','N','','','1350');
insert into coimtabs values ('rce1','ora_fine','ORARIO FINE CONTROLLO ','varchar','8','N','','','1360');
insert into coimtabs values ('rce1','num_autocert','NUMERO RAPPORTO DI CONTROLLO','varchar','20','N','','','1370');
insert into coimtabs values ('rce1','conformita','CONFORMITA','varchar','1','S','','S,N,C','1380');
insert into coimtabs values ('rce1','lib_impianto','LIBRETTO IMPIANTO','varchar','1','S','','S,N,C','1390');
insert into coimtabs values ('rce1','lib_uso_man','LIBRETTO USO E MANUTENZIONE IMPIANTO - CALDAIA','varchar','1','S','','S,N,C','1400');
insert into coimtabs values ('rce1','rct_lib_uso_man_comp','LIBRETTO compilato IN TUTTE LE SUE PARTI','varchar','1','S','','S,N,C','1410');
insert into coimtabs values ('rce1','rct_dur_acqua','Durezza totale','numeric','9,2','N','','','1420');
insert into coimtabs values ('rce1','rct_tratt_in_risc','Trattamento in riscaldamento','varchar','1','S','','R,A,F,D,C,K,J,W,T','1430');
insert into coimtabs values ('rce1','rct_tratt_in_acs','Trattamento in ACS','varchar','1','S','','R,A,F,D,C,K,J,W,T','1440');
insert into coimtabs values ('rce1','idoneita_locale','IDONEITA LOC PER INSTALLAZIONE INTERNA','varchar','1','S','','S,N,C','1450');
insert into coimtabs values ('rce1','rct_install_interna','Per installazione esterna:generatori idonei','varchar','1','S','','S,N,C','1460');
insert into coimtabs values ('rce1','ap_vent_ostruz','Aperture di ventilazione/areazione libere da ostruzioni','varchar','1','S','','S,N,C','1470');
insert into coimtabs values ('rce1','ap_ventilaz','Adeguate dimensione aperture ventilazione/areazione','varchar','1','S','','S,N,C','1480');
insert into coimtabs values ('rce1','rct_canale_fumo_idoneo','Canali da fumo e condotti di scarico idonei','varchar','1','S','','S,N,C','1490');
insert into coimtabs values ('rce1','rct_sistema_reg_temp_amb','Sistema di regolazione temp. ambiente funzionante','varchar','1','S','','S,N,C','1500');
insert into coimtabs values ('rce1','rct_assenza_per_comb','Assenza di perdite di combustibile liquido','varchar','1','S','','S,N,C','1510');
insert into coimtabs values ('rce1','rct_idonea_tenuta','Idonea tenuta dell''impianto interno e raccordi con il generatore','varchar','1','S','','S,N,C','1520');
insert into coimtabs values ('rce1','disp_comando','Dispositivi di comando funzionanti correttamente','varchar','1','S','','S,N,C','1530');
insert into coimtabs values ('rce1','disp_sic_manom','Dispositivi di sicurezza non manomessi e/o cortocircuitati','varchar','1','S','','S,N,C','1540');
insert into coimtabs values ('rce1','rct_valv_sicurezza','Valvola di sicurezza alla sovrapressione a scarico libero','varchar','1','S','','S,N,C','1550');
insert into coimtabs values ('rce1','rct_scambiatore_lato_fumi','Controllato e pulito scambiatore lato fumi','varchar','1','S','','S,N,C','1560');
insert into coimtabs values ('rce1','rct_riflussi_comb','Presenza dei riflussi della combustione','varchar','1','S','','S,N,C','1570');
insert into coimtabs values ('rce1','rct_uni_10389','Risultati controllo secondo norma UNI 10389-1 conformi alla legge','varchar','1','S','','S,N,C','1580');
insert into coimtabs values ('rce1','cod_tprc','Motivo compilazione RCEE','varchar','1','S','','1,2,3,4,5,6,7','1590');
insert into coimtabs values ('rce1','cont_rend','CONTROLLO RENDIMENTO','varchar','1','S','','S,N,C','1600');
insert into coimtabs values ('rce1','num_prove_fumi','NUMERO PROVE FUMI','numeric','2,0','S','','','1610');
insert into coimtabs values ('rce1','tiraggio','DEPRESSIONE CANALE DA FUMO','numeric','6,2','N','','','1620');
insert into coimtabs values ('rce1','portata_termica_effettiva','PORTATA TERMICA EFFETTIVA','numeric','6,2','S','','','1640');
insert into coimtabs values ('rce1','temp_fumi','TEMPERATURA FUMI ','numeric','6,2','S','','','1650');
insert into coimtabs values ('rce1','temp_ambi','TEMPERATURA AMBIENTE','numeric','6,2','S','','','1660');
insert into coimtabs values ('rce1','o2','O2','numeric','6,2','S','','','1670');
insert into coimtabs values ('rce1','co2','CO2 ','numeric','6,2','S','','','1680');
insert into coimtabs values ('rce1','bacharach','BACHARACH 1','numeric','6,2','N','','','1690');
insert into coimtabs values ('rce1','bacharach2','BACHARACH 2','numeric','6,2','N','','','1700');
insert into coimtabs values ('rce1','bacharach3','BACHARACH 3','numeric','6,2','N','','','1710');
insert into coimtabs values ('rce1','co_fumi_secchi_ppm','CO   PPM ','numeric','10,4','S','','','1720');
insert into coimtabs values ('rce1','co','CO CORETTO PPM ','numeric','10,4','S','','','1730');
insert into coimtabs values ('rce1','rend_combust','RENDIMENTO COMBUSTIONE','numeric','6,2','S','','','1740');
insert into coimtabs values ('rce1','rct_rend_min_legge','Rend.to combustione minimo di legge','numeric','9,2','S','','','1750');
insert into coimtabs values ('rce1','rct_modulo_termico','Modulo termico','varchar','8','N','','','1760');
insert into coimtabs values ('rce1','rispetta_indice_bacharach','RISPETTA INDICE DI BACHARACH','varchar','1','S','','S,N','1770');
insert into coimtabs values ('rce1','co_fumi_secchi','CO fumi secchi e senz''aria <=1.000 ppm','varchar','1','S','','S,N','1780');
insert into coimtabs values ('rce1','rend_magg_o_ugua_rend_min','Rendimento >= rendimento minimo','varchar','1','S','','S,N','1790');
insert into coimtabs values ('rce1','cod_strumento_01','Analizzatore','varchar','40','S','','','1800');
insert into coimtabs values ('rce1','cod_strumento_02','Deprimometro','varchar','40','S','','','1810');
insert into coimtabs values ('rce1','rct_check_list_1','Adozione di valvole termostatiche sui corpi scaldanti','varchar','1','S','','S,N','1820');
insert into coimtabs values ('rce1','rct_check_list_2','L''isolamento della rete di distribuzione nei locali non riscaldati','varchar','1','S','','S,N','1830');
insert into coimtabs values ('rce1','rct_check_list_3','Introduzione di un sistema di trattamento dell''acqua sanitaria e per riscaldamento ove assente','varchar','1','S','','S,N','1840');
insert into coimtabs values ('rce1','rct_check_list_4','Sostituzione di un sistema di regolazione on/off','varchar','1','S','','S,N','1850');
insert into coimtabs values ('rce1','osservazioni','OSSERVAZIONI','varchar','4000','N','','','1860');
insert into coimtabs values ('rce1','raccomandazioni','RACCOMANDAZIONI ','varchar','4000','N','','','1870');
insert into coimtabs values ('rce1','prescrizioni','PRESCRIZIONI','varchar','4000','N','','','1880');
insert into coimtabs values ('rce1','costo','COSTO DICHIARAZIONE / BOLLINO','numeric','6,2','S','','','1890');
insert into coimtabs values ('rce1','tipologia_costo','TIPO PAGAMENTO','varchar','2','S','','LM','1900');
insert into coimtabs values ('rce1','flag_pagato','SEGNO IDENTIFICATIVO PAGATO','varchar','2','S','','SI,NO,RI','1910');
insert into coimtabs values ('rce1','data_ultima_manu','DATA ULTIMA MANUTENZIONE','date','','S','','','1920');
insert into coimtabs values ('rce1','data_prox_manut','MANUTENZIONE ENTRO','date','','S','','','1930');
insert into coimtabs values ('rce1','consumo_annuo','CONSUMO ANNUO STAGIONE TERMICA ATTUALE','numeric','9,2','N','','','1940');
insert into coimtabs values ('rce1','portata_comb','PORTATA COMBUSTIBILE','numeric','6,2','S','','','1630');
insert into coimtabs values ('rce1','consumo_annuo2','CONSUMO ANNUO STAGIONE TERMICA PRECEDENTE','numeric','9,2','N','','','1950');
insert into coimtabs values ('rce1','stagione_risc','STAGIONE RISCALDAMENTO STAGIONE TERMICA ATTUALE','varchar','40','N','','','1960');
insert into coimtabs values ('rce1','stagione_risc2','STAGIONE RISCALDAMENTOSTAGIONE TERMICA PRECEDENTE','varchar','40','N','','','1970');
insert into coimtabs values ('rce1','combustibile','COMBUSTIBILE','varchar','4000','S','','','1140');
insert into coimtabs values ('rce1','marca','COSTRUTTORE','varchar','35','S','','','1110');
insert into coimtabs values ('rcee2','cod_impianto_est','CODICE IMPIANTO','varchar','20','S','','','1000');
insert into coimtabs values ('rcee2','targa','TARGA','varchar','20','S','','','1010');
insert into coimtabs values ('rcee2','data_controllo','DATA CONTROLLO','date','','S','','','1020');
insert into coimtabs values ('rcee2','flag_status','ESITO CONTROLLO','varchar','2','S','','P,N','1030');
insert into coimtabs values ('rcee2','gen_prog','PROGRESSIVO GENERATORE','numeric','8,0','S','1','','1040');
insert into coimtabs values ('rcee2','pod','POD','varchar','20','N','','','1060');
insert into coimtabs values ('rcee2','comune','COMUNE','varchar','40','S','','','1070');
insert into coimtabs values ('rcee2','toponimo','TOPONIMO','varchar','10','S','','','1080');
insert into coimtabs values ('rcee2','indirizzo','VIA','varchar','30','S','','','1090');
insert into coimtabs values ('rcee2','civico','CIVICO','varchar','5','N','','','1100');
insert into coimtabs values ('rcee2','marca','COSTRUTTORE','varchar','35','S','','','1110');
insert into coimtabs values ('rcee2','matricola','MATRICOLA','varchar','40','S','','','1120');
insert into coimtabs values ('rcee2','modello','MODELLO','varchar','40','S','','','1130');
insert into coimtabs values ('rcee2','cod_manutentore','CODICE MANUTENTORE','varchar','8','S','','','1150');
insert into coimtabs values ('rcee2','cognome_manu','COGNOME MANUTENTORE O RAGIONE SOCIALE','varchar','100','N','','','1170');
insert into coimtabs values ('rcee2','nome_manu','NOME MANUTENTORE','varchar','100','N','','','1180');
insert into coimtabs values ('rcee2','indirizzo_manu','INDIRIZZO MANUTENTORE','varchar','40','N','','','1190');
insert into coimtabs values ('rcee2','comune_manu','COMUNE MANUTENTORE','varchar','40','N','','','1200');
insert into coimtabs values ('rcee2','telefono_manu','TELEFONO MANUTENTORE','varchar','15','N','','','1210');
insert into coimtabs values ('rcee2','cap_manu','CAP MANUTENTORE','varchar','5','N','','','1220');
insert into coimtabs values ('rcee2','cod_fiscale_manu','IDENTIFICATIVO FISCALE MANUTENTORE','varchar','16','N','','','1230');
insert into coimtabs values ('rcee2','cod_opmanu_new','CODICE OPERATORE MANUTENTORE','varchar','16','S','','','1240');
insert into coimtabs values ('rcee2','flag_responsabile','FLAG RESPONSABILE','varchar','1','S','','T,A,O,P','1250');
insert into coimtabs values ('rcee2','nome_resp','NOME RESPONSABILE','varchar','100','S','','','1260');
insert into coimtabs values ('rcee2','cognome_resp','COGNOME RESPONSABILE','varchar','100','S','','','1270');
insert into coimtabs values ('rcee2','indirizzo_resp','INDIRIZZO RESPONSABILE','varchar','40','S','','','1280');
insert into coimtabs values ('rcee2','comune_resp','COMUNE RESPONSABILE','varchar','40','S','','','1290');
insert into coimtabs values ('rcee2','provincia_resp','PROVINCIA RESPONSABILE','varchar','4','S','','','1300');
insert into coimtabs values ('rcee2','natura_giuridica_resp','NATURA GIURIDICA RESPONSABILE','varchar','1','S','','G,F','1310');
insert into coimtabs values ('rcee2','cap_resp','CAP RESPONSABILE ','varchar','5','S','','','1320');
insert into coimtabs values ('rcee2','cod_fiscale_resp','IDENTIFICATIVO FISCALE RESPONSABILE','varchar','16','S','','','1330');
insert into coimtabs values ('rcee2','telefono_resp','TELEFONO RESPONSABILE ','varchar','15','N','','','1340');
insert into coimtabs values ('rcee2','ora_inizio','ORARIO INIZIO CONTROLLO','varchar','8','N','','','1350');
insert into coimtabs values ('rcee2','ora_fine','ORARIO FINE CONTROLLO ','varchar','8','N','','','1360');
insert into coimtabs values ('rcee2','num_autocert','NUMERO RAPPORTO DI CONTROLLO','varchar','20','N','','','1370');
insert into coimtabs values ('rcee2','conformita','CONFORMITA','varchar','1','S','','S,N,C','1380');
insert into coimtabs values ('rcee2','lib_impianto','LIBRETTO IMPIANTO','varchar','1','S','','S,N,C','1390');
insert into coimtabs values ('rcee2','lib_uso_man','LIBRETTO USO E MANUTENZIONE IMPIANTO - CALDAIA','varchar','1','S','','S,N,C','1400');
insert into coimtabs values ('rcee2','rct_lib_uso_man_comp','LIBRETTO compilato IN TUTTE LE SUE PARTI','varchar','1','S','','S,N,C','1410');
insert into coimtabs values ('rcee2','rct_dur_acqua','Durezza totale','numeric','9,2','N','','','1420');
insert into coimtabs values ('rcee2','rct_tratt_in_risc','Trattamento in riscaldamento','varchar','1','S','','R,A,F,D,C,K,J,W,T','1430');
insert into coimtabs values ('rcee2','idoneita_locale','IDONEITA'' LOCALE PER INSTALLAZIONE','varchar','1','S','','S,N,C','1440');
insert into coimtabs values ('rcee2','ap_vent_ostruz','APERTURE DI VENTILAZIONE/AREAZIONE LIBERE DA OSTRUZIONI','varchar','1','S','','S,N,C','1450');
insert into coimtabs values ('rcee2','fr_linee_ele','LINEE ELETTRICHE IDONEE','varchar','1','S','','S,N,C','1460');
insert into coimtabs values ('rcee2','fr_coibentazione','COIBENTAZIONE IDONEA','varchar','1','S','','S,N,C','1470');
insert into coimtabs values ('rcee2','fr_assenza_perdita_ref','ASSENZA DI PERDITE DI GAS REF.','varchar','1','S','','S,N,C','1490');
insert into coimtabs values ('rcee2','fr_leak_detector','PRESENZA APPARECCHIATURA AUTOMATICA RILEVAZIONE DIRETTA FUGHE REFRIGERANTE','varchar','1','S','','S,N,C','1500');
insert into coimtabs values ('rcee2','fr_pres_ril_fughe','PRESENZA APPARECCHIATURA AUTOMATICA RILEVAZIONE INDIRETTA FUGHE REFRIGERANTE','varchar','1','S','','S,N,C','1510');
insert into coimtabs values ('rcee2','fr_scambiatore_puliti','SCAMBIATORI PULITI E LIBERI DA INCROSTAZIONI','varchar','1','S','','S,N,C','1520');
insert into coimtabs values ('rcee2','cod_tprc','MOTIVO COMPILAZIONE RCEE','varchar','1','S','','1,2,3,4,5,6,7','1530');
insert into coimtabs values ('rcee2','cont_rend','CONTROLLO RENDIMENTO','varchar','1','N','','S,N','1540');
insert into coimtabs values ('rcee2','num_circuiti','N. CIRCUITO','varchar','1','S','','','1550');
insert into coimtabs values ('rcee2','osservazioni','OSSERVAZIONI','varchar','4000','N','','','1860');
insert into coimtabs values ('rcee2','raccomandazioni','RACCOMANDAZIONI ','varchar','4000','N','','','1870');
insert into coimtabs values ('rcee2','prescrizioni','PRESCRIZIONI','varchar','4000','N','','','1880');
insert into coimtabs values ('rcee2','costo','COSTO DICHIARAZIONE / BOLLINO','numeric','6,2','S','','','1890');
insert into coimtabs values ('rcee2','tipologia_costo','TIPO PAGAMENTO','varchar','2','S','','LM','1900');
insert into coimtabs values ('rcee2','flag_pagato','SEGNO IDENTIFICATIVO PAGATO','varchar','2','S','','SI,NO,RI','1910');
insert into coimtabs values ('rcee2','data_ultima_manu','DATA ULTIMA MANUTENZIONE','date','','S','','','1920');
insert into coimtabs values ('rcee2','data_prox_manut','MANUTENZIONE ENTRO','date','','S','','','1930');
insert into coimtabs values ('rcee2','consumo_annuo','CONSUMO ANNUO STAGIONE TERMICA ATTUALE','numeric','9,2','N','','','1940');
insert into coimtabs values ('rcee2','consumo_annuo2','CONSUMO ANNUO STAGIONE TERMICA PRECEDENTE','numeric','9,2','N','','','1950');
insert into coimtabs values ('rcee2','stagione_risc','STAGIONE RISCALDAMENTO STAGIONE TERMICA ATTUALE','varchar','40','N','','','1960');
insert into coimtabs values ('rcee2','stagione_risc2','STAGIONE RISCALDAMENTO STAGIONE TERMICA PRECEDENTE','varchar','40','N','','','1970');
insert into coimtabs values ('rcee2','pdr','PDR','varchar','20','N','','','1050');
insert into coimtabs values ('rcee2','fr_check_list_1','La sost. di gen. a regolaz. on/off, con altri di pari potenza a più gradini o a regolazione continua','varchar','1','S','','S,N','1820');
insert into coimtabs values ('rcee2','fr_check_list_2','La sost. dei sistemi di regolazione on/off, con sistemi programmabili su più livelli di temperatura','varchar','1','S','','S,N','1830');
insert into coimtabs values ('rcee2','fr_check_list_3','L''isolamento ddella rete di distribuzione acqua regfrigerata/calda nei locali non climatizzati','varchar','1','S','','S,N','1840');
insert into coimtabs values ('rcee2','fr_check_list_4','L''isolamento dei canali di distribuzione aria fredda/calda nei locali non climatizzati','varchar','1','S','','S,N','1850');

--fine campi caricamenti massivi


end;
