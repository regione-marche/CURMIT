SET echo OFF feedback OFF head OFF linesize       1335
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN nome_funz                        FORMAT A50                                      HEADING 'X'
COLUMN desc_funz                        FORMAT A100                                     HEADING 'X'
COLUMN tipo_funz                        FORMAT A20                                      HEADING 'X'
COLUMN dett_funz                        FORMAT A80                                      HEADING 'X'
COLUMN azione                           FORMAT A80                                      HEADING 'X'
COLUMN parametri                        FORMAT A1000                                    HEADING 'X'
SELECT nome_funz
      ,desc_funz
      ,tipo_funz
      ,dett_funz
      ,azione
      ,parametri
  FROM coimfunz

spool file/\coimfunz.dat
/
spool OFF
