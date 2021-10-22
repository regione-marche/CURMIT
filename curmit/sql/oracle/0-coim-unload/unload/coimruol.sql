SET echo OFF feedback OFF head OFF linesize         71
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN id_ruolo                         FORMAT A20                                      HEADING 'X'
COLUMN descrizione                      FORMAT A50                                      HEADING 'X'
SELECT id_ruolo
      ,descrizione
  FROM coimruol

spool file/\coimruol.dat
/
spool OFF
