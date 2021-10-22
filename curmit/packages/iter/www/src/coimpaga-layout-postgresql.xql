<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_desc_comu">
       <querytext>
           select denominazione as desc_comune
             from coimcomu
            where cod_comune = :f_cod_comune
       </querytext>
    </fullquery>


    <fullquery name="sel_movi">
       <querytext>
    select e.descrizione as tipo_movi
         , b.cod_impianto_est
         , iter_edit_data(a.data_scad) as data_scad
         , coalesce(iter_edit_data(a.data_compet),'') as data_compet
         , iter_edit_num(a.importo, 2) as importo
         , coalesce(iter_edit_num(a.importo_pag, 2),'0') as importo_pag
         , d.denominazione as comune
         , coalesce(c.cognome, '')||' '||coalesce(c.nome, '') as resp
         , coalesce(c.indirizzo, '') as indirizzo
         , coalesce(c.cap, '')||' '||coalesce(c.comune, '') as cap_com
         from coimmovi a 
           inner join coimaimp b on b.cod_impianto  = a.cod_impianto 
                                and b.stato = 'A'
      left outer join coimcitt c on c.cod_cittadino = b.cod_responsabile 
      left outer join coimcomu d on d.cod_comune    = b.cod_comune
      left outer join coimcaus e on a.id_caus       = e.id_caus
     where a.data_pag is null
     $where_data
     $where_caus
     $where_comune
     order by d.denominazione
       </querytext>
    </fullquery>

    <fullquery name="estrai_data">
       <querytext>
       select iter_edit_data(current_date) as data_time
       </querytext>
    </fullquery>

    <fullquery name="edit_date_dual">
       <querytext>
        select iter_edit_data(:f_data_da) as data_da_e
             , iter_edit_data(:f_data_a) as data_a_e
       </querytext>
    </fullquery>

</queryset>
