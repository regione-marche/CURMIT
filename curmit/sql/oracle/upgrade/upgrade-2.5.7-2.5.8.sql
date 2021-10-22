-- Sandro 11/04/2014

begin;

-- Aggiunte nuove colonne alla tabella coimdimp per gestione RCEE di tipo 2 (gruppi frigo)
alter table  coimdimp add rct_dur_acqua numeric(10,2);
alter table  coimdimp add rct_tratt_in_risc varchar(2);
alter table  coimdimp add rct_tratt_in_acs varchar(2);
alter table  coimdimp add rct_install_interna varchar(1);
alter table  coimdimp add rct_install_esterna varchar(1);
alter table  coimdimp add rct_canale_fumo_idoneo varchar(1);
alter table  coimdimp add rct_sistema_reg_temp_amb varchar(1);
alter table  coimdimp add rct_assenza_per_comb varchar(1);
alter table  coimdimp add rct_idonea_tenuta varchar(1);
alter table  coimdimp add rct_scambiatore_lato_fumi varchar(1);
alter table  coimdimp add rct_riflussi_comb varchar(1);
alter table  coimdimp add rct_uni_10389 varchar(1);
alter table  coimdimp add rct_rend_min_legge numeric(10,2);
alter table  coimdimp add rct_check_list_1 varchar(1);
alter table  coimdimp add rct_check_list_2 varchar(1);
alter table  coimdimp add rct_check_list_3 varchar(1);
alter table  coimdimp add rct_check_list_4 varchar(1);
alter table  coimdimp add rct_gruppo_termico varchar(2);
alter table  coimdimp add rct_valv_sicurezza varchar(1);

alter table  coimdimp add fr_linee_ele varchar(1); --1
alter table  coimdimp add fr_coibentazione varchar(1); --2
alter table  coimdimp add fr_assorb_recupero varchar(1); --3
alter table  coimdimp add fr_assorb_fiamma varchar(1); --4
alter table  coimdimp add fr_ciclo_compressione varchar(1); --5
alter table  coimdimp add fr_assenza_perdita_ref varchar(1); --6
alter table  coimdimp add fr_leak_detector varchar(1); --7
alter table  coimdimp add fr_pres_ril_fughe varchar(1); --8
alter table  coimdimp add fr_scambiatore_puliti varchar(1); --9
alter table  coimdimp add fr_prova_modalita varchar(1); --10
alter table  coimdimp add fr_surrisc numeric(10,2); --11
alter table  coimdimp add fr_sottoraff numeric(10,2); --12
alter table  coimdimp add fr_tcondens numeric(10,2); --13
alter table  coimdimp add fr_tevapor numeric(10,2); --14
alter table  coimdimp add fr_t_ing_lato_est numeric(10,2); --15
alter table  coimdimp add fr_t_usc_lato_est numeric(10,2); --16
alter table  coimdimp add fr_t_ing_lato_ute numeric(10,2); --17
alter table  coimdimp add fr_t_usc_lato_ute numeric(10,2); --18
alter table  coimdimp add fr_nr_circuito numeric(10,0); --19
alter table  coimdimp add fr_check_list_1 varchar(1); --20
alter table  coimdimp add fr_check_list_2 varchar(1); --21
alter table  coimdimp add fr_check_list_3 varchar(1);  --22
alter table  coimdimp add fr_check_list_4 varchar(1); --23 

alter table  coimdimp add rct_lib_uso_man_comp varchar(1);

end;
