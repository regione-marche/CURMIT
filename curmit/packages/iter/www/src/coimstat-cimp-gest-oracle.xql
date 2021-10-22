<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_stat">
       <querytext>
select  $des_terr as h_des_terr
     , c.descr_potenza
     , f.descr_comb 
     , count(decode (stato_coiben, 'B', 1, null)) as stato_coiben_b
     , count(decode (stato_coiben, 'M', 1, null)) as stato_coiben_m
     , count(decode (stato_coiben, 'S', 1, null)) as stato_coiben_s
     , count(decode (stato_coiben, null, 1, null)) as stato_coiben_n
     , count(decode (stato_canna_fum, 'B', 1, null)) as stato_canna_fum_b
     , count(decode (stato_canna_fum, 'M', 1, null)) as stato_canna_fum_m
     , count(decode (stato_canna_fum, 'S', 1, null)) as stato_canna_fum_s 
     , count(decode (stato_canna_fum, null, 1, null)) as stato_canna_fum_n

     , count(decode (verifica_dispo, 'P', 1, null)) as verifica_dispo_p
     , count(decode (verifica_dispo, 'N', 1, null)) as verifica_dispo_n
     , count(decode (verifica_dispo, null, 1, null)) as verifica_dispo_no
     , count(decode (verifica_areaz, 'P', 1, null)) as verifica_areaz_p
     , count(decode (verifica_areaz, 'N', 1, null)) as verifica_areaz_n
     , count(decode (verifica_areaz, null, 1, null)) as verifica_areaz_no
     , count(decode (taratura_dispos, 'E', 1, null)) as taratura_dispos_si
     , count(decode (taratura_dispos, 'N', 1, null)) as taratura_dispos_no
     , count(decode (taratura_dispos, null, 1, null)) as taratura_dispos_n
     , iter_edit.num(min(a.temp_fumi_md),2) as min_temp_fumi
     , iter_edit.num(max(a.temp_fumi_md),2) as max_temp_fumi
     , iter_edit.num(avg(decode (a.temp_fumi_md,0 
                             , null 
                             , a.temp_fumi_md)
                    ),2) as med_temp_fumi
     , count(decode (a.temp_fumi_md,0, null, a.temp_fumi_md)) as campioni_temp_fumi
     , iter_edit.num(min(a.t_aria_comb_md),2) as min_t_aria_comb
     , iter_edit.num(max(a.t_aria_comb_md),2) as max_t_aria_comb
     , iter_edit.num(avg(decode (a.t_aria_comb_md,0 
                             , null 
                             , a.t_aria_comb_md)
                    ),2) as med_t_aria_comb
     , count(decode (a.t_aria_comb_md,0, null, a.t_aria_comb_md)) as campioni_t_aria_comb
     , iter_edit.num(min(a.temp_mant_md),2) as min_temp_mant
     , iter_edit.num(max(a.temp_mant_md),2) as max_temp_mant
     , iter_edit.num(avg(decode (a.temp_mant_md,0 
                             , null 
                             , a.temp_mant_md)
                    ),2) as med_temp_mant
     , count(decode (a.temp_mant_md,0, null, a.temp_mant_md)) as campioni_temp_mant
     , iter_edit.num(min(a.temp_h2o_out_md),2) as min_temp_h2o_out
     , iter_edit.num(max(a.temp_h2o_out_md),2) as max_temp_h2o_out
     , iter_edit.num(avg(decode (a.temp_h2o_out_md,0 
                             , null 
                             , a.temp_h2o_out_md)
                    ),2) as med_temp_h2o_out
     , count(decode (a.temp_h2o_out_md,0, null, a.temp_h2o_out_md)) as campioni_temp_h2o_out
     , iter_edit.num(min(a.co2_md),2) as min_co2
     , iter_edit.num(max(a.co2_md),2) as max_co2
     , iter_edit.num(avg(decode (a.co2_md,0 
                             , null 
                             , a.co2_md)
                    ),2) as med_co2
     , count(decode (a.co2_md,0, null, a.co2_md)) as campioni_co2
     , iter_edit.num(min(a.o2_md),2) as min_o2
     , iter_edit.num(max(a.o2_md),2) as max_o2
     , iter_edit.num(avg(decode (a.o2_md,0 
                             , null 
                             , a.o2_md)
                    ),2) as med_o2
     , count(decode (a.o2_md,0, null, a.o2_md)) as campioni_o2
     , iter_edit.num(min(a.co_md),2) as min_co
     , iter_edit.num(max(a.co_md),2) as max_co
     , iter_edit.num(avg(decode (a.co_md,0 
                             , null 
                             , a.co_md)
                    ),2) as med_co
     , count(decode (a.co_md,0, null, a.co_md)) as campioni_co
     , iter_edit.num(min(a.indic_fumosita_md),2) as min_indic_fumosita
     , iter_edit.num(max(a.indic_fumosita_md),2) as max_indic_fumosita
     , iter_edit.num(avg(decode (a.indic_fumosita_md,0 
                             , null 
                             , a.indic_fumosita_md)
                    ),2) as med_indic_fumosita
     , count(decode (a.indic_fumosita_md,0, null, a.indic_fumosita_md)) as campioni_indic_fumosita
     , iter_edit.num(min(a.co_fumi_secchi),2) as min_co_fumi_secchi
     , iter_edit.num(max(a.co_fumi_secchi),2) as max_co_fumi_secchi
     , iter_edit.num(avg(decode (a.co_fumi_secchi,0 
                             , null 
                             , a.co_fumi_secchi)
                    ),2) as med_co_fumi_secchi
     , count(decode (a.co_fumi_secchi,0, null, a.co_fumi_secchi)) as campioni_co_fumi_secchi
     , iter_edit.num(min(a.ppm),2) as min_ppm
     , iter_edit.num(max(a.ppm),2) as max_ppm
     , iter_edit.num(avg(decode (a.ppm,0 
                             , null 
                             , a.ppm)
                    ),2) as med_ppm
     ,count(decode (a.ppm,0, null, a.ppm)) as campioni_ppm
     , iter_edit.num(min(a.eccesso_aria_perc),2) as min_eccesso_aria_perc
     , iter_edit.num(max(a.eccesso_aria_perc),2) as max_eccesso_aria_perc
     , iter_edit.num(avg(decode (a.eccesso_aria_perc,0 
                             , null 
                             , a.eccesso_aria_perc)
                    ),2) as med_eccesso_aria_perc
     ,count(decode (a.eccesso_aria_perc,0, null, a.eccesso_aria_perc)) as campioni_eccesso_aria_perc
     , iter_edit.num(min(a.perdita_ai_fumi),2) as min_perdita_ai_fumi
     , iter_edit.num(max(a.perdita_ai_fumi),2) as max_perdita_ai_fumi
     , iter_edit.num(avg(decode (a.perdita_ai_fumi,0 
                             , null 
                             , a.perdita_ai_fumi)
                    ),2) as med_perdita_ai_fumi
     ,count(decode (a.perdita_ai_fumi,0, null, a.perdita_ai_fumi)) as campioni_perdita_ai_fumi
     , count(*) as contatore 
  from coimcimp a
     , coimaimp b 
     , coimpote c
     , coimcomb f 
  $from_terr_ora
 where b.cod_impianto (+) = a.cod_impianto
   and c.cod_potenza  (+) = b.cod_potenza
   $join_terr_ora
   and f.cod_combustibile (+)= b.cod_combustibile
   and (a.flag_tracciato <> 'MA' 
        or flag_tracciato is null)
 $where_data
  group by  $des_terr
         ,  $cod_terr
         , c.descr_potenza
         , f.descr_comb
  order by $des_terr
         , c.descr_potenza
         , f.descr_comb
       </querytext>
    </fullquery>

    <fullquery name="sel_stat2">
       <querytext>
select count(decode (a.temp_fumi_md, 0, null ,a.temp_fumi_md)) as campioni_temp_fumi
     , count(decode (a.t_aria_comb_md, 0, null ,a.t_aria_comb_md)) as campioni_t_aria_comb
     , count(decode (a.temp_mant_md, 0, null ,a.temp_mant_md)) as campioni_temp_mant
     , count(decode (a.temp_h2o_out_md, 0, null ,a.temp_h2o_out_md)) as campioni_temp_h2o_out
     , count(decode (a.co2_md, 0, null ,a.co2_md)) as campioni_co2
     , count(decode (a.o2_md, 0, null ,a.o2_md)) as campioni_o2
     , count(decode (a.co_md, 0, null ,a.co_md)) as campioni_co
     , count(decode (a.indic_fumosita_md, 0, null ,a.indic_fumosita_md)) as campioni_indic_fumosita
     , count(decode (a.co_fumi_secchi, 0, null ,a.co_fumi_secchi)) as campioni_co_fumi_secchi
     ,count(decode (a.ppm, 0, null ,a.ppm)) as campioni_ppm
     ,count(decode (a.eccesso_aria_perc, 0, null ,a.eccesso_aria_perc)) as campioni_eccesso_aria_perc
     ,count(decode (a.perdita_ai_fumi, 0, null ,a.perdita_ai_fumi)) as campioni_perdita_ai_fumi
     , count(decode (stato_coiben, 'B', 1, null)) as stato_coiben_b
     , count(decode (stato_coiben, 'M', 1, null)) as stato_coiben_m
     , count(decode (stato_coiben, 'S', 1, null)) as stato_coiben_s
     , count(decode (stato_coiben, null, 1, null)) as stato_coiben_n
     , count(decode (stato_canna_fum, 'B', 1, null)) as stato_canna_fum_b
     , count(decode (stato_canna_fum, 'M', 1, null)) as stato_canna_fum_m
     , count(decode (stato_canna_fum, 'S', 1, null)) as stato_canna_fum_s 
     , count(decode (stato_canna_fum, null, 1, null)) as stato_canna_fum_n

     , count(decode (verifica_dispo, 'P', 1, null)) as verifica_dispo_p
     , count(decode (verifica_dispo, 'N', 1, null)) as verifica_dispo_n
     , count(decode (verifica_dispo, null, 1, null)) as verifica_dispo_no
     , count(decode (verifica_areaz, 'P', 1, null)) as verifica_areaz_p
     , count(decode (verifica_areaz, 'N', 1, null)) as verifica_areaz_n
     , count(decode (verifica_areaz, null, 1, null)) as verifica_areaz_no
     , count(decode (taratura_dispos, 'E', 1, null)) as taratura_dispos_si
     , count(decode (taratura_dispos, 'N', 1, null)) as taratura_dispos_no
     , count(decode (taratura_dispos, null, 1, null)) as taratura_dispos_n
     , count(*) as contatore
  from coimcimp a
  where 1=1
    and a.flag_tracciato <> 'MA'
    or  a.flag_tracciato is null
  $where_data
        </querytext>
    </fullquery>

</queryset>
