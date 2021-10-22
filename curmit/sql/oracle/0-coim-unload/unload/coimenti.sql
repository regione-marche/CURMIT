SET echo OFF feedback OFF head OFF linesize        210
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_enre                         FORMAT A8                                       HEADING 'X'
COLUMN cod_ente                         FORMAT A8                                       HEADING 'X'
COLUMN denominazione                    FORMAT A40                                      HEADING 'X'
COLUMN indirizzo                        FORMAT A40                                      HEADING 'X'
COLUMN numero                           FORMAT A8                                       HEADING 'X'
COLUMN cap                              FORMAT A5                                       HEADING 'X'
COLUMN localita                         FORMAT A40                                      HEADING 'X'
COLUMN comune                           FORMAT A40                                      HEADING 'X'
COLUMN provincia                        FORMAT A4                                       HEADING 'X'
COLUMN cod_area                         FORMAT A8                                       HEADING 'X'
SELECT cod_enre
      ,cod_ente
      ,denominazione
      ,indirizzo
      ,numero
      ,cap
      ,localita
      ,comune
      ,provincia
      ,cod_area
  FROM coimenti

spool file/\coimenti.dat
/
spool OFF
