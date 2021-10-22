SET echo OFF feedback OFF head OFF linesize         70
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_tppr                         FORMAT A1                                       HEADING 'X'
COLUMN descr_tppr                       FORMAT A35                                      HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
SELECT cod_tppr
      ,descr_tppr
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
  FROM coimtppr

spool file/\coimtppr.dat
/
spool OFF
