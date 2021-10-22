SET echo OFF feedback OFF head OFF linesize         52
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_area                         FORMAT A8                                       HEADING 'X'
COLUMN id_utente                        FORMAT A10                                      HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
SELECT cod_area
      ,id_utente
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
  FROM coimutar

spool file/\coimutar.dat
/
spool OFF
