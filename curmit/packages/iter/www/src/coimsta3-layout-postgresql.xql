<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_comune">
       <querytext>
          select denominazione as comune
               , cod_comune
            from coimcomu
           $where_comune
       </querytext>
    </fullquery>

    <fullquery name="sel_effettivi">
       <querytext>
          select count(*) as conta_effettivi
            from coiminco a
               , coimaimp b
           where a.stato = '2'
	     and a.data_verifica = :data
             and a.ora_verifica is not null
             and b.cod_impianto = a.cod_impianto
             and b.cod_comune = :cod_comune
           $where_campagna
       </querytext>
    </fullquery>

    <fullquery name="sel_riserve">
       <querytext>
          select count(*) as conta_riserve
            from coiminco a
               , coimaimp b
           where a.stato = '2'
	     and a.data_verifica is null
             and a.ora_verifica is null
             and b.cod_impianto = a.cod_impianto
             and b.cod_comune = :cod_comune
           $where_campagna        
       </querytext>
    </fullquery>

    <fullquery name="edit_date_dual">
       <querytext>
        select iter_edit_data(:f_data1) as data1e
             , iter_edit_data(:f_data2) as data2e
       </querytext>
    </fullquery>

    <fullquery name="estrai_data">
       <querytext>
       select iter_edit_data(current_date) as data_time
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
