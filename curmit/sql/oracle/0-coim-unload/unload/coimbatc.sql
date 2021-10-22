SET echo OFF feedback OFF head OFF linesize       5187
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_batc                         FORMAT 09999999                                 HEADING 'X'
COLUMN nom                              FORMAT A30                                      HEADING 'X'
COLUMN flg_stat                         FORMAT A1                                       HEADING 'X'
COLUMN num_comm                         FORMAT 09999999                                 HEADING 'X'
COLUMN dat_prev                         FORMAT A10                                      HEADING 'X'
COLUMN ora_prev                         FORMAT A8                                       HEADING 'X'
COLUMN dat_iniz                         FORMAT A10                                      HEADING 'X'
COLUMN ora_iniz                         FORMAT A8                                       HEADING 'X'
COLUMN dat_fine                         FORMAT A10                                      HEADING 'X'
COLUMN ora_fine                         FORMAT A8                                       HEADING 'X'
COLUMN cod_uten_sch                     FORMAT A10                                      HEADING 'X'
COLUMN cod_uten_int                     FORMAT A10                                      HEADING 'X'
COLUMN nom_prog                         FORMAT A50                                      HEADING 'X'
COLUMN par                              FORMAT A1000                                    HEADING 'X'
COLUMN note                             FORMAT A4000                                    HEADING 'X'
SELECT cod_batc
      ,nom
      ,flg_stat
      ,num_comm
      ,TO_CHAR(dat_prev,'YYYY-MM-DD') dat_prev
      ,ora_prev
      ,TO_CHAR(dat_iniz,'YYYY-MM-DD') dat_iniz
      ,ora_iniz
      ,TO_CHAR(dat_fine,'YYYY-MM-DD') dat_fine
      ,ora_fine
      ,cod_uten_sch
      ,cod_uten_int
      ,nom_prog
      ,par
      ,note
  FROM coimbatc

spool file/\coimbatc.dat
/
spool OFF
