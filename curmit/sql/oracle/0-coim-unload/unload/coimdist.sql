SET echo OFF feedback OFF head OFF linesize       4636
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_distr                        FORMAT A8                                       HEADING 'X'
COLUMN ragione_01                       FORMAT A40                                      HEADING 'X'
COLUMN ragione_02                       FORMAT A40                                      HEADING 'X'
COLUMN indirizzo                        FORMAT A40                                      HEADING 'X'
COLUMN numero                           FORMAT A8                                       HEADING 'X'
COLUMN cap                              FORMAT A5                                       HEADING 'X'
COLUMN localita                         FORMAT A40                                      HEADING 'X'
COLUMN comune                           FORMAT A40                                      HEADING 'X'
COLUMN provincia                        FORMAT A4                                       HEADING 'X'
COLUMN cod_fiscale                      FORMAT A16                                      HEADING 'X'
COLUMN cod_piva                         FORMAT A16                                      HEADING 'X'
COLUMN telefono                         FORMAT A15                                      HEADING 'X'
COLUMN cellulare                        FORMAT A15                                      HEADING 'X'
COLUMN fax                              FORMAT A15                                      HEADING 'X'
COLUMN email                            FORMAT A35                                      HEADING 'X'
COLUMN note                             FORMAT A4000                                    HEADING 'X'
COLUMN tracciato                        FORMAT A250                                     HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
SELECT cod_distr
      ,ragione_01
      ,ragione_02
      ,indirizzo
      ,numero
      ,cap
      ,localita
      ,comune
      ,provincia
      ,cod_fiscale
      ,cod_piva
      ,telefono
      ,cellulare
      ,fax
      ,email
      ,note
      ,tracciato
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
  FROM coimdist

spool file/\coimdist.dat
/
spool OFF
