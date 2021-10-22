<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_boll">
       <querytext>
           select a.num_rfis
                , a.matr_da
                , a.matr_a
                , a.n_bollini
                , a.imponibile
                , a.flag_pag
                , a.mod_pag
                , a.perc_iva
                , iter_edit_num(a.perc_iva, 2) as perc_iva_edit 
                , iter_edit_data(a.data_rfis) as data_rfis
                , a.tipo_sogg
             from coimrfis a
            where a.cod_rfis     = :cod_rfis
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