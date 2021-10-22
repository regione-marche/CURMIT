SET echo OFF feedback OFF head OFF linesize        278
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN id_utente                        FORMAT A10                                      HEADING 'X'
COLUMN cognome                          FORMAT A40                                      HEADING 'X'
COLUMN nome                             FORMAT A40                                      HEADING 'X'
COLUMN password                         FORMAT A15                                      HEADING 'X'
COLUMN id_settore                       FORMAT A20                                      HEADING 'X'
COLUMN id_ruolo                         FORMAT A20                                      HEADING 'X'
COLUMN lingua                           FORMAT A2                                       HEADING 'X'
COLUMN e_mail                           FORMAT A100                                     HEADING 'X'
COLUMN rows_per_page                    FORMAT 09999999                                 HEADING 'X'
COLUMN data                             FORMAT A10                                      HEADING 'X'
COLUMN livello                          FORMAT 0                                        HEADING 'X'
SELECT id_utente
      ,cognome
      ,nome
      ,password
      ,id_settore
      ,id_ruolo
      ,lingua
      ,e_mail
      ,rows_per_page
      ,TO_CHAR(data,'YYYY-MM-DD') data
      ,livello
  FROM coimuten

spool file/\coimuten.dat
/
spool OFF
