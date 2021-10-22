<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_gend">
       <querytext>
           select a.gen_prog
                , a.gen_prog_est
                , a.descrizione    
                , a.matricola      
                , a.modello        
                , b.descr_cost     
                , c.descr_comb     
                , iter_edit.data(a.data_installaz) as data_installaz_edit
                , decode (a.flag_attivo
                       , 'S', 'S&igrave;'
                       , 'N', '<font color=red><b>No</b></font>'
                       , '&nbsp;') as flag_attivo
            from coimgend a
               , coimcost b
               , coimcomb c
           where a.cod_impianto         =  :cod_impianto
             and a.flag_attivo          =  'S'
             and b.cod_cost         (+) = a.cod_cost
             and c.cod_combustibile (+) = a.cod_combustibile
          $where_last
        order by flag_attivo desc
               , gen_prog_est
       </querytext>
    </partialquery>

</queryset>
