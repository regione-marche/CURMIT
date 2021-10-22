<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_desc_comu">
       <querytext>
           select denominazione as desc_comune
             from coimcomu
            where cod_comune = :f_cod_comune
       </querytext>
    </fullquery>


    <fullquery name="sel_movi">
       <querytext>
    select decode (a.tipo_movi 
               ,'MH' , 'Pagamento per dichiarazione'
               ,'VC' , 'Pagamento onere visita di controllo'
               ,'ST' , 'Sanzione tecnica'
               ,'SA' , 'Sanzione amministrativa' 
           ) as tipo_movi
         , b.cod_impianto_est
         , iter_edit.data(a.data_scad) as data_scad
         , iter_edit.num(a.importo, 2) as importo
         , nvl(c.cognome, '')||' '||
           nvl(c.nome, '') as resp
         , d.denominazione as comune
      from coimmovi a 
         , coimaimp b 
         , coimcitt c 
         , coimcomu d  
     where a.data_scad < sysdate
       and b.cod_impianto      = a.cod_impianto 
       and b.stato             = 'A'	       
       and c.cod_cittadino (+) = b.cod_responsabile 
       and d.cod_comune    (+) = b.cod_comune
       and a.data_pag is null
     $where_data
     $where_tipo
     $where_comune
     order by d.denominazione
       </querytext>
    </fullquery>

    <fullquery name="estrai_data">
       <querytext>
       select iter_edit.data(sysdate) as data_time
         from dual
       </querytext>
    </fullquery>

    <fullquery name="edit_date_dual">
       <querytext>
        select iter_edit.data(:f_data_da) as data_da_e
             , iter_edit.data(:f_data_a) as data_a_e
	  from dual
       </querytext>
    </fullquery>

</queryset>
