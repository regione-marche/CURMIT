<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_fatture">
       <querytext>
           select cod_fatt
                , num_fatt
                , matr_da
                , matr_a
                , n_bollini
                , imponibile
                , flag_pag
                , mod_pag
                , perc_iva
                , iter_edit_num(perc_iva, 2) as perc_iva_edit 
                , iter_edit_data(data_fatt) as data_fatt
                , cod_sogg 
                , tipo_sogg 
                , desc_fatt
                , iter_edit_num(spe_legali,2) as spe_legali
                , iter_edit_num(spe_postali,2) as spe_postali
             from coimfatt 
            where lpad(num_fatt, 10, '0') >= lpad(:f_da_num_fatt, 10, '0')
              and lpad(num_fatt, 10, '0') <= lpad(:f_a_num_fatt, 10, '0')
       </querytext>
    </fullquery>

    <fullquery name="sel_boll">
       <querytext>
           select num_fatt
                , matr_da
                , matr_a
                , n_bollini
                , imponibile
                , flag_pag
                , mod_pag
                , perc_iva
                , iter_edit_num(perc_iva, 2) as perc_iva_edit 
                , iter_edit_data(data_fatt) as data_fatt
                , tipo_sogg
                , desc_fatt
                , iter_edit_num(spe_legali,2) as spe_legali
                , iter_edit_num(spe_postali,2) as spe_postali
             from coimfatt 
            where cod_fatt     = :cod_fatt
       </querytext>
    </fullquery>
 
    <fullquery name="sel_manu">
       <querytext>
           select nome as m_nome
                , cognome as m_cognome
                , cap as m_cap
                , comune as m_comune
                , indirizzo as m_indirizzo
                , localita as m_localita
                , cod_piva as m_piva
                , cod_fiscale as m_cod_fiscale
             from coimmanu a
            where cod_manutentore = :cod_sogg
       </querytext>
    </fullquery>


    <fullquery name="sel_citt">
       <querytext>
           select nome as c_nome
                , cognome as c_cognome
                , cap as c_cap
                , comune as c_comune
                , indirizzo as c_indirizzo
                , localita as c_localita
                , cod_piva as c_piva
                , cod_fiscale as c_cod_fiscale
             from coimcitt 
            where cod_cittadino = :cod_sogg
       </querytext>
    </fullquery>

 </queryset>
