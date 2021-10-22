<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_stat">
       <querytext>
select $des_terr as h_des_terr
     , c.descr_potenza
     , iter_edit.num(avg(decode (a.temp_fumi ,0,null,a.temp_fumi)),2) as temp_fumi
     , count(decode (a.temp_fumi ,0,null,a.temp_fumi)) as num_temp_fumi
     , iter_edit.num(min(a.temp_fumi),2) as min_temp_fumi
     , iter_edit.num(max(a.temp_fumi),2) as max_temp_fumi   
     , iter_edit.num(avg(decode (a.temp_ambi ,0,null,a.temp_ambi)),2) as temp_ambi
     , count(decode (a.temp_ambi ,0,null,a.temp_ambi)) as num_temp_ambi
     , iter_edit.num(min(a.temp_ambi),2) as min_temp_ambi
     , iter_edit.num(max(a.temp_ambi),2) as max_temp_ambi   
     , iter_edit.num(avg(decode (a.o2, 0,null,a.o2)),2) as o2
     , count(decode (a.o2, 0,null,a.o2)) as num_o2
     , iter_edit.num(min(a.o2),2) as min_o2
     , iter_edit.num(max(a.o2),2) as max_o2    
     , iter_edit.num(avg(decode (a.co2, 0,null,a.co2)),2) as co2
     , count(decode (a.co2, 0,null,a.co2)) as num_co2
     , iter_edit.num(min(a.co2),2) as min_co2
     , iter_edit.num(max(a.co2),2) as max_co2    
     , iter_edit.num(avg(decode (a.bacharach, 0,null,a.bacharach)),2) as bacharach
     , count(decode (a.bacharach, 0,null,a.bacharach)) as num_bacharach
     , iter_edit.num(min(a.bacharach),2) as min_bacharach
     , iter_edit.num(max(a.bacharach),2) as max_bacharach    
     , iter_edit.num(avg(decode (a.co, 0,null,a.co)),2) as co
     , count(decode (a.co, 0,null,a.co)) as num_co
     , iter_edit.num(min(a.co),2) as min_co
     , iter_edit.num(max(a.co),2) as max_co    
     , iter_edit.num(avg(decode (a.rend_combust, 0,null,a.rend_combust)),2) as rend_combust
     , count(decode (a.rend_combust, 0,null,a.rend_combust)) as num_rend_combust
     , iter_edit.num(min(a.rend_combust),2) as min_rend_combust
     , iter_edit.num(max(a.rend_combust),2) as max_rend_combust  
     , f.descr_comb  
     , count(*) as contatore
  from coimdimp a
     , coimaimp b 
     , coimpote c
     , coimcomb f 
  $from_terr_ora
 where b.cod_impianto (+) = a.cod_impianto
   and c.cod_potenza  (+) = b.cod_potenza
   and a.data_controllo = (select max(d.data_controllo)
                              from coimdimp d
                             where d.cod_impianto = a.cod_impianto)
  $join_terr_ora
   and f.cod_combustibile (+)= b.cod_combustibile
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
select count(decode (a.temp_fumi ,0,null,a.temp_fumi)) as num_temp_fumi
     , count(decode (a.temp_ambi ,0,null,a.temp_ambi)) as num_temp_ambi
     , count(decode (a.o2, 0,null,a.o2)) as num_o2
     , count(decode (a.co2, 0,null,a.co2)) as num_co2
     , count(decode (a.bacharach, 0,null,a.bacharach)) as num_bacharach
     , count(decode (a.co, 0,null,a.co)) as num_co
     , count(decode (a.rend_combust, 0,null,a.rend_combust)) as num_rend_combust
     , count(*) as contatore
  from coimdimp a where a.data_controllo = (select max(d.data_controllo)
                                         from coimdimp d
                                        where d.cod_impianto = a.cod_impianto)
  $where_data
        </querytext>
    </fullquery>

</queryset>
