SET echo OFF feedback OFF head OFF linesize        170
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_via                          FORMAT A8                                       HEADING 'X'
COLUMN cod_comune                       FORMAT A8                                       HEADING 'X'
COLUMN descrizione                      FORMAT A50                                      HEADING 'X'
COLUMN descr_topo                       FORMAT A50                                      HEADING 'X'
COLUMN descr_estesa                     FORMAT A50                                      HEADING 'X'
SELECT cod_via
      ,cod_comune
      ,descrizione
      ,descr_topo
      ,descr_estesa
  FROM coimviae

spool file/\coimviae.dat
/
spool OFF
