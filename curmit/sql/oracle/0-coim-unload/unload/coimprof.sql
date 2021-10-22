SET echo OFF feedback OFF head OFF linesize         62
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN nome_menu                        FORMAT A20                                      HEADING 'X'
COLUMN settore                          FORMAT A20                                      HEADING 'X'
COLUMN ruolo                            FORMAT A20                                      HEADING 'X'
SELECT nome_menu
      ,settore
      ,ruolo
  FROM coimprof

spool file/\coimprof.dat
/
spool OFF
