<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="get_comu">
       <querytext>
          select denominazione as des_comu 
            from coimcomu 
           where cod_comune = :f_cod_comune
       </querytext>
    </fullquery>


    <fullquery name="edit_date_dual">
       <querytext>
        select iter_edit.data(:f_data1) as data1e
             , iter_edit.data(:f_data2) as data2e
          from dual
       </querytext>
    </fullquery>

    <fullquery name="get_inco">
       <querytext>
    select a.stato
          ,a.esito
          ,a.tipo_estrazione
          ,c.denominazione as comune
      from coiminco a
         , coimaimp b
         , coimcomu c
     where b.cod_impianto = a.cod_impianto
       and c.cod_comune   = b.cod_comune
     $where_comune
     $where_campagna
     $where_data
    order by c.denominazione
       </querytext>
    </fullquery>

    <fullquery name="estrai_data">
       <querytext>
       select iter_edit.data(sysdate) as data_time
         from dual
       </querytext>
    </fullquery>

    <fullquery name="get_campagna">
       <querytext>
          select descrizione as des_campagna
            from coimcinc
           where cod_cinc = :f_campagna
       </querytext>
    </fullquery>

</queryset>
