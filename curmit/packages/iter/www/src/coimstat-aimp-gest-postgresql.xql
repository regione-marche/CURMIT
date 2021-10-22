<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_stat">
       <querytext>
select  $des_terr as h_des_terr
     , a.flag_tipo_impianto
     , b.descr_potenza
     , c.descr_tpim
     , a.flag_dichiarato
     , to_char(a.data_installaz, 'yyyy') as anno_inst
     , d.descr_comb
     , count(*) as contatore
  from coimaimp a
  left outer join coimpote b on b.cod_potenza = a.cod_potenza
  left outer join coimtpim c on c.cod_tpim    = a.cod_tpim
  left outer join coimcomb d on d.cod_combustibile = a.cod_combustibile
 $from_terr_pos           $join_terr_pos
 where a.stato = 'A'
 group by  $des_terr
        ,  $cod_terr
        , a.flag_tipo_impianto
        , b.descr_potenza
        , c.descr_tpim
        , a.flag_dichiarato
        , to_char(a.data_installaz, 'yyyy')
        , d.descr_comb
 order by  $des_terr
        , a.flag_tipo_impianto
        , b.descr_potenza
        , c.descr_tpim
        , a.flag_dichiarato
        , to_char(a.data_installaz, 'yyyy')
        , d.descr_comb
       </querytext>
    </fullquery>

</queryset>
