<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_batc">
       <querytext>
select cod_batc
     , nom
     , dat_prev
     , ora_prev
     , flg_stat
     , case when flg_stat = 'A' then 'In Coda'
            when flg_stat = 'B' then 'In Esecuzione'
       end  as flg_stat_edit
     , case when flg_stat = 'A'
            then iter_edit.data(dat_prev) || ' ' || iter_edit.time(ora_prev)
            when flg_stat = 'B'
            then iter_edit.data(dat_iniz) || ' ' || iter_edit.time(ora_iniz)
       end  as tim_batc_edit
     , cod_uten_sch
  from coimbatc
 where flg_stat in ('A','B')
$where_last
$where_word
order by flg_stat desc
       , dat_prev
       , ora_prev
       , cod_batc
       </querytext>
    </partialquery>

</queryset>
