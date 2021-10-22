SET echo OFF feedback OFF head OFF linesize         43
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN nome_menu                        FORMAT A20                                      HEADING 'X'
COLUMN livello                          FORMAT A2                                       HEADING 'X'
COLUMN scelta_1                         FORMAT A2                                       HEADING 'X'
COLUMN scelta_2                         FORMAT A2                                       HEADING 'X'
COLUMN scelta_3                         FORMAT A2                                       HEADING 'X'
COLUMN scelta_4                         FORMAT A2                                       HEADING 'X'
COLUMN lvl                              FORMAT 09                                       HEADING 'X'
COLUMN seq                              FORMAT 09                                       HEADING 'X'
SELECT nome_menu
      ,livello
      ,scelta_1
      ,scelta_2
      ,scelta_3
      ,scelta_4
      ,lvl
      ,seq
  FROM coimmenu

spool file/\coimmenu.dat
/
spool OFF
