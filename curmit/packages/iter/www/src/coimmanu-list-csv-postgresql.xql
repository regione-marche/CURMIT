<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>


    <partialquery name="sel_manu">
       <querytext>
select a.cod_manutentore
     , a.cognome
     , coalesce (a.cognome, ' ') ||' '|| coalesce (a.nome, ' ') as rag_soc
     , a.indirizzo
     , a.localita
     , a.provincia
     , a.cap
     , a.comune
     , a.cod_fiscale
     , ''''||a.cod_piva as cod_piva
     , ''''||a.telefono as telefono
     , ''''||a.cellulare as cellulare
     , a.fax
     , a.email
     , a.pec
     , a.reg_imprese
     , a.localita_reg
     , a.rea
     , a.localita_rea
     , a.capit_sociale
     , a.note
     , case a.flag_convenzionato
       when 'S' then 'Si'
       when 'N' then 'No'
       else ''
       end as flag_convenzionato
     , a.prot_convenzione
     , iter_edit_data(a.prot_convenzione_dt) as prot_convenzione_dt
     , case a.flag_ruolo
       when 'M' then 'Manutentore'
       when 'I' then 'Installatore'
       when 'T' then 'Manutentore/Installatore'
       else ''
       end as flag_ruolo
     , iter_edit_data(a.data_inizio) as data_inizio
     , iter_edit_data(a.data_fine) as data_fine
     , coalesce (b.cognome, ' ') ||' '|| coalesce (b.nome, ' ') as legale_rap
      ,b.indirizzo as legale_ind
     , b.localita as legale_loc
     , b.provincia as legale_prov
     , b.cap as legale_cap
     , b.comune as legale_comune
     , b.cod_fiscale as legale_cf
    from coimmanu a
    left join coimcitt b on b.cod_cittadino = cod_legale_rapp
        where 1 = 1
 $where_cognome
 $where_nome
 $where_cod_manutentore
 $where_ruolo
 $where_convenzionato
 $where_stato
order by cognome
       </querytext>
    </partialquery>

</queryset>
