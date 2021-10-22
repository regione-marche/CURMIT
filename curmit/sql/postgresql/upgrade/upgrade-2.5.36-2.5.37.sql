-- Simone 27/06/2016

begin;


\i ../coimaltr_gend_aimp.sql
create sequence coimaltr_gend_aimp_s start 1;

\i ../coimcamp_sola_aimp.sql
create sequence coimcamp_sola_aimp_s start 1;

\i ../coimpomp_circ_aimp.sql
create sequence coimpomp_circ_aimp_s start 1;

\i ../coimrecu_cond_aimp.sql
create sequence coimrecu_cond_aimp_s start 1;

\i ../coimvasi_espa_aimp.sql
create sequence coimvasi_espa_aimp_s start 1;

--Aggiunti campi su coimaimp per gestire sezione 6.1 e 6.2 relativa ai sistemi di distribuzione     

alter table coimaimp add sistem_dist_tipo               char(1);
alter table coimaimp add sistem_dist_note_altro         varchar(400);
alter table coimaimp add sistem_dist_coibentazione_flag char(1);
alter table coimaimp add sistem_dist_note               varchar(400);


insert into coimfunz values ('impianti','Lista Recuperatori/condensatori'    ,'secondario','coimaimp-altre-schede-list'   ,'src','');
insert into coimfunz values ('impianti','Gestione Recuperatori/condensatori' ,'secondario','coimrecu-cond-aimp-gest'      ,'src','');
insert into coimfunz values ('impianti','Gestione Campi Solari'              ,'secondario','coimcamp-sola-aimp-gest'      ,'src','');
insert into coimfunz values ('impianti','Gestione Altri Generatori'          ,'secondario','coimaltr-gend-aimp-gest'      ,'src','');
insert into coimfunz values ('impianti','Gestione Sistemi di Distribuzione'  ,'secondario','coimaimp-sist-distribuz-gest' ,'src','');
insert into coimfunz values ('impianti','Gestione Vasi di Espansione'        ,'secondario','coimvasi-espa-aimp-gest'      ,'src','');
insert into coimfunz values ('impianti','Gestione Pompe di Circolazione'     ,'secondario','coimpomp-circ-aimp-gest'      ,'src','');

-- Sandro per personalizzazioni per iterprfi Agenzia Fiorentina per l'Energia.
alter table coimcimp add dur_acqua           numeric(10,2);
alter table coimcimp add locale_persone      char(1);
alter table coimcimp add ventilaz_areaz      char(1);
alter table coimcimp add miglioramento_energ varchar(100);
alter table coimcimp add manut_pres          char(1);
alter table coimcimp add deve_pagare         char(1);
alter table coimcimp add temp_esterna        numeric(6,2); 

end;
