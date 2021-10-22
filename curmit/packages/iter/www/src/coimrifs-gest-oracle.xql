<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_gest">
       <querytext>
       select iter_edit.data(a.data_fin_valid) as data_fin_valid_edit
            , decode (a.ruolo
                ,'P' , 'Proprietario'
                ,'O' , 'Occupante'
                ,'A' , 'Amministratore'
                ,'R' , 'Responsabile'
                ,'T' , 'Intestatario'
                ,''
              ) as ruolo_desc
            , b.cognome
            , b.nome
            , b.cod_fiscale
         from coimrife a
            , coimcitt b
        where a.cod_impianto      =  :cod_impianto
          and a.ruolo             =  :ruolo
          and to_char(a.data_fin_valid,'yyyy-mm-dd')
                                  =  :data_fin_valid
          and b.cod_cittadino (+) = a.cod_soggetto
       </querytext>
    </fullquery>

    <partialquery name="del_sogg">
       <querytext>
           delete
             from coimrife
            where cod_impianto   = :cod_impianto
              and ruolo          = :ruolo
              and to_char(data_fin_valid,'yyyymmdd') = :data_fin_valid
       </querytext>
    </partialquery>

</queryset>
