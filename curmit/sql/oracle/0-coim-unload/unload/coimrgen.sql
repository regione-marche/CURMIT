SET echo OFF feedback OFF head OFF linesize        109
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_rgen                         FORMAT A8                                       HEADING 'X'
COLUMN descrizione                      FORMAT A100                                     HEADING 'X'
SELECT cod_rgen
      ,descrizione
  FROM coimrgen

spool file/\coimrgen.dat
/
spool OFF
