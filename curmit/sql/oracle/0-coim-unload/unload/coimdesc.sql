SET echo OFF feedback OFF head OFF linesize        547
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_desc                         FORMAT 09999999                                 HEADING 'X'
COLUMN nome_ente                        FORMAT A80                                      HEADING 'X'
COLUMN tipo_ufficio                     FORMAT A80                                      HEADING 'X'
COLUMN assessorato                      FORMAT A80                                      HEADING 'X'
COLUMN indirizzo                        FORMAT A80                                      HEADING 'X'
COLUMN telefono                         FORMAT A50                                      HEADING 'X'
COLUMN resp_uff                         FORMAT A40                                      HEADING 'X'
COLUMN uff_info                         FORMAT A80                                      HEADING 'X'
COLUMN dirigente                        FORMAT A40                                      HEADING 'X'
SELECT cod_desc
      ,nome_ente
      ,tipo_ufficio
      ,assessorato
      ,indirizzo
      ,telefono
      ,resp_uff
      ,uff_info
      ,dirigente
  FROM coimdesc

spool file/\coimdesc.dat
/
spool OFF
