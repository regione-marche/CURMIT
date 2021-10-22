SET echo OFF feedback OFF head OFF linesize         59
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_listino                      FORMAT A8                                       HEADING 'X'
COLUMN descrizione                      FORMAT A50                                      HEADING 'X'
SELECT cod_listino
      ,descrizione
  FROM coimlist

spool file/\coimlist.dat
/
spool OFF
