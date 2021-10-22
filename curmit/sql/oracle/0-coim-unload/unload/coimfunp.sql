SET echo OFF feedback OFF head OFF linesize        111
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN nome_funz                        FORMAT A50                                      HEADING 'X'
COLUMN desc_funz                        FORMAT A60                                      HEADING 'X'
SELECT nome_funz
      ,desc_funz
  FROM coimfunp

spool file/\coimfunp.dat
/
spool OFF
