<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_boll">
       <querytext>
           select a.num_fatt
                , a.matr_da
                , a.matr_a
                , a.n_bollini
                , a.imponibile
                , a.importo
                , a.flag_pag
                , a.mod_pag
                , a.perc_iva
                , iter_edit_num(a.perc_iva, 2)   as perc_iva_edit 
                , iter_edit_data(a.data_fatt)    as data_fatt
                , to_char(a.data_fatt, 'yyyy') as anno
                , a.tipo_sogg
                , a.desc_fatt
                , iter_edit_num(a.spe_legali,2)  as spe_legali
                , iter_edit_num(a.spe_postali,2) as spe_postali
                , a.flag_split_payment --sim01
             from coimfatt a
            where a.cod_fatt     = :cod_fatt
       </querytext>
    </fullquery>
 
    <fullquery name="sel_manu">
       <querytext>
           select name        as m_manutentore
                , zipcode     as m_cap
                , city        as m_comune
                , address1    as m_indirizzo
                , address2    as m_localita
                , province    as m_provincia
                , iva_code    as m_piva
                , fiscal_code as m_cod_fiscale
             from iter_maintainers
            where iter_code = :cod_sogg
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
