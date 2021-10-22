<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_stat">
       <querytext>
 select  $des_terr as h_des_terr
      , b.descr_potenza
      , c.descr_tpim
      , a.flag_dichiarato
      , to_char(a.data_installaz, 'yyyy') as anno_inst
      , d.descr_comb
      , count(*) as contatore 
   from coimaimp a
      , coimpote b  
      , coimtpim c
      , coimcomb d
  $from_terr_ora
  where a.stato               = 'A'
    and b.cod_potenza      (+)= a.cod_potenza
    and c.cod_tpim         (+)= a.cod_tpim
    and d.cod_combustibile (+)= a.cod_combustibile
  $join_terr_ora
  group by  $des_terr
         ,  $cod_terr
         , b.descr_potenza
         , c.descr_tpim
         , a.flag_dichiarato
	 , to_char(a.data_installaz, 'yyyy')
         , d.descr_comb
  order by  $des_terr
         , b.descr_potenza
         , c.descr_tpim
         , a.flag_dichiarato
	 , to_char(a.data_installaz, 'yyyy')
         , d.descr_comb
       </querytext>
    </fullquery>

</queryset>
