SET echo OFF feedback OFF head OFF linesize         41
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN tipo_costo                       FORMAT 09999999                                 HEADING 'X'
COLUMN cod_potenza                      FORMAT A8                                       HEADING 'X'
COLUMN data_inizio                      FORMAT A10                                      HEADING 'X'
COLUMN importo                          FORMAT 0999999.99                               HEADING 'X'
SELECT tipo_costo
      ,cod_potenza
      ,TO_CHAR(data_inizio,'YYYY-MM-DD') data_inizio
      ,importo
  FROM coimtari

spool file/\coimtari.dat
/
spool OFF
