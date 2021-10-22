<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_gend">
       <querytext>
           select a.gen_prog
                , a.gen_prog_est
                , a.descrizione    
                , a.matricola      
                , a.modello        
                , b.descr_cost     
                , c.descr_comb     
                , iter_edit_data(a.data_installaz) as data_installaz_edit
                , case a.flag_attivo
                       when 'S' then 'S&igrave;'
                       when 'N' then '<font color=red><b>No</b></font>'
                       else '&nbsp;'
                  end as flag_attivo
		, case a.flag_sostituito 
                       when 'S' then '<font color=red><b>S&igrave;</b></font>'
                       else 'No'
                  end as flag_sostituito --rom01
             from coimgend a
  left outer join coimcost b
               on b.cod_cost = a.cod_cost
  left outer join coimcomb c
               on c.cod_combustibile = a.cod_combustibile
            where a.cod_impianto = :cod_impianto
           $where_last
         order by flag_attivo desc
                , gen_prog_est
       </querytext>
    </partialquery>

</queryset>
