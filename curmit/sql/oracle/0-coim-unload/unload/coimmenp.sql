SET echo OFF feedback OFF head OFF linesize         81
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN nome_menu                        FORMAT A20                                      HEADING 'X'
COLUMN descrizione                      FORMAT A60                                      HEADING 'X'
SELECT nome_menu
      ,descrizione
  FROM coimmenp

spool file/\coimmenp.dat
/
spool OFF
