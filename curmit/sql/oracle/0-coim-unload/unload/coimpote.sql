SET echo OFF feedback OFF head OFF linesize         95
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_potenza                      FORMAT A8                                       HEADING 'X'
COLUMN descr_potenza                    FORMAT A35                                      HEADING 'X'
COLUMN potenza_min                      FORMAT 0999.99                                  HEADING 'X'
COLUMN potenza_max                      FORMAT 0999.99                                  HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
SELECT cod_potenza
      ,descr_potenza
      ,potenza_min
      ,potenza_max
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
  FROM coimpote

spool file/\coimpote.dat
/
spool OFF
