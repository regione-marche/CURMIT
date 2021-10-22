SET echo OFF feedback OFF head OFF linesize        192
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_cted                         FORMAT A8                                       HEADING 'X'
COLUMN descr_cted                       FORMAT A150                                     HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
SELECT cod_cted
      ,descr_cted
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
  FROM coimcted

spool file/\coimcted.dat
/
spool OFF
