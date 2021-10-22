<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_batc">
       <querytext>
           select a.dat_fine
                , a.ora_fine
                , a.cod_batc
                , b.ctr
                , a.nom
                , b.nom as esit_nom
                , b.url as esit_url
		, case when a.flg_stat = 'C' then 'Terminato'
                       when a.flg_stat = 'D' then 'Interrotto'
                  end  as flg_stat_edit
                , iter_edit.data(dat_iniz) || ' ' || iter_edit.time(ora_iniz)
               as tim_iniz_edit
                , iter_edit.data(dat_fine) || ' ' || iter_edit.time(ora_fine)
               as tim_fine_edit
                , a.cod_uten_sch
             from coimbatc a
                , coimesit b
            where flg_stat in ('C','D')
              and b.cod_batc (+) = a.cod_batc
           $where_last
           $where_word
         order by a.dat_fine desc
                , a.ora_fine desc
                , a.cod_batc desc
                , b.ctr
       </querytext>
    </partialquery>

</queryset>
