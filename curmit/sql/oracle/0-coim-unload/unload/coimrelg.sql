SET echo OFF feedback OFF head OFF linesize        404
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_relg                         FORMAT 09999999                                 HEADING 'X'
COLUMN data_rel                         FORMAT A10                                      HEADING 'X'
COLUMN ente_istat                       FORMAT A6                                       HEADING 'X'
COLUMN resp_proc                        FORMAT A80                                      HEADING 'X'
COLUMN nimp_tot_stim_ente               FORMAT 09999999                                 HEADING 'X'
COLUMN nimp_tot_aut_ente                FORMAT 09999999                                 HEADING 'X'
COLUMN nimp_tot_centr_ente              FORMAT 09999999                                 HEADING 'X'
COLUMN nimp_tot_telerisc_ente           FORMAT 09999999                                 HEADING 'X'
COLUMN conv_ass_categ                   FORMAT A10                                      HEADING 'X'
COLUMN conf_dgr7_7568                   FORMAT A1                                       HEADING 'X'
COLUMN npiva_ader_conv                  FORMAT 09999                                    HEADING 'X'
COLUMN npiva_ass_acc_reg                FORMAT 09999                                    HEADING 'X'
COLUMN delib_autodic                    FORMAT A1                                       HEADING 'X'
COLUMN rifer_datai                      FORMAT A10                                      HEADING 'X'
COLUMN rifer_dataf                      FORMAT A10                                      HEADING 'X'
COLUMN valid_datai                      FORMAT A10                                      HEADING 'X'
COLUMN valid_dataf                      FORMAT A10                                      HEADING 'X'
COLUMN ntot_autodic_perv                FORMAT 09999999                                 HEADING 'X'
COLUMN ntot_prescrizioni                FORMAT 09999999                                 HEADING 'X'
COLUMN n_ver_interni                    FORMAT 09999                                    HEADING 'X'
COLUMN n_ver_esterni                    FORMAT 09999                                    HEADING 'X'
COLUMN n_accert_enea                    FORMAT 09999                                    HEADING 'X'
COLUMN n_accert_altri                   FORMAT 09999                                    HEADING 'X'
COLUMN nome_file_gen                    FORMAT A50                                      HEADING 'X'
COLUMN nome_file_tec                    FORMAT A50                                      HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
SELECT cod_relg
      ,TO_CHAR(data_rel,'YYYY-MM-DD') data_rel
      ,ente_istat
      ,resp_proc
      ,nimp_tot_stim_ente
      ,nimp_tot_aut_ente
      ,nimp_tot_centr_ente
      ,nimp_tot_telerisc_ente
      ,TO_CHAR(conv_ass_categ,'YYYY-MM-DD') conv_ass_categ
      ,conf_dgr7_7568
      ,npiva_ader_conv
      ,npiva_ass_acc_reg
      ,delib_autodic
      ,TO_CHAR(rifer_datai,'YYYY-MM-DD') rifer_datai
      ,TO_CHAR(rifer_dataf,'YYYY-MM-DD') rifer_dataf
      ,TO_CHAR(valid_datai,'YYYY-MM-DD') valid_datai
      ,TO_CHAR(valid_dataf,'YYYY-MM-DD') valid_dataf
      ,ntot_autodic_perv
      ,ntot_prescrizioni
      ,n_ver_interni
      ,n_ver_esterni
      ,n_accert_enea
      ,n_accert_altri
      ,nome_file_gen
      ,nome_file_tec
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,utente
  FROM coimrelg

spool file/\coimrelg.dat
/
spool OFF
