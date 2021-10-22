SET echo OFF feedback OFF head OFF linesize       4246
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_documento                    FORMAT A8                                       HEADING 'X'
COLUMN tipo_documento                   FORMAT A2                                       HEADING 'X'
COLUMN tipo_soggetto                    FORMAT A1                                       HEADING 'X'
COLUMN cod_soggetto                     FORMAT A8                                       HEADING 'X'
COLUMN cod_impianto                     FORMAT A8                                       HEADING 'X'
COLUMN data_stampa                      FORMAT A10                                      HEADING 'X'
COLUMN data_documento                   FORMAT A10                                      HEADING 'X'
COLUMN data_prot_01                     FORMAT A10                                      HEADING 'X'
COLUMN protocollo_01                    FORMAT A20                                      HEADING 'X'
COLUMN data_prot_02                     FORMAT A10                                      HEADING 'X'
COLUMN protocollo_02                    FORMAT A20                                      HEADING 'X'
COLUMN flag_notifica                    FORMAT A1                                       HEADING 'X'
COLUMN data_notifica                    FORMAT A10                                      HEADING 'X'
COLUMN tipo_contenuto                   FORMAT A30                                      HEADING 'X'
COLUMN descrizione                      FORMAT A50                                      HEADING 'X'
COLUMN note                             FORMAT A4000                                    HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
SELECT cod_documento
      ,tipo_documento
      ,tipo_soggetto
      ,cod_soggetto
      ,cod_impianto
      ,TO_CHAR(data_stampa,'YYYY-MM-DD') data_stampa
      ,TO_CHAR(data_documento,'YYYY-MM-DD') data_documento
      ,TO_CHAR(data_prot_01,'YYYY-MM-DD') data_prot_01
      ,protocollo_01
      ,TO_CHAR(data_prot_02,'YYYY-MM-DD') data_prot_02
      ,protocollo_02
      ,flag_notifica
      ,TO_CHAR(data_notifica,'YYYY-MM-DD') data_notifica
      ,tipo_contenuto
      ,descrizione
      ,note
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
  FROM coimdocu

spool file/\coimdocu.dat
/
spool OFF
