<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_enti">
       <querytext>
           select cod_ente
                , denominazione
                , indirizzo
             from coimenti
            where cod_enre = :cod_enre
           $where_last
           $where_word
         order by denominazione
       </querytext>
    </partialquery>

    <fullquery name='sel_enre_desc'>
       <querytext>
           select denominazione as desc_enre
             from coimenre
            where cod_enre = :cod_enre
       </querytext>
    </fullquery>


  </queryset>
