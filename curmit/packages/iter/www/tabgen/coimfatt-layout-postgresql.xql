<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_enti">
       <querytext>
           select a.denominazione
                , a.indirizzo
                , a.numero
                , a.cap
                , a.localita
                , a.comune
                , a.perc_iva
                , iter_edit_num(a.perc_iva, 2) as perc_iva_edit 
                , iter_edit_data(a.data_fatt) as data_fatt
                , b.cognome     as manu_cogn
                , b.nome        as manu_nome
                , b.cap         as manu_cap
                , b.comune      as manu_comu
                , b.indirizzo   as manu_indi
                , b.localita    as manu_loca
                , b.cod_piva    as manu_piva
                , b.cod_fiscale as manu_cod_f
             from coimenti a
            where cod_enre     = :cod_enre
       </querytext>
    </fullquery>
 </queryset>
 