
begin;

--Simone 02/07/2015 Nuove colonne per nuovo rapporto di ispezione (fatto per Fasano ma serve).
alter table coimcimp add inte_migliorare_re          char(1);

alter table coimcimp add rapp_cont_inviato           char(1);
alter table coimcimp add rapp_cont_bollino           char(1);
alter table coimcimp add rapp_cont_data_compilazione date;

--Nicola 04/09/2015 Nuove tabelle per dichiarazione frequenza ed elenco operazioni di manut.
--                  per la provincia di Pesaro e Urbino

\i ../coimdope_aimp.sql

create sequence coimdope_aimp_s start 1;

\i ../coimdope_gend.sql

alter table coimdimp add dam_manutenzione char(1); -- Devo chiedere a Sandro perche' non si capisce a quale campo si riferisce
alter table coimdimp add dam_note         char(1); -- Devo chiedere a Sandro perche' non si capisce a quale campo si riferisce

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
     , 'Gestione dich. di freq. ed elenco oper. di contr. e manut.'
     , 'secondario'
     , 'coimdope-aimp-gest'
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
     , 'Stampa dich. di freq. ed elenco oper. di contr. e manut.'
     , 'secondario'
     , 'coimdope-aimp-layout'
     , 'src/'
     );

end;
