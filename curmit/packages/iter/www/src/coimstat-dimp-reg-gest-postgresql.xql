<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_stat">
       <querytext>
select  $des_terr as h_des_terr
      ,case b.stato
            when 'A' then '1'
            when 'N' then '3'
            when 'L' then '2'
            when 'R' then '4'
            else ''
       end  as stato
     , case b.cod_tpim
           when '0' then '4'
            when 'A' then '1'
            when 'C' then '2'
            when 'D' then '3'
            else ''
       end  as cod_tpim
     , c.descr_potenza
     , k.cod_utgi
     , f.descr_comb
     , b.flag_resp as flag_responsabile
     , data_controllo
     , iter_edit_num(a.rend_combust,2) as rend_combust
     , iter_edit_num(a.co,2) as co
      ,case a.flag_status
            when 'P' then 'S'
            when 'N' then 'N'
            else ''
       end  as flag_status
       ,b.gb_x
       ,b.gb_y
      from coimdimp a
  left outer join coimaimp b on b.cod_impianto = a.cod_impianto
  left outer join coimgend k on k.cod_impianto = a.cod_impianto
  left outer join coimpote c on c.cod_potenza  = b.cod_potenza
  $from_terr_pos           $join_terr_pos
  left outer join coimcomb f on f.cod_combustibile = b.cod_combustibile
  where a.data_controllo = (select max(d.data_controllo)
                              from coimdimp d
                             where d.cod_impianto = a.cod_impianto)
  $where_data
        </querytext>
    </fullquery>



</queryset>
