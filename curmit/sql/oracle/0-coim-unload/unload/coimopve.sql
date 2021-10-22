SET echo OFF feedback OFF head OFF linesize       4561
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_opve                         FORMAT A8                                       HEADING 'X'
COLUMN cod_enve                         FORMAT A8                                       HEADING 'X'
COLUMN cognome                          FORMAT A40                                      HEADING 'X'
COLUMN nome                             FORMAT A40                                      HEADING 'X'
COLUMN matricola                        FORMAT A10                                      HEADING 'X'
COLUMN stato                            FORMAT A1                                       HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
COLUMN telefono                         FORMAT A15                                      HEADING 'X'
COLUMN cellulare                        FORMAT A15                                      HEADING 'X'
COLUMN recapito                         FORMAT A100                                     HEADING 'X'
COLUMN codice_fiscale                   FORMAT A16                                      HEADING 'X'
COLUMN note                             FORMAT A4000                                    HEADING 'X'
COLUMN marca_strum                      FORMAT A50                                      HEADING 'X'
COLUMN modello_strum                    FORMAT A50                                      HEADING 'X'
COLUMN matr_strum                       FORMAT A50                                      HEADING 'X'
COLUMN dt_tar_strum                     FORMAT A10                                      HEADING 'X'
COLUMN strumento                        FORMAT A100                                     HEADING 'X'
SELECT cod_opve
      ,cod_enve
      ,cognome
      ,nome
      ,matricola
      ,stato
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
      ,telefono
      ,cellulare
      ,recapito
      ,codice_fiscale
      ,note
      ,marca_strum
      ,modello_strum
      ,matr_strum
      ,TO_CHAR(dt_tar_strum,'YYYY-MM-DD') dt_tar_strum
      ,strumento
  FROM coimopve

spool file/\coimopve.dat
/
spool OFF
