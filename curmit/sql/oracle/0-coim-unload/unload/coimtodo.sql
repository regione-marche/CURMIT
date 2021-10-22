SET echo OFF feedback OFF head OFF linesize       4104
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_todo                         FORMAT A8                                       HEADING 'X'
COLUMN cod_impianto                     FORMAT A8                                       HEADING 'X'
COLUMN tipologia                        FORMAT A8                                       HEADING 'X'
COLUMN note                             FORMAT A4000                                    HEADING 'X'
COLUMN cod_cimp_dimp                    FORMAT A8                                       HEADING 'X'
COLUMN flag_evasione                    FORMAT A1                                       HEADING 'X'
COLUMN data_evasione                    FORMAT A10                                      HEADING 'X'
COLUMN data_evento                      FORMAT A10                                      HEADING 'X'
COLUMN data_scadenza                    FORMAT A10                                      HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
SELECT cod_todo
      ,cod_impianto
      ,tipologia
      ,note
      ,cod_cimp_dimp
      ,flag_evasione
      ,TO_CHAR(data_evasione,'YYYY-MM-DD') data_evasione
      ,TO_CHAR(data_evento,'YYYY-MM-DD') data_evento
      ,TO_CHAR(data_scadenza,'YYYY-MM-DD') data_scadenza
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
  FROM coimtodo

spool file/\coimtodo.dat
/
spool OFF
