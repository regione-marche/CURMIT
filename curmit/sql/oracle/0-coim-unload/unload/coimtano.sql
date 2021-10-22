SET echo OFF feedback OFF head OFF linesize        435
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_tano                         FORMAT A8                                       HEADING 'X'
COLUMN descr_tano                       FORMAT A200                                     HEADING 'X'
COLUMN descr_breve                      FORMAT A80                                      HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
COLUMN flag_scatenante                  FORMAT A1                                       HEADING 'X'
COLUMN norma                            FORMAT A100                                     HEADING 'X'
COLUMN flag_stp_esito                   FORMAT A1                                       HEADING 'X'
COLUMN gg_adattamento                   FORMAT 099                                      HEADING 'X'
COLUMN flag_report                      FORMAT A1                                       HEADING 'X'
SELECT cod_tano
      ,descr_tano
      ,descr_breve
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
      ,flag_scatenante
      ,norma
      ,flag_stp_esito
      ,gg_adattamento
      ,flag_report
  FROM coimtano

spool file/\coimtano.dat
/
spool OFF
