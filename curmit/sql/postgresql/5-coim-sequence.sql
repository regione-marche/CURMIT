\o 5-coim-sequence.tmp
\t

\qecho '\\echo Questo script serve per far iniziare le sequence'
\qecho '\\echo dal primo valore libero delle relative tabelle'
\qecho ''

select 'create sequence coimaccu_aimp_s start '||
   (select to_char(coalesce(max(to_number(cod_accu_aimp, '99999990') ),0) + 1, '9999999999')from coimaccu_aimp)||';';
        
select 'create sequence coimaces_s start '||
   (select to_char(coalesce(max(to_number(cod_aces, '99999990') ),0) + 1, '9999999999')from coimaces)||';';

select 'create sequence coimacts_s start '||
   (select to_char(coalesce(max(to_number(cod_acts, '99999990') ),0) + 1, '9999999999')from coimacts)||';';

select 'create sequence coimadre_s start '||
   (select to_char(coalesce(max(to_number(cod_adre, '99999990') ),0) + 1, '9999999999')from coimadre)||';';

select 'create sequence coimaimp_s start '||
   (select to_char(coalesce(max(to_number(cod_impianto, '99999990') ),0) + 1, '9999999999') from   coimaimp where cod_impianto < 'A')||';';

select 'create sequence coimaimp_est_s start '||
   (select to_char(coalesce(max(to_number(cod_impianto_est, 99'99999990') ),0) + 1, '9999999999'9) from   coimaimp where cod_impianto_est < 'A')||';';

select 'create sequence coimarea_s start '||
   (select to_char(coalesce(max(to_number(cod_area, '99999990') ),0) + 1, '9999999999')from   coimarea)||';';

select 'create sequence coimboll_s start '||
   (select to_char(coalesce(max(to_number(cod_bollini, '99999990') ),0) + 1, '9999999999')from  coimboll)||';';

select 'create sequence coimbatc_s start '||
   (select to_char(coalesce(max(to_number(cod_batc, '99999990') ),0) + 1, '9999999999')from  coimbatc)||';';

select 'create sequence coimcimp_s start '||
   (select to_char(coalesce(max(to_number(cod_cimp, '99999990') ),0) + 1, '9999999999')from   coimcimp)||';';

select 'create sequence coimcinc_s start '||
   (select to_char(coalesce(max(to_number(cod_cinc, '99999990') ),0) + 1, '9999999999')from   coimcinc)||';';

select 'create sequence coimcirc_inte_aimp_s start '||
   (select to_char(coalesce(max(to_number(cod_circ_inte_aimp, '99999990') ),0) + 1, '9999999999')from   coimcirc_inte_aimp)||';';

select 'create sequence coimcitt_s start '||
   (select to_char(coalesce(max(to_number(cod_cittadino, '99999990') ),0) + 1, '9999999999')from   coimcitt where cod_cittadino < 'A')||';';

select 'create sequence coimcomu_s start '||
   (select to_char(coalesce(max(to_number(cod_comune, '99999990') ),0) + 1, '9999999999')from   coimcomu)||';';

select 'create sequence coimcont_s start '||
   (select to_char(coalesce(max(to_number(cod_contratto, '99999990') ),0) + 1, '9999999999')from   coimcont)||';';

select 'create sequence coimcost_s start '||
   (select to_char(coalesce(max(to_number(cod_cost, '99999990') ),0) + 1, '9999999999')from   coimcost where cod_cost < 'A')||';';

select 'create sequence coimdimp_s start '||
   (select to_char(coalesce(max(to_number(cod_dimp, '99999990') ),0) + 1, '9999999999')from   coimdimp)||';';

select 'create sequence coimdist_s start '||
   (select to_char(coalesce(max(to_number(cod_distr, '99999990') ),0) + 1, '9999999999')from   coimdist where cod_distr < 'A')||';';

select 'create sequence coimdocu_s start '||
   (select to_char(coalesce(max(to_number(cod_documento, '99999990') ),0) + 1, '9999999999')from coimdocu)||';';

select 'create sequence coimenve_s start '||
   (select to_char(coalesce(max(to_number(substr(cod_enve,3), '99999990') ),0) + 1, '9999999999')from coimenve where cod_enve like 'VE%')||';';

select 'create sequence coimfatt_s start '||
   (select to_char(coalesce(max(to_number(cod_fatt, '99999990') ),0) + 1, '9999999999')from   coimfatt)||';';

select 'create sequence coiminco_s start '||
   (select to_char(coalesce(max(to_number(cod_inco, '99999990') ),0) + 1, '9999999999')from   coiminco)||';';

select 'create sequence coimmanu_s start '||
   (select to_char(coalesce(max(to_number(substr(cod_manutentore,3), '99999990') ),0) + 1, '9999999999')from coimmanu where cod_manutentore like 'MA%')||';';

select 'create sequence coimmovi_s start '||
   (select to_char(coalesce(max(to_number(cod_movi, '99999990') ),0) + 1, '9999999999')from   coimmovi)||';';

select 'create sequence coimprog_s start '||
   (select to_char(coalesce(max(to_number(cod_progettista, '99999990') ),0) + 1, '9999999999')from   coimprog)||';';


select 'create sequence coimprov_s start '||
   (select to_char(coalesce(max(to_number(cod_provincia, '99999990') ),0) + 1, '9999999999')from   coimprov)||';';

select 'create sequence coimprvv_s start '||
   (select to_char(coalesce(max(to_number(cod_prvv, '99999990') ),0) + 1, '9999999999')from   coimprvv)||';';

select 'create sequence coimregi_s start '||
   (select to_char(coalesce(max(to_number(cod_regione, '99999990') ),0) + 1, '9999999999')from   coimregi)||';';

select 'create sequence coimrelg_s start '||
   (select to_char(coalesce(max(cod_relg),0) + 1, '9999999999')from   coimrelg)||';';

select 'create sequence coimsanz_s start '||
   (select to_char(coalesce(max(id_sanzione),0) + 1, '9999999999')from   coimsanz)||';';

select 'create sequence coimscam_calo_aimp_s start '||
   (select to_char(coalesce(max(to_number(cod_scam_calo_aimp, '99999990') ),0) + 1, '9999999999')from   coimscam_calo_aimp)||';';

select 'create sequence coimstpm_s start '||
   (select to_char(coalesce(max(id_stampa),0) + 1, '9999999999')from   coimstpm)||';';

select 'create sequence coimtodo_s start '||
   (select to_char(coalesce(max(to_number(cod_todo, '99999990') ),0) + 1, '9999999999')from   coimtodo)||';';

select 'create sequence coimtorr_evap_aimp_s start '||
   (select to_char(coalesce(max(to_number(cod_torr_evap_aimp, '99999990') ),0) + 1, '9999999999')from   coimtorr_evap_aimp)||';';

select 'create sequence coimtpdo_s start '||
   (select to_char(coalesce(max(to_number(cod_tpdo, '99999990') ),0) + 1, '9999999999')from   coimtpdo)||';';

select 'create sequence coimviae_s start '||
   (select to_char(coalesce(max(to_number(cod_via, '99999990') ),0) + 1, '9999999999')from   coimviae)||';';

select 'create sequence coimereg_s start '||
   (select to_char(coalesce(max(to_number(cod_ente, '99999990') ),0) + 1, '9999999999')from   coimereg)||';';

select 'create sequence coimraff_aimp_s start '||
   (select to_char(coalesce(max(to_number(cod_raff_aimp, '99999990') ),0) + 1, '9999999999')from   coimraff_aimp)||';';

select 'create sequence coimragr_s start '||
   (select to_char(coalesce(max(to_number(cod_raggruppamento, '99999990') ),0) + 1, '9999999999')from   coimragr)||';';

select 'create sequence coimboap_s start '||
   (select coalesce(max(cod_boap),0) + 1 from coimboap)||';';

select 'create sequence coimtpco_s start '||
   (select to_char(coalesce(max(to_number(cod_tpco          , '99999990') ),0) + 1, '9999999999') from coimtpco)||';';

select 'create sequence coimbpos_s start '||
   (select coalesce(max(cod_bpos),0) + 1 from coimbpos)||';';

select 'create sequence coimrfis_s start '||
   (select to_char(coalesce(max(to_number(cod_rfis          , '99999990') ),0) + 1, '9999999999') from coimrfis)||';';

select 'create sequence coimadre_s start '||
   (select to_char(coalesce(max(to_number(cod_adre          , '99999990') ),0) + 1, '9999999999') from coimadre)||';';

select 'create sequence coimcind_s start '||
   (select to_char(coalesce(max(to_number(cod_cind         , '99999990') ),0) + 1, '9999999999') from coimcind)||';';

select 'create sequence coimrfis_s start '||
   (select to_char(coalesce(max(to_number(cod_rfis         , '99999990') ),0) + 1, '9999999999') from coimrfis)||';';

select 'create sequence coimaimp_st_seq start '||
   (select coalesce(max(st_progressivo),0) + 1 from coimaimp_st)||';';

select 'create sequence coimgend_st_seq start '||
   (select coalesce(max(st_progressivo),0) + 1 from coimgend_st)||';';

select 'create sequence coim_as_resp_s start '||
   (select to_char(coalesce(max(to_number(cod_as_resp         , '99999990') ),0) + 1, '9999999999') from coim_as_resp)||';';

select 'create sequence coimstru_s start '||
   (select to_char(coalesce(max(to_number( cod_strumento         , '99999990') ),0) + 1, '9999999999') from coimstru_s)||';';

select 'create sequence coimcitt_st_seq start '||
   (select coalesce(max(st_progressivo),0) + 1 from coimcitt_st)||';';

select 'create sequence coiminco_st_seq start '||
   (select coalesce(max(st_progressivo),0) + 1 from coiminco_st)||';';

select 'create sequence coimdope_aimp_s start '||
   (select coalesce(max(cod_dope_aimp),0) + 1  from coimdope_aimp)||';';

select 'create sequence coimrecu_calo_aimp_s start '||
   (select coalesce(max(cod_recu_calo_aimp),0) + 1  from coimrecu_calo_aimp)||';';

select 'create sequence coimrecu_cond_aimp_s start '||
   (select coalesce(max(cod_recu_cond_aimp),0) + 1  from coimrecu_cond_aimp)||';';

select 'create sequence coimcamp_sola_aimp_s start '||
   (select coalesce(max(cod_camp_sola_aimp),0) + 1  from coimcamp_sola_aimp)||';';

select 'create sequence coimaltr_gend_aimp_s start '||
   (select coalesce(max(cod_altr_gend_aimp),0) + 1  from coimaltr_gend_aimp)||';';

select 'create sequence coimtrat_aria_aimp_s start '||
   (select coalesce(max(cod_trat_aria_aimp),0) + 1  from coimtrat_aria_aimp)||';';

select 'create sequence coimvent_aimp_s start '||
   (select coalesce(max(cod_vent_aimp),0) + 1  from coimvent_aimp)||';';

select 'create sequence coimvasi_espa_aimp_s start '||
   (select coalesce(max(cod_vasi_espa_aimp),0) + 1  from coimvasi_espa_aimp)||';';

select 'create sequence coimpomp_circ_aimp_s start '||
   (select coalesce(max(cod_pomp_circ_aimp),0) + 1  from coimpomp_circ_aimp)||';';

\t
\o

\i 5-coim-sequence.tmp
