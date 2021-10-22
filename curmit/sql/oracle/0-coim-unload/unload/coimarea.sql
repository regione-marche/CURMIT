SET echo OFF feedback OFF head OFF linesize         96
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_area                         FORMAT A8                                       HEADING 'X'
COLUMN tipo_01                          FORMAT A1                                       HEADING 'X'
COLUMN tipo_02                          FORMAT A1                                       HEADING 'X'
COLUMN descrizione                      FORMAT A50                                      HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
SELECT cod_area
      ,tipo_01
      ,tipo_02
      ,descrizione
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
  FROM coimarea

spool file/\coimarea.dat
/
spool OFF
