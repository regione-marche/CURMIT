<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_date">
       <querytext>
                   select to_char(current_date, 'yyyymmdd') as data_corrente
       </querytext>
    </fullquery>

    <partialquery name="upd_movi">
       <querytext>
                update coimmovi
                   set tipo_movi    = :tipo_movi
                     , data_scad    = :data_scad
                     , importo      = :importo
                     , importo_pag  = :importo_pag
                     , data_pag     = :data_pag
                     , tipo_pag     = :tipo_pag
                     , data_compet  = :data_compet
                     , nota         = :nota
                     , data_mod     = :data_corrente
                     , utente       = :id_utente
                     , id_caus      = :id_caus
                     , data_incasso = :data_incasso   --san01
                 where cod_movi     = :cod_movi
       </querytext>
    </partialquery>

    <partialquery name="del_movi">
       <querytext>
                delete
                  from coimmovi
                 where cod_movi = :cod_movi
       </querytext>
    </partialquery>

    <fullquery name="sel_movi">
       <querytext>
             select cod_movi
                  , tipo_movi
                  , id_caus
                  , cod_impianto
                  , iter_edit_data(data_scad) as data_scad
                  , iter_edit_num(importo, 2) as importo
                  , iter_edit_num(importo_pag, 2) as importo_pag
                  , iter_edit_data(data_pag) as data_pag
                  , iter_edit_data(data_compet) as data_compet
                  , iter_edit_data(data_incasso) as data_incasso --san01
                  , tipo_pag
                  , nota
               from coimmovi
              where cod_movi = :cod_movi
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp">
       <querytext>
             select cod_impianto_est
               from coimaimp
              where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_movi_check">
       <querytext>
        select '1'
          from coimmovi
         where cod_movi = :cod_movi
       </querytext>
    </fullquery>

    <fullquery name="sel_movi_next">
        <querytext>
           select nextval('coimmovi_s') as cod_movi
       </querytext>
    </fullquery>

    <fullquery name="get_dat_aimp_si_vie">
       <querytext>
           select a.cod_impianto_est
                , a.cod_impianto
                , a.cod_amag
                , a.localita
                , b.denominazione as comune
                , c.descrizione as via
                , c.descr_topo as topo
                , a.numero
                , a.esponente
                , a.scala
                , a.piano
                , a.interno
                , a.cap
                , coalesce(d.cognome,'')||' '||coalesce(d.nome,'') as resp
                , coalesce(e.cognome, '')||' '||coalesce(e.nome,'') as occup
                , case
                  when (select to_date(add_months(current_date, :mesi_evidenza_mod), 'yyyy-mm-dd')                        
                       ) > a.data_mod
                  then 'F'
                  else case when (a.data_ins < a.data_mod)
                    then 'T'
                    else 'F' end
                  end as swc_mod
                , iter_edit_data(a.data_mod) as data_mod_edit
                , a.utente
             from coimmovi f
                  inner join coimaimp a on a.cod_impianto  = f.cod_impianto
             left outer join coimcomu b on b.cod_comune    = a.cod_comune
             left outer join coimviae c on c.cod_comune    = a.cod_comune
                                       and c.cod_via       = a.cod_via 
             left outer join coimcitt e on e.cod_cittadino = a.cod_occupante
             left outer join coimcitt d on d.cod_cittadino = a.cod_responsabile
            where f.cod_movi      = :cod_movi
             
       </querytext>
    </fullquery>

    <fullquery name="get_dat_aimp_no_vie">
       <querytext>
           select a.cod_impianto_est
                , a.cod_impianto
                , a.cod_amag
                , a.localita
                , b.denominazione as comune
                , a.indirizzo as via
                , a.toponimo as topo
                , a.numero
                , a.esponente
                , a.scala
                , a.piano
                , a.interno
                , a.cap
                , coalesce(d.cognome,'')||' '||coalesce(d.nome,'') as resp
                , coalesce(e.cognome, '')||' '||coalesce(e.nome,'') as occup
                , case
                  when (select to_date(add_months(current_date, :mesi_evidenza_mod), 'yyyy-mm-dd')                       
                       ) > a.data_mod
                  then 'F'
                  else case when (a.data_ins < a.data_mod)
                    then 'T'
                    else 'F' end
                  end as swc_mod
                , iter_edit_data(a.data_mod) as data_mod_edit
                , a.utente
             from coimmovi f
                  inner join coimaimp a on a.cod_impianto  = f.cod_impianto
             left outer join coimcomu b on b.cod_comune    = a.cod_comune
             left outer join coimcitt e on e.cod_cittadino = a.cod_occupante
             left outer join coimcitt d on d.cod_cittadino = a.cod_responsabile
            where f.cod_movi = :cod_movi
             
       </querytext>
    </fullquery>


</queryset>
