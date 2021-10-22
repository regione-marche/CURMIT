SET echo OFF feedback OFF head OFF linesize       4074
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_prvv                         FORMAT A8                                       HEADING 'X'
COLUMN causale                          FORMAT A2                                       HEADING 'X'
COLUMN cod_impianto                     FORMAT A8                                       HEADING 'X'
COLUMN data_provv                       FORMAT A10                                      HEADING 'X'
COLUMN cod_documento                    FORMAT A8                                       HEADING 'X'
COLUMN nota                             FORMAT A4000                                    HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
SELECT cod_prvv
      ,causale
      ,cod_impianto
      ,TO_CHAR(data_provv,'YYYY-MM-DD') data_provv
      ,cod_documento
      ,nota
      ,utente
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
  FROM coimprvv

spool file/\coimprvv.dat
/
spool OFF
