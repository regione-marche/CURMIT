-- Gabriele 13/02/2017

begin;

alter table coimtgen add flag_gest_rcee_legna char (1) not null default 'F';

alter table coimdimp add lg_flag_dep_combust_solido char (1);
alter table coimdimp_stn add lg_flag_dep_combust_solido char (1);
 
alter table coimdimp add lg_flag_puliz_camino char(1);
alter table coimdimp_stn add lg_flag_puliz_camino char(1);

alter table coimdimp add lg_flag_sep_gen char(1);
alter table coimdimp_stn add lg_flag_sep_gen char(1);

alter table coimdimp add lg_flag_sollecit_termiche char(1);
alter table coimdimp_stn add lg_flag_sollecit_termiche char(1);

\i ../coimtplg.sql

INSERT INTO coimtplg VALUES ('1','cal','Caldaia (UNI EN303-5)');
INSERT INTO coimtplg VALUES ('2','stu','Stufa (UNI EN13240)');
INSERT INTO coimtplg VALUES ('3','sta','Stufa ad accumulo (UNI EN15250)');
INSERT INTO coimtplg VALUES ('4','sts','Stufa assemblata in opera (UNI EN15544)');
INSERT INTO coimtplg VALUES ('5','stp','Stufa a pellet (UNI EN14785)');
INSERT INTO coimtplg VALUES ('6','inc','Inserto caminetto (UNI EN13229)');
INSERT INTO coimtplg VALUES ('7','cac','Caminetto chiuso (UNI EN13229)');
INSERT INTO coimtplg VALUES ('8','tec','Termo cucina (UNI EN12815)');
INSERT INTO coimtplg VALUES ('9','alt','Altro');

alter table coimdimp add id_tplg integer;
alter table coimdimp_stn add id_tplg integer;

alter table coimdimp add note_tplg_altro varchar(4000);
alter table coimdimp_stn add note_tplg_altro varchar(4000);

alter table coimdimp add lg_condensazione char(1);
alter table coimdimp_stn add lg_condensazione char(1);

alter table coimdimp add lg_vaso_espa char(1);
alter table coimdimp_stn add lg_vaso_espa char(1);

alter table coimdimp add lg_marcatura_ce char(1);
alter table coimdimp_stn add lg_marcatura_ce char(1);

alter table coimdimp add lg_placca_cam char(1);
alter table coimdimp_stn add lg_placca_cam char(1);

alter table coimdimp add lg_caric_comb char(1);
alter table coimdimp_stn add lg_caric_comb char(1);

alter table coimdimp add lg_mod_evac_fumi char(1);
alter table coimdimp_stn add lg_mod_evac_fumi char(1);

alter table coimdimp add lg_aria_comburente char(1);
alter table coimdimp_stn add lg_aria_comburente char(1); 

--personalizzazione per Ancona (già lanciato manualmente su Ancona)
alter table coimboll add perc_iva numeric(5,2);

insert into coimfunz values ('dimp','Nuovi allegati','secondario','coimdimp-1b-gest','src/',null);
insert into coimfunz values ('dimp','Stampa allegati 1b','secondario','coimdimp-1b-layout','src/',null);

end;
