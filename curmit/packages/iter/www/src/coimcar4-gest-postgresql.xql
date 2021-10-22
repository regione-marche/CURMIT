<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_date">
       <querytext>
                   select to_char(current_date, 'yyyymmdd') as data_corrente
       </querytext>
    </fullquery>


    <fullquery name="sel_dist">
       <querytext>
                 select ragione_01||' '||coalesce(ragione_02, '') as nome_dist
                   from coimdist
                  where cod_distr = :cod_distr
       </querytext>
    </fullquery>

    <fullquery name="sel_acts">
       <querytext>
                   select cod_distr
                        , to_char(data_caric, 'yyyymmdd') as data_caric
                     from coimacts
                    where cod_acts = :cod_acts
       </querytext>
    </fullquery>

    <fullquery name="sel_aces">
       <querytext>
                   select count(*) as conta
                     from coimaces
                    where cod_aces_est     = :cod_aces_est
                      and cod_combustibile = :cod_combustibile
                      and natura_giuridica = :natura_giuridica
                      and cognome          = :cognome
                      and nome             = :nome
                      and indirizzo        = :indirizzo
                      and numero           = :numero
                      and esponente        = :esponente
                      and scala            = :scala
                      and piano            = :piano
                      and interno          = :interno
                      and cap              = :cap
                      and localita         = :localita
                      and comune           = :comune
                      and provincia        = :provincia
                      and cod_fiscale_piva = :cod_fiscale_piva
                      and telefono         = :telefono
                      and data_nas         = :data_nas
                      and comune_nas       = :comune_nas
                      and consumo_annuo    = :consumo_annuo
                      and tariffa          = :tariffa
       </querytext>
    </fullquery>

    <partialquery name="ins_aces">
       <querytext>
                   insert
                     into coimaces
                        ( cod_aces
                        , cod_aces_est
                        , cod_acts
                        , natura_giuridica
                        , cod_combustibile
                        , cognome
                        , nome
                        , indirizzo
                        , numero
                        , esponente
                        , scala
                        , piano
                        , interno
                        , cap
                        , localita
                        , comune
                        , provincia
                        , cod_fiscale_piva
                        , telefono
                        , data_nas
                        , comune_nas
                        , consumo_annuo
                        , tariffa
                        , stato_01
                        , stato_02
                        , cod_cittadino
                        , cod_impianto
                        , data_ins
                        , utente)
                   values
                        ( :cod_aces
                        , upper(:cod_aces_est)
                        , :cod_acts
                        , upper(:natura_giuridica)
                        , upper(:cod_combustibile)
                        , upper(:cognome)
                        , upper(:nome)
                        , upper(:indirizzo)
                        , :numero
                        , upper(:esponente)
                        , upper(:scala)
                        , upper(:piano)
                        , upper(:interno)
                        , :cap
                        , upper(:localita)
                        , upper(:comune)
                        , upper(:provincia)
                        , upper(:cod_fiscale_piva)
                        , :telefono
                        , :data_nas
                        , upper(:comune_nas)
                        , :consumo_annuo
                        , :tariffa
                        , upper(:stato_01)
                        , upper(:stato_02)
                        , :cod_cittadino
                        , :cod_impianto
                        , :data_ins
                        , upper(:utente))
       </querytext>
    </partialquery>

    <fullquery name="sel_aces_2">
       <querytext>
              select nextval('coimaces_s') as cod_aces
       </querytext>
    </fullquery>

    <partialquery name="upd_acts">
       <querytext>
                 update coimacts
                    set caricati      = :caricati
                      , scartati      = :scartati
                      , invariati     = :invariati
                      , da_analizzare = :da_analizzare
                      , stato         = :stato_acts
                      , data_mod      =  current_date
                      , utente        = :id_utente
                  where cod_acts      = :cod_acts
                
       </querytext>
    </partialquery>

    <fullquery name="sel_count_aimp1">
       <querytext>
                   select count(*) as conta_aimp
                     from coimaimp 
                    where cod_amag         = upper(:cod_aces_est)
                   $where_dist
                      and cod_combustibile = upper(:cod_combustibile)
       </querytext>
    </fullquery>

    <fullquery name="sel_count_aimp2">
       <querytext>
                   select count(*) as conta_aimp
                     from coimaimp a
               inner join coimcomu b 
                       on b.cod_comune = a.cod_comune
               inner join coimprov c
                       on c.cod_provincia = a.cod_provincia
                    where a.toponimo||' '||a.indirizzo
                                             = upper(:indirizzo)
                      and a.numero           = :numero
                   $where_espo
                   $where_scala 
                   $where_piano 
                   $where_inte
                   $where_loc
                   $where_cons
                   $where_tari
                   $where_comu
                   $where_cap
                   $where_prov
       </querytext>
    </fullquery>


    <fullquery name="sel_count_aimp3">
       <querytext>
                   select count(*) as conta_aimp
                     from coimcitt a
                        , coimaimp b
                    where a.cognome           = upper(:cognome)
                   $where_nome
                      and a.natura_giuridica  = upper(:natura_giuridica)
                   $where_piva
                      and (
                              b.cod_intestatario = a.cod_cittadino
                           or b.cod_proprietario = a.cod_cittadino
                           or b.cod_occupante    = a.cod_cittadino)
       </querytext>
    </fullquery>

</queryset>
