begin;

--Simone: i campi erano stati creati in modo sbagliato con l'upgrade upgrade-2.5.46-2.5.47.sql. vado a mettergli la tipologia corretta

alter table coimdimp alter column tel_temp_est                  type         decimal(18,2);
alter table coimdimp alter column tel_temp_mand_prim            type         decimal(18,2);
alter table coimdimp alter column tel_temp_rit_prim             type         decimal(18,2);
alter table coimdimp alter column tel_potenza_termica           type         decimal(18,2);
alter table coimdimp alter column tel_portata_fluido_prim       type         decimal(18,2);
alter table coimdimp alter column tel_temp_mand_sec             type         decimal(18,2);
alter table coimdimp alter column tel_temp_rit_sec              type         decimal(18,2);

alter table coimdimp_stn alter column tel_temp_est              type         decimal(18,2);
alter table coimdimp_stn alter column tel_temp_mand_prim        type         decimal(18,2);
alter table coimdimp_stn alter column tel_temp_rit_prim         type         decimal(18,2);
alter table coimdimp_stn alter column tel_potenza_termica       type         decimal(18,2);
alter table coimdimp_stn alter column tel_portata_fluido_prim   type         decimal(18,2);
alter table coimdimp_stn alter column tel_temp_mand_sec         type         decimal(18,2);
alter table coimdimp_stn alter column tel_temp_rit_sec          type         decimal(18,2);

end;
