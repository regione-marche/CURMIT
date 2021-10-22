
begin;

--Simone/Nicola 23/12/2014 Nuove colonne per Regolazione e Contabilizzazione

insert
  into coimfunz
     ( nome_funz
     , desc_funz
     , tipo_funz
     , dett_funz
     , azione
     )
values
     ( 'impianti'
     , 'Regolazione e contabilizzazione del calore'
     , 'secondario'
     , 'coimaimp-regol-contab-gest'
     , 'src/'
     );

create table coimfunz_backup_2015_01_12 as select * from coimfunz;

delete
  from coimfunz
 where nome_funz  = 'pdc'
   and dett_funz <> 'coimpdc-ins-gest';

update coimfunz 
   set tipo_funz = 'primario'
 where dett_funz = 'coimpdc-ins-gest'
   and nome_funz = 'pdc';

delete
  from coimfunz
 where nome_funz  = 'tele'
   and dett_funz <> 'coimtele-ins-gest';

update coimfunz
   set tipo_funz = 'primario'
 where dett_funz = 'coimtele-ins-gest';

\i ../coimtprg.sql

                            
insert into coimtprg (cod_tprg,descrizione,ordinamento) values ('A','TERMOSTATO DI ZONA O AMBIENTE con controllo ON-OFF',1);          
insert into coimtprg (cod_tprg,descrizione,ordinamento) values ('B','TERMOSTATO DI ZONA O AMBIENTE con controllo proporzionale',2);
insert into coimtprg (cod_tprg,descrizione,ordinamento) values ('C','CONTROLLO ENTALPICO su serranda aria esterna',3);
insert into coimtprg (cod_tprg,descrizione,ordinamento) values ('D','CONTROLLO PORTATA ARIA VARIABILE per aria canalizzata',4); 


alter table coimaimp add regol_on_off                     char(1);
alter table coimaimp add regol_curva_integrata            char(1);

alter table coimaimp add regol_curva_indipendente         char(1);
alter table coimaimp add regol_curva_ind_iniz_data_inst   date;
alter table coimaimp add regol_curva_ind_iniz_data_dism   date;
alter table coimaimp add regol_curva_ind_iniz_fabbricante varchar(30);
alter table coimaimp add regol_curva_ind_iniz_modello     varchar(30);
alter table coimaimp add regol_curva_ind_iniz_n_punti_reg varchar(20);
alter table coimaimp add regol_curva_ind_iniz_n_liv_temp  varchar(20);

alter table coimaimp add regol_valv_regolazione           char(1);
alter table coimaimp add regol_valv_ind_iniz_data_inst    date;
alter table coimaimp add regol_valv_ind_iniz_data_dism    date;
alter table coimaimp add regol_valv_ind_iniz_fabbricante  varchar(30);
alter table coimaimp add regol_valv_ind_iniz_modello      varchar(30);
alter table coimaimp add regol_valv_ind_iniz_n_vie        varchar(20);
alter table coimaimp add regol_valv_ind_iniz_servo_motore varchar(20);

alter table coimaimp add regol_sist_multigradino          char(1);
alter table coimaimp add regol_sist_inverter              char(1);
alter table coimaimp add regol_altri_flag                 char(1);
alter table coimaimp add regol_altri_desc_sistema         varchar(400);
alter table coimaimp add regol_cod_tprg                   char(1);
alter table coimaimp add regol_valv_termostatiche         char(1);
alter table coimaimp add regol_valv_due_vie               char(1);
alter table coimaimp add regol_valv_tre_vie               char(1);
alter table coimaimp add regol_valv_note                  varchar(400);

alter table coimaimp add regol_telettura                  char(1);
alter table coimaimp add regol_telegestione               char(1);
alter table coimaimp add regol_desc_sistema_iniz          varchar(400);
alter table coimaimp add regol_data_sost_sistema          date;
alter table coimaimp add regol_desc_sistema_sost          varchar(400);

alter table coimaimp add contab_si_no                     char(1);
alter table coimaimp add contab_tipo_contabiliz           char(1); -- R Riscladamento, F Raffrescamento, A acqua calda sanitaria
alter table coimaimp add contab_tipo_sistema              char(1); -- D Diretto, I Indiretto
alter table coimaimp add contab_desc_sistema_iniz         varchar(400);
alter table coimaimp add contab_data_sost_sistema         date;
alter table coimaimp add contab_desc_sistema_sost         varchar(400);


-- Sandro 05/01/2015
\i ../coimtipo_grup_termico.sql

insert into coimtipo_grup_termico (cod_grup_term, desc_grup_term, order_grup_term) values ('GTS', 'Gruppo termico singolo' , 1);
insert into coimtipo_grup_termico (cod_grup_term, desc_grup_term, order_grup_term) values ('GTM1', 'Gruppo termico modulare con n. 1 analisi fumi previste' , 2);
insert into coimtipo_grup_termico (cod_grup_term, desc_grup_term, order_grup_term) values ('GTM2', 'Gruppo termico modulare con n. 2 analisi fumi previste' , 3);
insert into coimtipo_grup_termico (cod_grup_term, desc_grup_term, order_grup_term) values ('GTM3', 'Gruppo termico modulare con n. 3 analisi fumi previste' , 4);
insert into coimtipo_grup_termico (cod_grup_term, desc_grup_term, order_grup_term) values ('TNR', 'Tubo / nastro radiante' , 5);
insert into coimtipo_grup_termico (cod_grup_term, desc_grup_term, order_grup_term) values ('GAC', 'Generatore d''aria calda' , 6);


alter table coimgend add cod_grup_term varchar(08);

end;
