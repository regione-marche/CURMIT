SET echo OFF feedback OFF head OFF linesize         63
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_impianto                     FORMAT A8                                       HEADING 'X'
COLUMN ruolo                            FORMAT A1                                       HEADING 'X'
COLUMN data_fin_valid                   FORMAT A10                                      HEADING 'X'
COLUMN cod_soggetto                     FORMAT A8                                       HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
SELECT cod_impianto
      ,ruolo
      ,TO_CHAR(data_fin_valid,'YYYY-MM-DD') data_fin_valid
      ,cod_soggetto
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
  FROM coimrife

spool file/\coimrife.dat
/
spool OFF
