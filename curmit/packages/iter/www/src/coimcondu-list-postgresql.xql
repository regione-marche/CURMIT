<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
        <querytext>
                   select cod_conduttore
                        , coalesce(cognome,'')||' '||coalesce(nome,'')     as nominativo
                        , cognome
                        , nome
                        , coalesce(indirizzo,'')||' '||coalesce(numero,'') as indirizzo
                        , comune
                        , cod_fiscale
                     from coimcondu
                    where 1 = 1
                   $where_word
                   $where_nome
                   $where_cod_conduttore
                   $where_cod_fiscale
                   $where_comune
                   $where_key
                   $where_ammi
                 order by cognome
                        , nome
                        , cod_conduttore
       </querytext>
   </partialquery>

   <fullquery name="sel_conta_condu">
       <querytext>
           select iter_edit_num(count(*),0) as conta_num
             from coimcondu
           where 1=1
           $where_word
           $where_nome
           $where_cod_conduttore
           $where_cod_fiscale
	   $where_comune
       </querytext>
   </fullquery>

</queryset>
