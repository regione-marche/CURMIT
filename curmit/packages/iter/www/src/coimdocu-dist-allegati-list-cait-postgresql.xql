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

   <fullquery name="sel_count_H">
       <querytext>
           select count(*)
             from coim_as_resp a
            where flag_tracciato = 'HMANU'
            and a.utente = :id_utente
            and a.cod_manutentore = :f_cod_manu
            and cod_docu_distinta is null
       </querytext>
    </fullquery>
    
     <fullquery name="sel_count_I">
       <querytext>
           select count(*)
             from coim_as_resp a
            where flag_tracciato = 'IMANU'
            and a.utente = :id_utente
            and a.cod_manutentore = :f_cod_manu
            and cod_docu_distinta is null
       </querytext>
    </fullquery>
    
     <fullquery name="sel_count_L">
       <querytext>
           select count(*)
             from coim_as_resp a
            where flag_tracciato = 'LMANU'
            and a.utente = :id_utente
            and a.cod_manutentore = :f_cod_manu
            and cod_docu_distinta is null
       </querytext>
    </fullquery>

    <partialquery name="sel_allegati">
       <querytext>
           select a.cod_as_resp
           		, case a.flag_tracciato 
           			when 'HMANU' then 'H'
           			when 'IMANU' then 'I'
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
 	where a.cod_manutentore = :f_cod_manu
 			and a.utente = :id_utente
        	and cod_docu_distinta is null
	order by a.flag_tracciato
			, a.data_ins
       </querytext>
    </partialquery>

    <partialquery name="sel_all_ammi">
       <querytext>
           select b.cod_cittadino 
                , coalesce(b.cognome,' ')||' '||coalesce(b.nome,' ') as nominativo_ammi
                , count(*) as n_allegati
             from coim_as_resp a
  left outer join coimcitt b on b.cod_cittadino  = a.cod_legale_rapp
			where a.cod_docu_distinta is null
              and a.utente = :id_utente
              and flag_tracciato = 'LMANU'
              and cod_legale_rapp = :cod_legale_rapp
         group by b.cod_cittadino
                , nominativo_ammi
         order by b.cod_cittadino
       </querytext>
    </partialquery>

</queryset>
