<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_stat">
       <querytext>
select  $des_terr as h_des_terr
     , b.flag_tipo_impianto
     , c.descr_potenza
     , f.descr_comb 
     , a.esito_verifica
     , count(case when stato_coiben = 'B' then 1 else null end) as stato_coiben_b
     , count(case when stato_coiben = 'M' then 1 else null end) as stato_coiben_m
     , count(case when stato_coiben = 'S' then 1 else null end) as stato_coiben_s
     , count(case when stato_coiben is null then 1 else null end) as stato_coiben_n
     , count(case when stato_canna_fum = 'B' then 1 else null end) as stato_canna_fum_b
     , count(case when stato_canna_fum = 'M' then 1 else null end) as stato_canna_fum_m
     , count(case when stato_canna_fum = 'S' then 1 else null end) as stato_canna_fum_s 
     , count(case when stato_canna_fum is null then 1 else null end) as stato_canna_fum_n

     , count(case when verifica_dispo = 'P' then 1 else null end) as verifica_dispo_p
     , count(case when verifica_dispo = 'N' then 1 else null end) as verifica_dispo_n
     , count(case when verifica_dispo is null then 1 else null end) as verifica_dispo_no
     , count(case when verifica_areaz = 'P' then 1 else null end) as verifica_areaz_p
     , count(case when verifica_areaz = 'N' then 1 else null end) as verifica_areaz_n
     , count(case when verifica_areaz is null then 1 else null end) as verifica_areaz_no
     , count(case when taratura_dispos = 'E' then 1 else null end) as taratura_dispos_si
     , count(case when taratura_dispos = 'N' then 1 else null end) as taratura_dispos_no
     , count(case when taratura_dispos is null then 1 else null end) as taratura_dispos_n
     , iter_edit_num(min(a.temp_fumi_md),2) as min_temp_fumi
     , iter_edit_num(max(a.temp_fumi_md),2) as max_temp_fumi
     , iter_edit_num(avg(case when a.temp_fumi_md=0 
                              then null 
                              else a.temp_fumi_md end
                    ),2) as med_temp_fumi
     , count(case when a.temp_fumi_md=0 then null else a.temp_fumi_md end) as campioni_temp_fumi
     , iter_edit_num(min(a.t_aria_comb_md),2) as min_t_aria_comb
     , iter_edit_num(max(a.t_aria_comb_md),2) as max_t_aria_comb
     , iter_edit_num(avg(case when a.t_aria_comb_md=0 
                              then null 
                              else a.t_aria_comb_md end
                    ),2) as med_t_aria_comb
     , count(case when a.t_aria_comb_md=0 then null else a.t_aria_comb_md end) as campioni_t_aria_comb
     , iter_edit_num(min(a.temp_mant_md),2) as min_temp_mant
     , iter_edit_num(max(a.temp_mant_md),2) as max_temp_mant
     , iter_edit_num(avg(case when a.temp_mant_md=0 
                              then null 
                              else a.temp_mant_md end
                    ),2) as med_temp_mant
     , count(case when a.temp_mant_md=0 then null else a.temp_mant_md end) as campioni_temp_mant
     , iter_edit_num(min(a.temp_h2o_out_md),2) as min_temp_h2o_out
     , iter_edit_num(max(a.temp_h2o_out_md),2) as max_temp_h2o_out
     , iter_edit_num(avg(case when a.temp_h2o_out_md=0 
                              then null 
                              else a.temp_h2o_out_md end
                    ),2) as med_temp_h2o_out
     , count(case when a.temp_h2o_out_md=0 then null else a.temp_h2o_out_md end) as campioni_temp_h2o_out
     , iter_edit_num(min(a.co2_md),2) as min_co2
     , iter_edit_num(max(a.co2_md),2) as max_co2
     , iter_edit_num(avg(case when a.co2_md=0 
                              then null 
                              else a.co2_md end
                    ),2) as med_co2
     , count(case when a.co2_md=0 then null else a.co2_md end) as campioni_co2
     , iter_edit_num(min(a.o2_md),2) as min_o2
     , iter_edit_num(max(a.o2_md),2) as max_o2
     , iter_edit_num(avg(case when a.o2_md=0 
                              then null 
                              else a.o2_md end
                    ),2) as med_o2
     , count(case when a.o2_md=0 then null else a.o2_md end) as campioni_o2
     , iter_edit_num(min(a.co_md),2) as min_co
     , iter_edit_num(max(a.co_md),2) as max_co
     , iter_edit_num(avg(case when a.co_md=0 
                              then null 
                              else a.co_md end
                    ),2) as med_co
     , count(case when a.co_md=0 then null else a.co_md end) as campioni_co
     , iter_edit_num(min(a.indic_fumosita_md),2) as min_indic_fumosita
     , iter_edit_num(max(a.indic_fumosita_md),2) as max_indic_fumosita
     , iter_edit_num(avg(case when a.indic_fumosita_md=0 
                              then null 
                              else a.indic_fumosita_md end
                    ),2) as med_indic_fumosita
     , count(case when a.indic_fumosita_md=0 then null else a.indic_fumosita_md end) as campioni_indic_fumosita
     , iter_edit_num(min(a.co_fumi_secchi),2) as min_co_fumi_secchi
     , iter_edit_num(max(a.co_fumi_secchi),2) as max_co_fumi_secchi
     , iter_edit_num(avg(case when a.co_fumi_secchi=0 
                              then null 
                              else a.co_fumi_secchi end
                    ),2) as med_co_fumi_secchi
     , count(case when a.co_fumi_secchi=0 then null else a.co_fumi_secchi end) as campioni_co_fumi_secchi
     , iter_edit_num(min(a.ppm),2) as min_ppm
     , iter_edit_num(max(a.ppm),2) as max_ppm
     , iter_edit_num(avg(case when a.ppm=0 
                              then null 
                              else a.ppm end
                    ),2) as med_ppm
     ,count(case when a.ppm=0 then null else a.ppm end) as campioni_ppm
     , iter_edit_num(min(a.eccesso_aria_perc),2) as min_eccesso_aria_perc
     , iter_edit_num(max(a.eccesso_aria_perc),2) as max_eccesso_aria_perc
     , iter_edit_num(avg(case when a.eccesso_aria_perc=0 
                              then null 
                              else a.eccesso_aria_perc end
                    ),2) as med_eccesso_aria_perc
     ,count(case when a.eccesso_aria_perc=0 then null else a.eccesso_aria_perc end) as campioni_eccesso_aria_perc
     , iter_edit_num(min(a.perdita_ai_fumi),2) as min_perdita_ai_fumi
     , iter_edit_num(max(a.perdita_ai_fumi),2) as max_perdita_ai_fumi
     , iter_edit_num(avg(case when a.perdita_ai_fumi=0 
                              then null 
                              else a.perdita_ai_fumi end
                    ),2) as med_perdita_ai_fumi
     ,count(case when a.perdita_ai_fumi=0 then null else a.perdita_ai_fumi end) as campioni_perdita_ai_fumi
     , count(*) as contatore 
  from coimcimp a
  left outer join coimaimp b on b.cod_impianto = a.cod_impianto
  left outer join coimpote c on c.cod_potenza  = b.cod_potenza
  $from_terr_pos           $join_terr_pos
  left outer join coimcomb f on f.cod_combustibile = b.cod_combustibile
  where 1=1
    and (a.flag_tracciato <> 'MA'
          or  a.flag_tracciato is null)
  $where_data
  group by $des_terr
         , $cod_terr
         , b.flag_tipo_impianto
         , c.descr_potenza
         , f.descr_comb
         , a.esito_verifica
   order by  $des_terr
         , b.flag_tipo_impianto
         , c.descr_potenza
         , f.descr_comb
         , a.esito_verifica
       </querytext>
    </fullquery>


    <fullquery name="sel_stat2">
       <querytext>
select count(case when a.temp_fumi_md=0 then null else a.temp_fumi_md end) as campioni_temp_fumi
     , count(case when a.t_aria_comb_md=0 then null else a.t_aria_comb_md end) as campioni_t_aria_comb
     , count(case when a.temp_mant_md=0 then null else a.temp_mant_md end) as campioni_temp_mant
     , count(case when a.temp_h2o_out_md=0 then null else a.temp_h2o_out_md end) as campioni_temp_h2o_out
     , count(case when a.co2_md=0 then null else a.co2_md end) as campioni_co2
     , count(case when a.o2_md=0 then null else a.o2_md end) as campioni_o2
     , count(case when a.co_md=0 then null else a.co_md end) as campioni_co
     , count(case when a.indic_fumosita_md=0 then null else a.indic_fumosita_md end) as campioni_indic_fumosita
     , count(case when a.co_fumi_secchi=0 then null else a.co_fumi_secchi end) as campioni_co_fumi_secchi
     ,count(case when a.ppm=0 then null else a.ppm end) as campioni_ppm
     ,count(case when a.eccesso_aria_perc=0 then null else a.eccesso_aria_perc end) as campioni_eccesso_aria_perc
     ,count(case when a.perdita_ai_fumi=0 then null else a.perdita_ai_fumi end) as campioni_perdita_ai_fumi
     , count(case when stato_coiben = 'B' then 1 else null end) as stato_coiben_b
     , count(case when stato_coiben = 'M' then 1 else null end) as stato_coiben_m
     , count(case when stato_coiben = 'S' then 1 else null end) as stato_coiben_s
     , count(case when stato_coiben is null then 1 else null end) as stato_coiben_n
     , count(case when stato_canna_fum = 'B' then 1 else null end) as stato_canna_fum_b
     , count(case when stato_canna_fum = 'M' then 1 else null end) as stato_canna_fum_m
     , count(case when stato_canna_fum = 'S' then 1 else null end) as stato_canna_fum_s 
     , count(case when stato_canna_fum is null then 1 else null end) as stato_canna_fum_n

     , count(case when verifica_dispo = 'P' then 1 else null end) as verifica_dispo_p
     , count(case when verifica_dispo = 'N' then 1 else null end) as verifica_dispo_n
     , count(case when verifica_dispo is null then 1 else null end) as verifica_dispo_no
     , count(case when verifica_areaz = 'P' then 1 else null end) as verifica_areaz_p
     , count(case when verifica_areaz = 'N' then 1 else null end) as verifica_areaz_n
     , count(case when verifica_areaz is null then 1 else null end) as verifica_areaz_no
     , count(case when taratura_dispos = 'E' then 1 else null end) as taratura_dispos_si
     , count(case when taratura_dispos = 'N' then 1 else null end) as taratura_dispos_no
     , count(case when taratura_dispos is null then 1 else null end) as taratura_dispos_n
     , count(*) as contatore
  from coimcimp a
 where 1=1
   and (a.flag_tracciato <> 'MA'
   or  a.flag_tracciato is null)
 $where_data
       </querytext>
    </fullquery>

</queryset>
