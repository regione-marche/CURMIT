SET echo OFF feedback OFF head OFF linesize       4172
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_acts                         FORMAT A8                                       HEADING 'X'
COLUMN cod_distr                        FORMAT A8                                       HEADING 'X'
COLUMN data_caric                       FORMAT A10                                      HEADING 'X'
COLUMN cod_documento                    FORMAT A8                                       HEADING 'X'
COLUMN caricati                         FORMAT 099999                                   HEADING 'X'
COLUMN scartati                         FORMAT 099999                                   HEADING 'X'
COLUMN invariati                        FORMAT 099999                                   HEADING 'X'
COLUMN da_analizzare                    FORMAT 099999                                   HEADING 'X'
COLUMN importati_aimp                   FORMAT 099999                                   HEADING 'X'
COLUMN chiusi_forzat                    FORMAT 099999                                   HEADING 'X'
COLUMN stato                            FORMAT A1                                       HEADING 'X'
COLUMN percorso_file                    FORMAT A50                                      HEADING 'X'
COLUMN note                             FORMAT A4000                                    HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
SELECT cod_acts
      ,cod_distr
      ,TO_CHAR(data_caric,'YYYY-MM-DD') data_caric
      ,cod_documento
      ,caricati
      ,scartati
      ,invariati
      ,da_analizzare
      ,importati_aimp
      ,chiusi_forzat
      ,stato
      ,percorso_file
      ,note
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
  FROM coimacts

spool file/\coimacts.dat
/
spool OFF
