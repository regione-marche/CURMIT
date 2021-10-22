<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="upd_gage">
       <querytext>
           update coimgage
              set data_prevista   = :data_prevista
                , data_esecuzione = :data_esecuzione
                , stato           = :stato
                , note            = :note
                , data_mod        =  current_date
                , utente          = :id_utente
            where cod_opma     = :cod_opma
              and cod_impianto = :cod_impianto
              and data_ins     = :data_ins
       </querytext>
    </partialquery>

    <partialquery name="del_gage">
       <querytext>
           delete
             from coimgage
            where cod_opma     = :cod_opma
              and cod_impianto = :cod_impianto
              and data_ins     = :data_ins
       </querytext>
    </partialquery>

    <fullquery name="sel_gage">
       <querytext>
           select cod_opma
                , cod_impianto
                , stato
                , case
                    when stato = '1' then 'Da eseguire'
                    when stato = '2' then 'Eseguito'
                  end                             as stato_ed
                , iter_edit_data(data_prevista)   as data_prevista
                , iter_edit_data(data_esecuzione) as data_esecuzione
                , note
                , data_ins
             from coimgage
            where cod_opma     = :cod_opma
              and cod_impianto = :cod_impianto
              and data_ins     = :data_ins
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp_check">
       <querytext>
           select cod_dimp
             from coimdimp
            where cod_impianto   = :cod_impianto
              and data_controllo = :data_controllo
             limit 1
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp_last">
       <querytext>
           select cod_dimp
             from coimdimp
            where cod_impianto   = :cod_impianto
              and data_controllo = (select max(data_controllo) 
                                      from coimdimp 
                                     where cod_impianto = :cod_impianto)
             limit 1
       </querytext>
    </fullquery>

</queryset>
