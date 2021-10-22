SET echo OFF feedback OFF head OFF linesize        177
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_tgen                         FORMAT A8                                       HEADING 'X'
COLUMN valid_mod_h                      FORMAT 09999999                                 HEADING 'X'
COLUMN gg_comunic_mod_h                 FORMAT 09999999                                 HEADING 'X'
COLUMN flag_ente                        FORMAT A1                                       HEADING 'X'
COLUMN cod_prov                         FORMAT A8                                       HEADING 'X'
COLUMN cod_comu                         FORMAT A8                                       HEADING 'X'
COLUMN flag_viario                      FORMAT A1                                       HEADING 'X'
COLUMN flag_mod_h_b                     FORMAT A1                                       HEADING 'X'
COLUMN valid_mod_h_b                    FORMAT 09999999                                 HEADING 'X'
COLUMN gg_comunic_mod_h_b               FORMAT 09999999                                 HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente_ult                       FORMAT A10                                      HEADING 'X'
COLUMN gg_conferma_inco                 FORMAT 09999999                                 HEADING 'X'
COLUMN gg_scad_pag_mh                   FORMAT 099                                      HEADING 'X'
COLUMN mesi_evidenza_mod                FORMAT 09                                       HEADING 'X'
COLUMN flag_agg_sogg                    FORMAT A1                                       HEADING 'X'
COLUMN flag_dt_scad                     FORMAT A1                                       HEADING 'X'
COLUMN flag_agg_da_verif                FORMAT A1                                       HEADING 'X'
COLUMN flag_cod_aimp_auto               FORMAT A1                                       HEADING 'X'
COLUMN flag_gg_modif_mh                 FORMAT 0999                                     HEADING 'X'
COLUMN flag_gg_modif_rv                 FORMAT 0999                                     HEADING 'X'
COLUMN gg_scad_pag_rv                   FORMAT 099                                      HEADING 'X'
COLUMN gg_adat_anom_oblig               FORMAT A1                                       HEADING 'X'
COLUMN gg_adat_anom_autom               FORMAT A1                                       HEADING 'X'
COLUMN popolaz_citt_tgen                FORMAT 0999999                                  HEADING 'X'
COLUMN popolaz_aimp_tgen                FORMAT 0999999                                  HEADING 'X'
COLUMN flag_aimp_citt_estr              FORMAT A1                                       HEADING 'X'
COLUMN flag_stat_estr_calc              FORMAT A1                                       HEADING 'X'
COLUMN flag_cod_via_auto                FORMAT A1                                       HEADING 'X'
SELECT cod_tgen
      ,valid_mod_h
      ,gg_comunic_mod_h
      ,flag_ente
      ,cod_prov
      ,cod_comu
      ,flag_viario
      ,flag_mod_h_b
      ,valid_mod_h_b
      ,gg_comunic_mod_h_b
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente_ult
      ,gg_conferma_inco
      ,gg_scad_pag_mh
      ,mesi_evidenza_mod
      ,flag_agg_sogg
      ,flag_dt_scad
      ,flag_agg_da_verif
      ,flag_cod_aimp_auto
      ,flag_gg_modif_mh
      ,flag_gg_modif_rv
      ,gg_scad_pag_rv
      ,gg_adat_anom_oblig
      ,gg_adat_anom_autom
      ,popolaz_citt_tgen
      ,popolaz_aimp_tgen
      ,flag_aimp_citt_estr
      ,flag_stat_estr_calc
      ,flag_cod_via_auto
  FROM coimtgen

spool file/\coimtgen.dat
/
spool OFF
