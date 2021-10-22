<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_stat">
       <querytext>
select  $des_terr as h_des_terr
     , b.flag_tipo_impianto 
     , c.descr_potenza
     , iter_edit_num(avg(case when a.temp_fumi=0 
                              then null 
                              else a.temp_fumi end
                    ),2) as temp_fumi
     , count(case when a.temp_fumi=0 then null else a.temp_fumi end) as num_temp_fumi
     , iter_edit_num(min(a.temp_fumi),2) as min_temp_fumi
     , iter_edit_num(max(a.temp_fumi),2) as max_temp_fumi                    
     , iter_edit_num(avg(case when a.temp_ambi=0 
                              then null 
                              else a.temp_ambi end
                    ),2) as temp_ambi
     , count(case when a.temp_ambi=0 then null else a.temp_ambi end) as num_temp_ambi
     , iter_edit_num(min(a.temp_ambi),2) as min_temp_ambi
     , iter_edit_num(max(a.temp_ambi),2) as max_temp_ambi    
     , iter_edit_num(avg(case when a.o2=0 
                              then null 
                              else a.o2 end
                    ),2) as o2
     , count(case when a.o2=0 then null else a.o2 end) as num_o2
     , iter_edit_num(min(a.o2),2) as min_o2
     , iter_edit_num(max(a.o2),2) as max_o2    
     , iter_edit_num(avg(case when a.co2=0 
                              then null 
                              else a.co2 end
                    ),2) as co2
     , count(case when a.co2=0 then null else a.co2 end) as num_co2
     , iter_edit_num(min(a.co2),2) as min_co2
     , iter_edit_num(max(a.co2),2) as max_co2    
     , iter_edit_num(avg(case when a.bacharach=0
                              then null
                              else a.bacharach end
                    ),2) as bacharach
     , count(case when a.bacharach=0 then null else a.bacharach end) as num_bacharach
     , iter_edit_num(min(a.bacharach),2) as min_bacharach
     , iter_edit_num(max(a.bacharach),2) as max_bacharach    
     , iter_edit_num(avg(case when a.co=0
                              then null
                              else a.co end
                    ),2) as co
     , count(case when a.co=0 then null else a.co end) as num_co
     , iter_edit_num(min(a.co),2) as min_co
     , iter_edit_num(max(a.co),2) as max_co    
     , iter_edit_num(avg(case when a.rend_combust=0 
                              then null
                              else a.rend_combust end
                    ),2) as rend_combust
     , count(case when a.rend_combust=0 then null else a.rend_combust end) as num_rend_combust
     , iter_edit_num(min(a.rend_combust),2) as min_rend_combust
     , iter_edit_num(max(a.rend_combust),2) as max_rend_combust  
     , f.descr_comb  
     , count(*) as contatore
  from coimdimp a
  left outer join coimaimp b on b.cod_impianto = a.cod_impianto
  left outer join coimpote c on c.cod_potenza  = b.cod_potenza
  $from_terr_pos           $join_terr_pos
  left outer join coimcomb f on f.cod_combustibile = b.cod_combustibile
  where a.data_controllo = (select max(d.data_controllo)
                              from coimdimp d
                             where d.cod_impianto = a.cod_impianto)
  $where_data
  group by $des_terr
         , b.flag_tipo_impianto 
         , $cod_terr
         , c.descr_potenza
         , f.descr_comb
   order by  $des_terr
         , b.flag_tipo_impianto 
         , c.descr_potenza
         , f.descr_comb
       </querytext>
    </fullquery>


    <fullquery name="sel_stat2">
       <querytext>
select count(case when a.temp_fumi=0 then null else a.temp_fumi end) as num_temp_fumi
     , count(case when a.temp_ambi=0 then null else a.temp_ambi end) as num_temp_ambi
     , count(case when a.o2=0 then null else a.o2 end) as num_o2
     , count(case when a.co2=0 then null else a.co2 end) as num_co2
     , count(case when a.bacharach=0 then null else a.bacharach end) as num_bacharach
     , count(case when a.o2=0 then null else a.o2 end) as num_co
     , count(case when a.rend_combust=0 then null else a.rend_combust end) as num_rend_combust
     , count(*) as contatore
  from coimdimp a
 where a.data_controllo = (select max(d.data_controllo)
                             from coimdimp d
                            where d.cod_impianto = a.cod_impianto)
  $where_data
       </querytext>
    </fullquery>

</queryset>
