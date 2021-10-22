<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_uten">
       <querytext>
           select cognome   as uten_cognome
                , nome      as uten_nome
             from coimuten
            where id_utente = :id_utente
       </querytext>
    </fullquery>

    <partialquery name="sel_docu">
       <querytext>
           select cod_documento
                , iter_edit_data(data_documento) as data_documento_edit
             from coimdocu
            where tipo_documento = 'DA'
              and tipo_soggetto  = :tipo_soggetto
              and cod_soggetto   = :cod_soggetto
           $where_last
         order by cod_documento desc
       </querytext>
    </partialquery>

</queryset>
