<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_enve">
       <querytext>
                      select cod_enve
                           , ragione_01
                           , ragione_02
			   , indirizzo
			   , numero
			   , localita
			   , comune
			   , provincia
			   , cap
			   , cod_fiscale
			   , cod_piva
			   , telefono
			   , cellulare
                           , note
			   , fax
			   , email
                           , tracciato
			   , data_ins
			   , utente 
                     from coimenve
		    where cod_enve = :cod_enve
       </querytext>
    </fullquery>

    <partialquery name="ins_enve">
       <querytext>
                   insert
                     into coimenve 
                        ( cod_enve
                        , ragione_01
                        , ragione_02
                        , indirizzo
                        , numero
                        , cap
                        , localita
                        , comune
                        , provincia
                        , cod_fiscale
                        , cod_piva
                        , telefono
                        , cellulare
                        , fax
                        , email
                        , note
                        , tracciato
                        , data_ins
                        , utente)
                   values 
                       (:cod_enve
                       ,upper(:ragione_01)
                       ,upper(:ragione_02)
                       ,upper(:indirizzo)
                       ,:numero
                       ,:cap
                       ,upper(:localita)
                       ,upper(:comune)
                       ,upper(:provincia)
                       ,upper(:cod_fiscale)
                       ,:cod_piva
                       ,:telefono
                       ,:cellulare
                       ,:fax
                       ,:email
                       ,:note
                       ,:tracciato
                       ,:current_date
		       ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_enve">
       <querytext>
                update coimenve
                   set ragione_01  = upper(:ragione_01)
                     , ragione_02  = upper(:ragione_02)
                     , indirizzo   = upper(:indirizzo)
                     , numero      = :numero
                     , cap         = :cap
                     , localita    = upper(:localita)
                     , comune      = upper(:comune)
                     , provincia   = upper(:provincia)
                     , cod_fiscale = upper(:cod_fiscale)
                     , cod_piva    = :cod_piva
                     , telefono    = :telefono
                     , cellulare   = :cellulare
                     , fax         = :fax
                     , email       = :email
                     , note        = :note
                     , tracciato   = :tracciato
                     , data_mod    = :current_date
		     , utente      = :id_utente
                 where cod_enve    = :cod_enve
       </querytext>
    </partialquery>

    <partialquery name="del_enve">
       <querytext>
                   delete
		     from coimenve
		    where cod_enve = :cod_enve
       </querytext>
    </partialquery>

    <fullquery name="sel_enve_s">
       <querytext>
                   select 'VE'||nextval('coimenve_s') as cod_enve
       </querytext>
    </fullquery>

    <partialquery name="ins_opve">
       <querytext>
                insert
                  into coimopve 
                     ( cod_opve
                     , cod_enve
                     , cognome
                     , nome
                     , stato)
                values 
                     (:cod_opve
                     ,:cod_enve
                     ,'Operatore'
                     ,'Generico'
                     ,'1')
       </querytext>
    </partialquery>

    <fullquery name="sel_opve">
       <querytext>
                   select cod_opve
                     from coimopve
                    where cod_enve = :cod_enve
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_count">
       <querytext>
         select count(*) as conta_inco
           from coiminco
          where cod_opve = :cod_opve
       </querytext>
    </fullquery>

    <partialquery name="del_opve">
       <querytext>
                delete
                  from coimopve
                 where cod_enve = :cod_enve
       </querytext>
    </partialquery>

</queryset>
