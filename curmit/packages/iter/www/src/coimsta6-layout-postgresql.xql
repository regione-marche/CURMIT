?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_comu">
       <querytext>
              select denominazione as comune
                   , cod_comune
                from coimcomu
               $where_comu
       </querytext>
    </fullquery>

    <fullquery name="sel_pesi">
       <querytext>
              select a.descrizione as raggruppamento
                   , count(*) as conta_pesi
                from coimragr a
                   , coimpesi b
                   , coimdipe c
                   , coimaimp d
                   , coimdimp e
               where a.cod_raggruppamento = b.cod_raggruppamento
                 and b.nome_campo   = c.nome_campo
                 and b.tipo_peso    = c.tipo_peso
                 and c.cod_impianto = d.cod_impianto
                 and d.cod_comune   = :cod_comune
                 and e.cod_dimp     = c.cod_dimp
                 and e.data_controllo between :f_data1 and :f_data2
            group by a.descrizione
       </querytext>
    </fullquery>

</queryset>
