SET echo OFF feedback OFF head OFF linesize       4597
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN id_stampa                        FORMAT 099999999999.999999999999                HEADING 'X'
COLUMN descrizione                      FORMAT A50                                      HEADING 'X'
COLUMN testo                            FORMAT A4000                                    HEADING 'X'
COLUMN campo1_testo                     FORMAT A50                                      HEADING 'X'
COLUMN campo1                           FORMAT A50                                      HEADING 'X'
COLUMN campo2_testo                     FORMAT A50                                      HEADING 'X'
COLUMN campo2                           FORMAT A50                                      HEADING 'X'
COLUMN campo3_testo                     FORMAT A50                                      HEADING 'X'
COLUMN campo3                           FORMAT A50                                      HEADING 'X'
COLUMN campo4_testo                     FORMAT A50                                      HEADING 'X'
COLUMN campo4                           FORMAT A50                                      HEADING 'X'
COLUMN campo5_testo                     FORMAT A50                                      HEADING 'X'
COLUMN campo5                           FORMAT A50                                      HEADING 'X'
COLUMN var_testo                        FORMAT A1                                       HEADING 'X'
COLUMN allegato                         FORMAT A1                                       HEADING 'X'
COLUMN tipo_foglio                      FORMAT A1                                       HEADING 'X'
COLUMN orientamento                     FORMAT A1                                       HEADING 'X'
SELECT id_stampa
      ,descrizione
      ,testo
      ,campo1_testo
      ,campo1
      ,campo2_testo
      ,campo2
      ,campo3_testo
      ,campo3
      ,campo4_testo
      ,campo4
      ,campo5_testo
      ,campo5
      ,var_testo
      ,allegato
      ,tipo_foglio
      ,orientamento
  FROM coimstpm

spool file/\coimstpm.dat
/
spool OFF
