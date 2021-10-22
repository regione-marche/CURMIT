<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_docu_si_viae">
       <querytext>
          select iter_edit_data(a.data_documento) as data_stampa
               , a.protocollo_01
               , b.data_verifica
               , b.cod_inco
               , b.cod_opve
               , b.tipo_estrazione
               , coalesce(c.nome, '')||' '||coalesce(c.cognome, '') as nome_opve
               , b.ora_verifica
               , d.cod_impianto_est
               , coalesce(e.descr_topo,'') as topoimp
               , coalesce(e.descr_topo,'')||' '||coalesce(e.descrizione,'')||' '||coalesce(d.numero,'')||' '||coalesce(d.esponente,'') as indirimp
               , coalesce(d.numero,'')||' '||coalesce(d.esponente,'') as civicimp
               , coalesce(f.denominazione, '') as locaimp
               , e.cap as capimp
               , coalesce(g.indirizzo,'') as indiresp
               , coalesce(g.localita, '')||' '||coalesce(g.comune, '') as locaresp
               , g.cap as capresp
               , g.provincia as provresp
               , coalesce(g.cognome, '')||' '||coalesce(g.nome, '') as nom_resp
               , d.flag_resp        -- 13/11/2013
               , d.cod_responsabile -- 13/11/2013
            from coimdocu a
      inner join coiminco b on a.cod_documento = b.cod_documento_01
 left outer join coimopve c on c.cod_opve      = b.cod_opve
      inner join coimaimp d on d.cod_impianto  = a.cod_impianto
 left outer join coimviae e on e.cod_via       = d.cod_via
                           and e.cod_comune    = d.cod_comune
 left outer join coimcomu f on f.cod_comune    = d.cod_comune
 left outer join coimcitt g on g.cod_cittadino = d.cod_responsabile
           where a.data_documento = :f_data_stampa
             and a.tipo_documento = :f_tipo_documento
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_no_viae">
       <querytext>
          select iter_edit_data(a.data_documento) as data_stampa
               , a.protocollo_01
               , b.data_verifica
               , coalesce(c.nome, '')||' '||coalesce(c.cognome, '') as nome_opve
               , b.ora_verifica
               , d.cod_impianto_est
               , null as topoimp
               , coalesce(d.indirizzo,'') as indirimp
               , coalesce(d.numero,'')||' '||coalesce(d.esponente,'') as civicimp
               , coalesce(d.localita, '')||' '||coalesce(f.denominazione, '') as locaimp
               , d.cap as capimp
               , coalesce(g.indirizzo,'') as indiresp
               , coalesce(g.localita, '')||' '||coalesce(g.comune, '') as locaresp
               , g.cap as capresp
               , coalesce(g.cognome, '')||' '||coalesce(g.nome, '') as nom_resp
               , d.flag_resp        -- 13/11/2013
               , d.cod_responsabile -- 13/11/2013
            from coimdocu a
      inner join coiminco b on a.cod_documento = b.cod_documento_01
 left outer join coimopve c on c.cod_opve      = b.cod_opve
      inner join coimaimp d on d.cod_impianto  = a.cod_impianto
 left outer join coimcomu f on f.cod_comune    = d.cod_comune
 left outer join coimcitt g on g.cod_cittadino = d.cod_responsabile
           where a.data_documento = :f_data_stampa
             and a.tipo_documento = :f_tipo_documento
       </querytext>
    </fullquery>

    <fullquery name="sel_manu_resp">
       <querytext>--13/11/2013
                select 'C/O '||coalesce(indirizzo,'')                  as indiresp
                     , coalesce(localita,'')||' '||coalesce(comune,'') as locaresp
                     , cap                                             as capresp
                     , provincia                                       as provresp
                  from coimmanu
                 where cod_legale_rapp = :cod_responsabile
              order by cod_manutentore
                 limit 1
       </querytext>
    </fullquery>

</queryset>
