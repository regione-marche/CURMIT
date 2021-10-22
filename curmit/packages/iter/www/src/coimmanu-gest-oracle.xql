<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>


    <fullquery name="sel_manu">
       <querytext>
                       select cod_manutentore
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
			    , iter_edit.num(capit_sociale, 2) as capit_sociale
			    , note
                            , flag_convenzionato
			    , prot_convenzione
                            , iter_edit.data(prot_convenzione_dt) as prot_convenzione_dt
                            , flag_ruolo
                            , iter_edit.data(data_inizio) as data_inizio
                            , iter_edit.data(data_fine) as data_fine
			 from coimmanu
		        where cod_manutentore = :cod_manutentore
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
                        , data_fine)
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
			,sysdate
			,:id_utente
                        ,:flag_convenzionato
                        ,:prot_convenzione
                        ,:prot_convenzione_dt
                        ,:flag_ruolo
                        ,:data_inizio
                        ,:data_fine)

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
                      , data_mod        = sysdate
                      , utente          = :id_utente
                      , flag_convenzionato = :flag_convenzionato
                      , prot_convenzione   = :prot_convenzione
                      , prot_convenzione_dt = :prot_convenzione_dt
                      , flag_ruolo          = :flag_ruolo
                      , data_inizio         = :data_inizio
                      , data_fine           = :data_fine
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
                   select to_char(sysdate, 'yyyymmdd') as current_date 
                     from dual
       </querytext>
    </fullquery>
   

    
    <fullquery name="sel_manu_s">
       <querytext>
                   select 'MA'||coimmanu_s.nextval as cod_manutentore
                     from dual
       </querytext>
    </fullquery>

</queryset>
