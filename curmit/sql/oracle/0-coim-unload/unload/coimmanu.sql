SET echo OFF feedback OFF head OFF linesize       4567
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_manutentore                  FORMAT A8                                       HEADING 'X'
COLUMN cognome                          FORMAT A40                                      HEADING 'X'
COLUMN nome                             FORMAT A40                                      HEADING 'X'
COLUMN indirizzo                        FORMAT A40                                      HEADING 'X'
COLUMN localita                         FORMAT A40                                      HEADING 'X'
COLUMN provincia                        FORMAT A4                                       HEADING 'X'
COLUMN cap                              FORMAT A5                                       HEADING 'X'
COLUMN comune                           FORMAT A40                                      HEADING 'X'
COLUMN cod_fiscale                      FORMAT A16                                      HEADING 'X'
COLUMN cod_piva                         FORMAT A16                                      HEADING 'X'
COLUMN telefono                         FORMAT A15                                      HEADING 'X'
COLUMN cellulare                        FORMAT A15                                      HEADING 'X'
COLUMN fax                              FORMAT A15                                      HEADING 'X'
COLUMN email                            FORMAT A35                                      HEADING 'X'
COLUMN reg_imprese                      FORMAT A15                                      HEADING 'X'
COLUMN localita_reg                     FORMAT A40                                      HEADING 'X'
COLUMN rea                              FORMAT A15                                      HEADING 'X'
COLUMN localita_rea                     FORMAT A40                                      HEADING 'X'
COLUMN capit_sociale                    FORMAT 099999999.99                             HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
COLUMN note                             FORMAT A4000                                    HEADING 'X'
COLUMN flag_convenzionato               FORMAT A1                                       HEADING 'X'
COLUMN prot_convenzione                 FORMAT A25                                      HEADING 'X'
COLUMN prot_convenzione_dt              FORMAT A10                                      HEADING 'X'
COLUMN flag_ruolo                       FORMAT A1                                       HEADING 'X'
COLUMN data_inizio                      FORMAT A10                                      HEADING 'X'
COLUMN data_fine                        FORMAT A10                                      HEADING 'X'
SELECT cod_manutentore
      ,cognome
      ,nome
      ,indirizzo
      ,localita
      ,provincia
      ,cap
      ,comune
      ,cod_fiscale
      ,cod_piva
      ,telefono
      ,cellulare
      ,fax
      ,email
      ,reg_imprese
      ,localita_reg
      ,rea
      ,localita_rea
      ,capit_sociale
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
      ,note
      ,flag_convenzionato
      ,prot_convenzione
      ,TO_CHAR(prot_convenzione_dt,'YYYY-MM-DD') prot_convenzione_dt
      ,flag_ruolo
      ,TO_CHAR(data_inizio,'YYYY-MM-DD') data_inizio
      ,TO_CHAR(data_fine,'YYYY-MM-DD') data_fine
  FROM coimmanu

spool file/\coimmanu.dat
/
spool OFF
