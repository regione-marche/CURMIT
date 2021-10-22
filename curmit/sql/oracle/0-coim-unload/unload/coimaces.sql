SET echo OFF feedback OFF head OFF linesize       4451
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_aces                         FORMAT A8                                       HEADING 'X'
COLUMN cod_aces_est                     FORMAT A15                                      HEADING 'X'
COLUMN cod_acts                         FORMAT A8                                       HEADING 'X'
COLUMN cod_cittadino                    FORMAT A8                                       HEADING 'X'
COLUMN cod_impianto                     FORMAT A8                                       HEADING 'X'
COLUMN cod_combustibile                 FORMAT A8                                       HEADING 'X'
COLUMN natura_giuridica                 FORMAT A1                                       HEADING 'X'
COLUMN cognome                          FORMAT A40                                      HEADING 'X'
COLUMN nome                             FORMAT A40                                      HEADING 'X'
COLUMN indirizzo                        FORMAT A40                                      HEADING 'X'
COLUMN numero                           FORMAT A8                                       HEADING 'X'
COLUMN esponente                        FORMAT A3                                       HEADING 'X'
COLUMN scala                            FORMAT A5                                       HEADING 'X'
COLUMN piano                            FORMAT A5                                       HEADING 'X'
COLUMN interno                          FORMAT A3                                       HEADING 'X'
COLUMN cap                              FORMAT A5                                       HEADING 'X'
COLUMN localita                         FORMAT A40                                      HEADING 'X'
COLUMN comune                           FORMAT A40                                      HEADING 'X'
COLUMN provincia                        FORMAT A4                                       HEADING 'X'
COLUMN cod_fiscale_piva                 FORMAT A16                                      HEADING 'X'
COLUMN telefono                         FORMAT A15                                      HEADING 'X'
COLUMN data_nas                         FORMAT A10                                      HEADING 'X'
COLUMN comune_nas                       FORMAT A40                                      HEADING 'X'
COLUMN stato_01                         FORMAT A1                                       HEADING 'X'
COLUMN stato_02                         FORMAT A1                                       HEADING 'X'
COLUMN note                             FORMAT A4000                                    HEADING 'X'
COLUMN consumo_annuo                    FORMAT 0999999.99                               HEADING 'X'
COLUMN tariffa                          FORMAT A8                                       HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
SELECT cod_aces
      ,cod_aces_est
      ,cod_acts
      ,cod_cittadino
      ,cod_impianto
      ,cod_combustibile
      ,natura_giuridica
      ,cognome
      ,nome
      ,indirizzo
      ,numero
      ,esponente
      ,scala
      ,piano
      ,interno
      ,cap
      ,localita
      ,comune
      ,provincia
      ,cod_fiscale_piva
      ,telefono
      ,TO_CHAR(data_nas,'YYYY-MM-DD') data_nas
      ,comune_nas
      ,stato_01
      ,stato_02
      ,note
      ,consumo_annuo
      ,tariffa
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
  FROM coimaces

spool file/\coimaces.dat
/
spool OFF
