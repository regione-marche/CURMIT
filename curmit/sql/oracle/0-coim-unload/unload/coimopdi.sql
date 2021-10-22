SET echo OFF feedback OFF head OFF linesize         30
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_opve                         FORMAT A8                                       HEADING 'X'
COLUMN prog_disp                        FORMAT 09                                       HEADING 'X'
COLUMN ora_da                           FORMAT A8                                       HEADING 'X'
COLUMN ora_a                            FORMAT A8                                       HEADING 'X'
SELECT cod_opve
      ,prog_disp
      ,ora_da
      ,ora_a
  FROM coimopdi

spool file/\coimopdi.dat
/
spool OFF
