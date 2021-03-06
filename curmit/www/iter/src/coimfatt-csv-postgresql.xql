<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_fatt">
       <querytext>
                select cod_fatt --gab01
                     , num_fatt  
                     , iter_edit_data(data_fatt) as fatt_dt
                     , matr_da
                     , matr_a
                     , tipo_sogg
                     , cod_sogg
            --gab01  , iter_edit_num(imponibile, 2) as totale
            --gab01  , imponibile as impo
            --gab01  , perc_iva
                     , iter_edit_num(spe_legali, 2) as spe_legali
            --gab02  , iter_edit_num(spe_postali, 2) as spe_postali
                     , spe_postali --gab02
                     , mod_pag --gab01
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
