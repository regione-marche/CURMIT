<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_date">
       <querytext>
                   select to_char(sysdate, 'yyyymmdd') as data_corrente
                     from dual
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
                  , cod_impianto
                  , iter_edit.data(data_scad) as data_scad
                  , iter_edit.num(importo, 2) as importo
                  , iter_edit.num(importo_pag, 2) as importo_pag
                  , iter_edit.data(data_pag) as data_pag
                  , iter_edit.data(data_compet) as data_compet
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
           select coimmovi_s.nextval as cod_movi
       </querytext>
    </fullquery>

    <fullquery name="get_dat_aimp_si_vie">
       <querytext>
           select a.cod_impianto_est
                , a.localita
                , a.cod_amag
                , b.denominazione as comune
                , c.descrizione as via
                , c.descr_topo as topo
                , a.numero
                , a.esponente
                , a.scala
                , a.piano
                , a.interno
                , a.cap
                , nvl(d.cognome, '')||' '||nvl(d.nome, '') as resp
                , nvl(e.cognome, '')||' '||nvl(e.nome,'') as occup
                , decode (
                    (((select add_months(sysdate, :mesi_evidenza_mod) 
                         from dual) - a.data_mod)
                - abs((select add_months(sysdate, :mesi_evidenza_mod)
                         from dual) - a.data_mod))
                    , 0, 'F'
                    , decode (
                        a.data_mod, a.data_ins, 'F'                
                        , decode (
                             (a.data_mod - a.data_ins)-abs(a.data_mod - a.data_ins)
                             , 0, 'T'
                             , 'F'
                          )
                      )
                  ) as swc_mod
                , iter_edit.data(a.data_mod) as data_mod_edit
                , a.utente
             from coimaimp a
                , coimcomu b 
                , coimviae c 
                , coimcitt e  
                , coimcitt d
		, coimmovi f
            where f.cod_movi      = :cod_movi
              and a.cod_impianto  = f.cod_impianto
              and d.cod_cittadino (+) = a.cod_responsabile
              and b.cod_comune    (+) = a.cod_comune
              and c.cod_comune    (+) = a.cod_comune
              and c.cod_via       (+) = a.cod_via 
              and e.cod_cittadino (+) = a.cod_occupante
       </querytext>
    </fullquery>

    <fullquery name="get_dat_aimp_no_vie">
       <querytext>
           select a.cod_impianto_est
                , a.localita
                , a.cod_amag
                , b.denominazione as comune
                , a.indirizzo as via
                , a.toponimo as topo
                , a.numero
                , a.esponente
                , a.scala
                , a.piano
                , a.interno
                , a.cap
                , nvl(d.cognome, '')||' '||nvl(d.nome, '') as resp
                , nvl(e.cognome, '')||' '||nvl(e.nome,'') as occup
                , decode (
                    (((select add_months(sysdate, :mesi_evidenza_mod) 
                         from dual) - a.data_mod)
                - abs((select add_months(sysdate, :mesi_evidenza_mod)
                         from dual) - a.data_mod))
                    , 0, 'F'
                    , decode (
                        a.data_mod, a.data_ins, 'F'                
                        , decode (
                             (a.data_mod - a.data_ins)-abs(a.data_mod - a.data_ins)
                             , 0, 'T'
                             , 'F'
                          )
                      )
                  ) as swc_mod
                , iter_edit.data(a.data_mod) as data_mod_edit
                , a.utente
             from coimaimp a
                , coimcomu b 
                , coimcitt e  
                , coimcitt d
            where f.cod_movi      = :cod_movi
              and a.cod_impianto  = f.cod_impianto
              and d.cod_cittadino (+) = a.cod_responsabile
              and b.cod_comune    (+) = a.cod_comune
              and e.cod_cittadino (+) = a.cod_occupante
       </querytext>
    </fullquery>



</queryset>
