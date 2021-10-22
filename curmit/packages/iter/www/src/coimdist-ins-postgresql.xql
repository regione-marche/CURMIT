<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_dist">
       <querytext>
                      select cod_distr
                           , ragione_01||' '||coalesce(ragione_02,'') as ragione_01
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
                     from coimddis
		    where cod_distr = :cod_distr
       </querytext>
    </fullquery>

    <fullquery name="sel_prov_join">
       <querytext>
                   select b.sigla as provincia
		        , a.cap
                        , a.denominazione as comune
		     from coimcomu a
		        , coimprov b 
                    where a.cod_comune    = :cod_comune 
		      and b.cod_provincia = a.cod_provincia 
       </querytext>
    </fullquery>

    <partialquery name="ins_dist">
       <querytext>
                   insert
                     into coimddis 
                        ( cod_distr
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
                        , utente
                        , id_utente)
                   values 
                       (:cod_distr
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
		       ,:cod_distr
                       ,:cod_distr)
       </querytext>
    </partialquery>

    <partialquery name="ins_uten">
       <querytext>
                insert
                  into coimuten 
                     ( id_utente
                     , cognome
                     , nome
                     , password
                     , id_settore
                     , id_ruolo
                     , e_mail
                     , rows_per_page
                     , livello)
                values 
                     (:cod_distr
                     ,upper(:ragione_01)
                     ,''
                     ,'cambiami'
                     ,'distributore'
                     ,'utente'
                     ,:email
                     ,'10'
                     ,'4')
       </querytext>
    </partialquery>

    <partialquery name="upd_dist">
       <querytext>
                update coimddis
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
		     , id_utente   = :cod_distr
                 where cod_distr   = :cod_distr
       </querytext>
    </partialquery>

    <partialquery name="del_dist">
       <querytext>
                   delete
		     from coimdist
		    where cod_distr = :cod_distr
       </querytext>
    </partialquery>

    <fullquery name="sel_dual_date">
       <querytext>
                   select to_char(current_date, 'yyyymmdd') as current_date 
       </querytext>
    </fullquery>

    <fullquery name="sel_comu_count">
       <querytext>
                   select count (*) as conta_com
		     from coimcomu_v
		    where upper(denominazione) = upper(:comune)
		      and fine_nome_dt is null 
       </querytext>
    </fullquery>

    <fullquery name="sel_comu">
       <querytext>
                   select codice_istat
                     from coimcomu_v
                    where upper(denominazione) = upper(:comune)
                      and fine_nome_dt is null 
       </querytext>
    </fullquery>

    <fullquery name="sel_dist_cf">
       <querytext>
                   select '1'
                     from coimdist
                    where cod_fiscale = :cod_fiscale 
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
                   select *
                     from coimmanu
                    where cod_piva = :cod_piva
       </querytext>
    </fullquery>

    <fullquery name="sel_dist_s">
       <querytext>
                   select nextval ('coimdist_s') as cod_distr
       </querytext>
    </fullquery>

</queryset>
