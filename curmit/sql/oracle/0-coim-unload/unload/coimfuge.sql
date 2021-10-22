SET echo OFF feedback OFF head OFF linesize         85
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_fuge                         FORMAT A1                                       HEADING 'X'
COLUMN descr_fuge                       FORMAT A50                                      HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
SELECT cod_fuge
      ,descr_fuge
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
  FROM coimfuge

spool file/\coimfuge.dat
/
spool OFF
