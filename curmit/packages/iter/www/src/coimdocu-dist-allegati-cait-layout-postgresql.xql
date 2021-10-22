<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_uten">
       <querytext>
           select cognome   as uten_cognome
                , nome      as uten_nome
             from coimuten
            where id_utente = :id_utente
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
           select cognome   as manu_cognome
                , nome      as manu_nome
             from coimmanu
            where cod_manutentore = :f_cod_manu
       </querytext>
    </fullquery>

    <partialquery name="sel_codici_manu">
       <querytext>
           select distinct(a.cod_manutentore) as f_cod_manu
             from coim_as_resp a
       inner join coimaimp b on b.cod_impianto  = a.cod_impianto
              and a.cod_docu_distinta is null
              and a.utente 			= :id_utente
              and flag_tracciato 	<> 'LMANU'
         order by a.cod_manutentore
       </querytext>
    </partialquery>
    
    <fullquery name="sel_legale">
       <querytext>
            select cognome as cognome_legale,
                   nome as nome_legale
              from coimcitt
             where cod_cittadino = :cod_legale_rapp
       </querytext>
    </fullquery>

    <partialquery name="sel_allegati">
       <querytext>
           select cod_as_resp
           		, case a.flag_tracciato 
           			when 'HMANU' then 'H'
           			when 'IMANU' then 'I'
           			when 'LMANU' then 'L'
           		  end as flag_tracciato 
				, d.cod_impianto_est
				, iter_edit_data(a.data_ins) as data_ins_edit
				, coalesce(b.cognome,' ')||' '||coalesce(b.nome,' ') as responsabile
				, c.denominazione as comune
				, coalesce($nome_col_toponimo,'')||' '||
                  coalesce($nome_col_via,'')||
                  case
                    when a.numero is null then ''
                    else ', '||a.numero
                  end ||
                  case
                    when a.esponente is null then ''
                    else '/'||a.esponente
                  end ||
                  case
                    when a.scala is null then ''
                    else ' S.'||a.scala
                  end ||
                  case
                    when a.piano is null then ''
                    else ' P.'||a.piano
                  end ||
                  case
                    when a.interno is null then ''
                    else ' Int.'||a.interno
                  end as indirizzo
				, a.potenza
		from coim_as_resp a
  	left outer join coimcitt b on b.cod_cittadino = a.cod_responsabile
  	left outer join coimcomu c on c.cod_comune    = a.cod_comune
  	left outer join coimaimp d on d.cod_impianto  = a.cod_impianto
            $from_coimviae
    where $where_cod_manu
 			and a.utente = :id_utente
        	and cod_docu_distinta is null
	order by a.flag_tracciato
			, a.data_ins
              
       </querytext>
    </partialquery>

    <fullquery name="sel_docu_s">
       <querytext>
           select nextval('coimdocu_s')
       </querytext>
    </fullquery>

    <partialquery name="ins_docu">
       <querytext>
           insert
             into coimdocu 
                ( cod_documento
                , cod_soggetto
                , tipo_soggetto
                , tipo_documento
                , cod_impianto
                , data_stampa
                , data_documento
                , data_ins
                , data_mod
                , utente)
           values 
                (:cod_documento
                ,:cod_soggetto
                ,:tipo_soggetto
                ,:tipo_documento
                ,:cod_impianto
                ,:data_stampa
                ,:data_documento
                ,:data_ins
                ,:data_mod
                ,:utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_docu_ins_dist">
       <querytext>
            update coimdocu
               set tipo_contenuto = :tipo_contenuto
                 , contenuto      = lo_import(:contenuto_tmpfile)
             where cod_documento  = :cod_documento
       </querytext>
    </partialquery> 

     <fullquery name="upd_as_resp">
       <querytext>
            update coim_as_resp
               set cod_docu_distinta = :cod_docu_distinta
               , cod_manutentore 	 = :f_cod_manu
             where cod_as_resp       = :cod_as_resp
       </querytext>
    </fullquery> 

</queryset>
