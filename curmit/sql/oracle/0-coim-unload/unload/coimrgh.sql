SET echo OFF feedback OFF head OFF linesize          4
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN rgh_cde                          FORMAT 099                                      HEADING 'X'
SELECT rgh_cde
  FROM coimrgh

spool file/\coimrgh.dat
/
spool OFF
