SET echo OFF feedback OFF head OFF linesize        334
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_impianto                     FORMAT A8                                       HEADING 'X'
COLUMN data_fin_valid                   FORMAT A10                                      HEADING 'X'
COLUMN cod_ubicazione                   FORMAT A8                                       HEADING 'X'
COLUMN localita                         FORMAT A40                                      HEADING 'X'
COLUMN cod_via                          FORMAT A8                                       HEADING 'X'
COLUMN toponimo                         FORMAT A20                                      HEADING 'X'
COLUMN indirizzo                        FORMAT A100                                     HEADING 'X'
COLUMN numero                           FORMAT A8                                       HEADING 'X'
COLUMN esponente                        FORMAT A3                                       HEADING 'X'
COLUMN scala                            FORMAT A5                                       HEADING 'X'
COLUMN piano                            FORMAT A5                                       HEADING 'X'
COLUMN interno                          FORMAT A3                                       HEADING 'X'
COLUMN cod_comune                       FORMAT A8                                       HEADING 'X'
COLUMN cod_provincia                    FORMAT A8                                       HEADING 'X'
COLUMN cap                              FORMAT A5                                       HEADING 'X'
COLUMN cod_catasto                      FORMAT A20                                      HEADING 'X'
COLUMN cod_tpdu                         FORMAT A8                                       HEADING 'X'
COLUMN cod_qua                          FORMAT A8                                       HEADING 'X'
COLUMN cod_urb                          FORMAT A8                                       HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
SELECT cod_impianto
      ,TO_CHAR(data_fin_valid,'YYYY-MM-DD') data_fin_valid
      ,cod_ubicazione
      ,localita
      ,cod_via
      ,toponimo
      ,indirizzo
      ,numero
      ,esponente
      ,scala
      ,piano
      ,interno
      ,cod_comune
      ,cod_provincia
      ,cap
      ,cod_catasto
      ,cod_tpdu
      ,cod_qua
      ,cod_urb
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
  FROM coimstub

spool file/\coimstub.dat
/
spool OFF
