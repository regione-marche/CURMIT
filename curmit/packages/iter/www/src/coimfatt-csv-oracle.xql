<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_fatt">
       <querytext>
                select num_fatt  
                     , iter_edit.date(data_fatt) as fatt_dt
                     , matr_da
                     , matr_a
                     , tipo_sogg
                     , cod_sogg
                     , iter_edit.num(imponibile, 2) as totale
                     , imponibile as impo
                     , perc_iva
                  from coimfatt
		  where 1 = 1
		  $where_da_data
		  $where_a_data
                 order by data_fatt
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
            select cognome
                 , nome
                 , indirizzo as nome_via
                 , cap
                 , localita
                 , comune
                 , provincia
                 , cod_piva as partita_iva
              from coimmanu
             where cod_manutentore = :cod_sogg
       </querytext>
    </fullquery>

    <fullquery name="sel_citt">
       <querytext>
            select cognome
                 , nome
                 , indirizzo as nome_via
                 , numero    as n_civ  
                 , cap
                 , localita
                 , comune
                 , provincia
                 , cod_piva as partita_iva
              from coimcitt
             where cod_cittadino = :cod_sogg
       </querytext>
    </fullquery>

</queryset>
