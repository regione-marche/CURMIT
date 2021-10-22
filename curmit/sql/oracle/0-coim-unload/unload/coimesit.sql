SET echo OFF feedback OFF head OFF linesize        348
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_batc                         FORMAT 09999999                                 HEADING 'X'
COLUMN ctr                              FORMAT 0999                                     HEADING 'X'
COLUMN nom                              FORMAT A30                                      HEADING 'X'
COLUMN url                              FORMAT A100                                     HEADING 'X'
COLUMN pat                              FORMAT A200                                     HEADING 'X'
SELECT cod_batc
      ,ctr
      ,nom
      ,url
      ,pat
  FROM coimesit

spool file/\coimesit.dat
/
spool OFF
