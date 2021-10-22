SET echo OFF feedback OFF head OFF linesize         59
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_topo                         FORMAT A8                                       HEADING 'X'
COLUMN descr_topo                       FORMAT A50                                      HEADING 'X'
SELECT cod_topo
      ,descr_topo
  FROM coimtopo

spool file/\coimtopo.dat
/
spool OFF
