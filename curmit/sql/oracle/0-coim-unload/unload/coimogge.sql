SET echo OFF feedback OFF head OFF linesize        187
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN livello                          FORMAT A2                                       HEADING 'X'
COLUMN scelta_1                         FORMAT A2                                       HEADING 'X'
COLUMN scelta_2                         FORMAT A2                                       HEADING 'X'
COLUMN scelta_3                         FORMAT A2                                       HEADING 'X'
COLUMN scelta_4                         FORMAT A2                                       HEADING 'X'
COLUMN tipo                             FORMAT A20                                      HEADING 'X'
COLUMN descrizione                      FORMAT A100                                     HEADING 'X'
COLUMN nome_funz                        FORMAT A50                                      HEADING 'X'
SELECT livello
      ,scelta_1
      ,scelta_2
      ,scelta_3
      ,scelta_4
      ,tipo
      ,descrizione
      ,nome_funz
  FROM coimogge

spool file/\coimogge.dat
/
spool OFF
