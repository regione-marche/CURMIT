<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
        <querytext>
                   select a.cod_cittadino
                        , coalesce(a.cognome,'')||' '||coalesce(a.nome,'') as nominativo
                        , a.cognome
                        , a.nome
                        , coalesce(a.indirizzo,'')||' '||coalesce(a.numero,'') as indirizzo
                        , a.comune
                        , a.cod_fiscale
                     from coimcitt a
                        , coimaimp b
                    where a.cod_cittadino = b.cod_responsabile
                      and b.flag_resp = 'T'
                   $where_word
                   $where_nome
                   $where_cod_cittadino
                   $where_cod_fiscale
                   $where_cod_piva
                   $where_comune
                   $where_key
                 group by a.cod_cittadino,coalesce(a.cognome,'')||' '||coalesce(a.nome,'') , a.cognome, a.nome,coalesce(a.indirizzo,'')||' '||coalesce(a.numero,'') , a.comune, a.cod_fiscale
                 order by cognome, nome, cod_cittadino
       </querytext>
   </partialquery>

   <fullquery name="sel_conta_citt">
       <querytext>
           select iter_edit_num(count(*),0) as conta_num
             from coimcitt a
                , coimaimp b
           where a.cod_cittadino = b.cod_responsabile
             and b.flag_resp = 'T'
           $where_word
           $where_nome
           $where_cod_cittadino
           $where_cod_fiscale
           $where_cod_piva
	   $where_comune
       </querytext>
   </fullquery>

</queryset>
