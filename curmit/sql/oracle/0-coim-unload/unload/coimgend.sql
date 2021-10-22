SET echo OFF feedback OFF head OFF linesize       4525
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_impianto                     FORMAT A8                                       HEADING 'X'
COLUMN gen_prog                         FORMAT 09999999                                 HEADING 'X'
COLUMN descrizione                      FORMAT A100                                     HEADING 'X'
COLUMN matricola                        FORMAT A35                                      HEADING 'X'
COLUMN modello                          FORMAT A40                                      HEADING 'X'
COLUMN cod_cost                         FORMAT A8                                       HEADING 'X'
COLUMN matricola_bruc                   FORMAT A35                                      HEADING 'X'
COLUMN modello_bruc                     FORMAT A40                                      HEADING 'X'
COLUMN cod_cost_bruc                    FORMAT A8                                       HEADING 'X'
COLUMN tipo_foco                        FORMAT A1                                       HEADING 'X'
COLUMN mod_funz                         FORMAT A1                                       HEADING 'X'
COLUMN cod_utgi                         FORMAT A8                                       HEADING 'X'
COLUMN tipo_bruciatore                  FORMAT A1                                       HEADING 'X'
COLUMN tiraggio                         FORMAT A1                                       HEADING 'X'
COLUMN locale                           FORMAT A1                                       HEADING 'X'
COLUMN cod_emissione                    FORMAT A8                                       HEADING 'X'
COLUMN cod_combustibile                 FORMAT A8                                       HEADING 'X'
COLUMN data_installaz                   FORMAT A10                                      HEADING 'X'
COLUMN data_rottamaz                    FORMAT A10                                      HEADING 'X'
COLUMN pot_focolare_lib                 FORMAT 0999999.99                               HEADING 'X'
COLUMN pot_utile_lib                    FORMAT 0999999.99                               HEADING 'X'
COLUMN pot_focolare_nom                 FORMAT 0999999.99                               HEADING 'X'
COLUMN pot_utile_nom                    FORMAT 0999999.99                               HEADING 'X'
COLUMN flag_attivo                      FORMAT A1                                       HEADING 'X'
COLUMN note                             FORMAT A4000                                    HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
COLUMN gen_prog_est                     FORMAT 09999999                                 HEADING 'X'
COLUMN data_costruz_gen                 FORMAT A10                                      HEADING 'X'
COLUMN data_costruz_bruc                FORMAT A10                                      HEADING 'X'
COLUMN data_installaz_bruc              FORMAT A10                                      HEADING 'X'
COLUMN data_rottamaz_bruc               FORMAT A10                                      HEADING 'X'
COLUMN marc_effic_energ                 FORMAT A10                                      HEADING 'X'
COLUMN campo_funz_min                   FORMAT 0999999.99                               HEADING 'X'
COLUMN campo_funz_max                   FORMAT 0999999.99                               HEADING 'X'
COLUMN dpr_660_96                       FORMAT A1                                       HEADING 'X'
SELECT cod_impianto
      ,gen_prog
      ,descrizione
      ,matricola
      ,modello
      ,cod_cost
      ,matricola_bruc
      ,modello_bruc
      ,cod_cost_bruc
      ,tipo_foco
      ,mod_funz
      ,cod_utgi
      ,tipo_bruciatore
      ,tiraggio
      ,locale
      ,cod_emissione
      ,cod_combustibile
      ,TO_CHAR(data_installaz,'YYYY-MM-DD') data_installaz
      ,TO_CHAR(data_rottamaz,'YYYY-MM-DD') data_rottamaz
      ,pot_focolare_lib
      ,pot_utile_lib
      ,pot_focolare_nom
      ,pot_utile_nom
      ,flag_attivo
      ,note
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
      ,gen_prog_est
      ,TO_CHAR(data_costruz_gen,'YYYY-MM-DD') data_costruz_gen
      ,TO_CHAR(data_costruz_bruc,'YYYY-MM-DD') data_costruz_bruc
      ,TO_CHAR(data_installaz_bruc,'YYYY-MM-DD') data_installaz_bruc
      ,TO_CHAR(data_rottamaz_bruc,'YYYY-MM-DD') data_rottamaz_bruc
      ,marc_effic_energ
      ,campo_funz_min
      ,campo_funz_max
      ,dpr_660_96
  FROM coimgend

spool file/\coimgend.dat
/
spool OFF
