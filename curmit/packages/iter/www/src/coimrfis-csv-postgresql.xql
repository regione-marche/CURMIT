<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_rfis">
       <querytext>
                select num_rfis  
                     , iter_edit_data(data_rfis) as rfis_dt
                     , matr_da
                     , matr_a
                     , tipo_sogg
                     , cod_sogg
                     , iter_edit_num(imponibile, 2) as totale
                     , imponibile as impo
                     , perc_iva
                  from coimrfis
		  where 1 = 1
		  $where_da_data
		  $where_a_data
                 order by data_rfis
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
