<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
        <querytext>
                   select cod_cittadino
                        , nvl(cognome,'')||' '||nvl(nome,'')     as nominativo
                        , cognome
                        , nome
                        , nvl(indirizzo,'')||' '||nvl(numero,'') as indirizzo
                        , comune
                        , cod_fiscale
                        , case
                          when stato_citt = 'A' then
                               'Attivo'
                          when stato_citt = 'N' then
                               'Non attivo'
                          end as stato_citt
                     from coimcitt
                    where 1 = 1
                   $where_word
                   $where_nome
                   $where_cod_cittadino
                   $where_cod_fiscale
                   $where_cod_piva
                   $where_comune
                   $where_stato_citt
                   $where_key
                 order by cognome
                        , nome
                        , cod_cittadino
       </querytext>
   </partialquery>

   <fullquery name="sel_conta_citt">
       <querytext>
           select iter_edit.num(count(*),0) as conta_num
             from coimcitt
             $from_comu
           where 1=1
           $where_word
           $where_nome
           $where_cod_cittadino
           $where_cod_fiscale
           $where_comune
           $where_cod_piva
       </querytext>
   </fullquery>

</queryset>
