<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_gest">
       <querytext>
       select iter_edit_data(a.data_fin_valid) as data_fin_valid_edit
            , case a.ruolo
                when 'P' then 'Proprietario'
                when 'O' then 'Occupante'
                when 'A' then 'Amministratore'
                when 'R' then 'Responsabile'
                when 'T' then 'Intestatario'
                else ''
              end  as ruolo_desc
            , b.cognome
            , b.nome
            , b.cod_fiscale
         from coimrife a
         left outer join coimcitt b on b.cod_cittadino = a.cod_soggetto
        where a.cod_impianto   = :cod_impianto
          and a.ruolo          = :ruolo
          and a.data_fin_valid = :data_fin_valid
       </querytext>
    </fullquery>

    <partialquery name="del_sogg">
       <querytext>
                delete
                  from coimrife
                 where cod_impianto   = :cod_impianto
                   and ruolo          = :ruolo
                   and data_fin_valid = :data_fin_valid
       </querytext>
    </partialquery>


</queryset>
