SET echo OFF feedback OFF head OFF linesize        185
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_cost                         FORMAT A8                                       HEADING 'X'
COLUMN descr_cost                       FORMAT A35                                      HEADING 'X'
COLUMN limite_inf                       FORMAT A35                                      HEADING 'X'
COLUMN limite_sup                       FORMAT A35                                      HEADING 'X'
COLUMN cert_cost                        FORMAT A35                                      HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
SELECT cod_cost
      ,descr_cost
      ,limite_inf
      ,limite_sup
      ,cert_cost
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
  FROM coimcost

spool file/\coimcost.dat
/
spool OFF
