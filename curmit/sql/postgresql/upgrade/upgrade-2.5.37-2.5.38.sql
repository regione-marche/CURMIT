-- Simone 30/08/2016

begin;

---Aggiunti campi su coimaimp per gestire sezione 7 relativa ai sistemi di emissione
alter table coimaimp add  sistem_emis_tipo        char(1); -- R Radiatori -- T Termoconvettori -- V Ventilconvettori -- P Pannelli Radianti --B Bocchette -- S Strisce Radianti -- F Travi Fredde -- A Altro
alter table coimaimp add  sistem_emis_note_altro  varchar(400);

\i ../coimaccu_aimp.sql 
create sequence coimaccu_aimp_s start 1;

\i ../coimtorr_evap_aimp.sql
create sequence coimtorr_evap_aimp_s start 1;

\i ../coimraff_aimp.sql
create sequence coimraff_aimp_s start 1;

\i ../coimscam_calo_aimp.sql
create sequence coimscam_calo_aimp_s start 1;

\i ../coimcirc_inte_aimp.sql
create sequence coimcirc_inte_aimp_s start 1;

insert into coimfunz values ('impianti','Gestione Sistemi di Emissione'  ,'secondario','coimaimp-sist-emissione-gest' ,'src','');
insert into coimfunz values ('impianti','Gestione Accumuli'  ,'secondario','coimaccu-aimp-gest' ,'src','');
insert into coimfunz values ('impianti','Gestione Torri Evaporative'  ,'secondario','coimtorr-evap-aimp-gest' ,'src','');
insert into coimfunz values ('impianti','Gestione Raffreddatori di Liquido'  ,'secondario','coimraff-aimp-gest' ,'src','');
insert into coimfunz values ('impianti','Gestione Scambiatori di Calore Intermedi'  ,'secondario','coimscam-calo-aimp-gest' ,'src','');
insert into coimfunz values ('impianti','Gestione Circuiti Interrati a Condensazione/Espansione Diretta'  ,'secondario','coimcirc-inte-aimp-gest' ,'src','');

end;
