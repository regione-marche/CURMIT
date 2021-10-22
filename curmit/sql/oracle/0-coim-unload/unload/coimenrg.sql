SET echo OFF feedback OFF head OFF linesize         17
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_rgen                         FORMAT A8                                       HEADING 'X'
COLUMN cod_enre                         FORMAT A8                                       HEADING 'X'
SELECT cod_rgen
      ,cod_enre
  FROM coimenrg

spool file/\coimenrg.dat
/
spool OFF
