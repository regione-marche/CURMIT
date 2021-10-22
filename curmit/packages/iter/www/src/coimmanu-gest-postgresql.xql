<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_manu">
       <querytext>
                       select a.cod_manutentore
			    , a.cognome
			    , a.nome
			    , a.indirizzo
			    , a.localita
			    , a.provincia
			    , a.cap
			    , a.comune
			    , a.cod_fiscale
			    , a.cod_piva
			    , a.telefono
			    , a.cellulare
			    , a.fax
			    , a.email
			    , a.reg_imprese
			    , a.localita_reg
			    , a.rea
			    , a.localita_rea
			    , iter_edit_num(a.capit_sociale, 2) as capit_sociale
			    , a.note
                            , a.flag_convenzionato
                            , a.flag_attivo
			    , a.prot_convenzione
                            , iter_edit_data(a.prot_convenzione_dt) as prot_convenzione_dt
                            , a.flag_ruolo
                            , iter_edit_data(a.data_inizio) as data_inizio
                            , iter_edit_data(a.data_fine) as data_fine
                            , a.cod_legale_rapp
                            , b.nome as nome_rapp
                            , b.cognome as cognome_rapp
                            , a.pec
                            , a.patentino   --sim02
                            , a.patentino_fgas --sim04
			 from coimmanu a
              left outer join coimcitt b on b.cod_cittadino = a.cod_legale_rapp
		        where a.cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

   
    <partialquery name="ins_manu">
       <querytext>
                   insert
                     into coimmanu 
                        ( cod_manutentore
			, cognome
			, nome
			, indirizzo
			, localita
			, provincia
			, cap
			, comune
			, cod_fiscale
			, cod_piva
			, telefono
			, cellulare
			, fax
			, email
			, reg_imprese
			, localita_reg
			, rea
			, localita_rea
			, capit_sociale
			, note
			, data_ins
			, utente
                        , flag_convenzionato
			, prot_convenzione
                        , prot_convenzione_dt
                        , flag_ruolo
                        , data_inizio
                        , data_fine
                        , cod_legale_rapp
                        , flag_attivo
                        , pec
                        , patentino   --sim02
                        , patentino_fgas --sim04
                        )
	           values 
			(:cod_manutentore
			,upper(:cognome)
			,upper(:nome)
			,upper(:indirizzo)
			,upper(:localita)
			,upper(:provincia)
			,:cap
			,upper(:comune)
			,upper(:cod_fiscale)
			,:cod_piva
			,:telefono
			,:cellulare
			,:fax
			,:email
			,:reg_imprese
			,upper(:localita_reg)
			,:rea
			,upper(:localita_rea)
			,:capit_sociale
			,:note
			,current_date
			,:id_utente
                        ,:flag_convenzionato
			,:prot_convenzione
                        ,:prot_convenzione_dt
                        ,:flag_ruolo
                        ,:data_inizio
                        ,:data_fine
                        ,:cod_legale_rapp
                        ,:flag_attivo
                        ,:pec
                        ,:patentino   --sim02
                        ,:patentino_fgas --sim04
                        )
       </querytext>
    </partialquery>

    <partialquery name="upd_manu">
       <querytext>
                 update coimmanu
                    set cognome         = upper(:cognome)
                      , nome            = upper(:nome)
                      , indirizzo       = upper(:indirizzo)
                      , localita        = upper(:localita)
                      , provincia       = upper(:provincia)
                      , cap             = :cap
                      , comune          = upper(:comune)
                      , cod_fiscale     = upper(:cod_fiscale)
                      , cod_piva        = :cod_piva
                      , telefono        = :telefono
                      , cellulare       = :cellulare
                      , fax             = :fax
                      , email           = :email
                      , reg_imprese     = :reg_imprese
                      , localita_reg    = upper(:localita_reg)
                      , rea             = :rea
                      , localita_rea    = upper(:localita_rea)
                      , capit_sociale   = :capit_sociale
                      , note            = :note
                      , data_mod        = current_date
                      , utente          = :id_utente
                      , flag_convenzionato  = :flag_convenzionato
                      , flag_attivo         = :flag_attivo
                      , prot_convenzione    = :prot_convenzione
                      , prot_convenzione_dt = :prot_convenzione_dt
                      , flag_ruolo          = :flag_ruolo
                      , data_inizio         = :data_inizio
                      , data_fine           = :data_fine
                      , cod_legale_rapp     = :cod_legale_rapp
                      , pec                 = :pec
                      , patentino           = :patentino   --sim01
                      , patentino_fgas      = :patentino_fgas --sim04
                  where cod_manutentore = :cod_manutentore
                
       </querytext>
    </partialquery>

    <partialquery name="del_manu">
       <querytext>
                   delete
		     from coimmanu
		    where cod_manutentore = :cod_manutentore
       </querytext>
    </partialquery>

    <fullquery name="sel_aimp">
       <querytext>
          select count(*) as conta_aimp
             from coimaimp
           where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_legale">
       <querytext>
          select count(*) as conta_legale
             from coimaimp
           where cod_responsabile = :cod_legale_rapp_old
             and flag_resp = 'T'
       </querytext>
    </fullquery>

    <fullquery name="sel_boll">
       <querytext>
          select count(*) as conta_boll
             from coimboll
           where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_coma">
       <querytext>
          select count(*) as conta_coma
             from coimcoma
           where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp">
       <querytext>
          select count(*) as conta_dimp
             from coimdimp
           where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_mtar">
       <querytext>
          select count(*) as conta_mtar
             from coimmtar
           where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_dual_date">
       <querytext>
                   select to_char(current_date, 'yyyymmdd') as current_date 
       </querytext>
    </fullquery>
   
    <fullquery name="sel_manu_s">
       <querytext>
                   select 'MA'||nextval('coimmanu_s') as cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_manu_lpad_s">
       <querytext>
                   select 'MA'|| lpad(nextval('coimmanu_s'), 6, '0') as cod_manutentore
       </querytext>
    </fullquery>

</queryset>
