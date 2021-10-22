<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_prog">
       <querytext>
                       select cod_progettista
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
			    , iter_edit_num(capit_sociale, 2) as capit_sociale
			    , note
			 from coimprog
		        where cod_progettista = :cod_progettista
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp">
       <querytext>
                       select count(*) as conta_aimp
			 from coimaimp
		        where cod_progettista = :cod_progettista
       </querytext>
    </fullquery>

   
    <partialquery name="ins_prog">
       <querytext>
                   insert
                     into coimprog
                        ( cod_progettista
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
			, utente)
	           values 
			(:cod_progettista
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
			,:id_utente)

       </querytext>
    </partialquery>

    <partialquery name="upd_prog">
       <querytext>
                 update coimprog
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
                  where cod_progettista = :cod_progettista
                
       </querytext>
    </partialquery>

    <partialquery name="del_prog">
       <querytext>
                   delete
		     from coimprog
		    where cod_progettista = :cod_progettista
       </querytext>
    </partialquery>

    <fullquery name="sel_dual_date">
       <querytext>
                   select to_char(current_date, 'yyyymmdd') as current_date 
       </querytext>
    </fullquery>
   

    
    <fullquery name="sel_prog_s">
       <querytext>
                   select nextval ('coimprog_s') as cod_progettista
       </querytext>
    </fullquery>

</queryset>
