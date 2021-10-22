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
    
     <fullquery name="sel_count_L">
       <querytext>
           select count(*)
             from coim_as_resp a
            where flag_tracciato = 'LMANU'
            $where_utente
            and cod_docu_distinta is null
       </querytext>
    </fullquery>

    <partialquery name="sel_allegati">
       <querytext>
           select a.cod_as_resp
           		, case a.flag_tracciato 
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
    where 1=1
        	$where_utente
        	and cod_docu_distinta is null
	order by a.flag_tracciato
			, a.data_ins
              
       </querytext>
    </partialquery>

</queryset>
