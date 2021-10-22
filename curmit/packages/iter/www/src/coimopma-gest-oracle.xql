<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_enve">
       <querytext>
                 select ragione_01||' '||nvl(ragione_02,'') as nome_enve
                   from coimenve
                  where cod_enve = :cod_enve
       </querytext>
    </partialquery>

    <partialquery name="ins_opve">
       <querytext>
                insert
                  into coimopve 
                     ( cod_opve
                     , cod_enve
                     , cognome
                     , nome
                     , matricola
                     , stato
		     , telefono
		     , cellulare
		     , recapito
		     , data_ins
		     , utente
                     , codice_fiscale
                     , note
                     , cod_listino
                     , marca_strum
                     , modello_strum
                     , matr_strum
                     , dt_tar_strum
                     , strumento)
                values 
                     (:cod_opve
                     ,:cod_enve
                     ,:cognome
                     ,:nome
                     ,:matricola
                     ,:stato
		     ,:telefono
		     ,:cellulare
		     ,:recapito
		     ,sysdate
		     ,:id_utente
                     ,:codice_fiscale
                     ,:note
                     ,:cod_listino
                     ,:marca_strum
                     ,:modello_strum
                     ,:matr_strum
                     ,:dt_tar_strum
                     ,:strumento)
       </querytext>
    </partialquery>

    <partialquery name="upd_opve">
       <querytext>
                update coimopve
                   set cognome   = :cognome
                     , nome      = :nome
                     , matricola = :matricola
                     , stato     = :stato
		     , telefono  = :telefono
		     , cellulare = :cellulare
		     , recapito  = :recapito
		     , data_mod  = sysdate
		     , utente    = :id_utente
                     , codice_fiscale = :codice_fiscale
                     , note      = :note
                     , cod_listino = :cod_listino
                     , marca_strum = :marca_strum
                     , modello_strum = :modello_strum
                     , matr_strum = :matr_strum
                     , dt_tar_strum = :dt_tar_strum
                     , strumento = :strumento
                 where cod_opve  = :cod_opve
       </querytext>
    </partialquery>

    <partialquery name="del_opve">
       <querytext>
                delete
                  from coimopve
                 where cod_opve = :cod_opve
       </querytext>
    </partialquery>

    <fullquery name="sel_opve">
       <querytext>
             select cod_opve
                  , cod_enve
                  , cognome
                  , nome
                  , matricola
                  , stato
		  , telefono
		  , cellulare
		  , recapito
                  , codice_fiscale
                  , note
                  , cod_listino
                  , marca_strum
                  , modello_strum
                  , matr_strum
                  , iter_edit_data(dt_tar_strum) as dt_tar_strum
                  , strumento
               from coimopve
              where cod_opve = :cod_opve
       </querytext>
    </fullquery>

    <fullquery name="sel_opve_check">
       <querytext>
        select '1'
          from coimopve
         where upper(cognome)   = upper(:cognome)
           and upper(nome)      = upper(:nome)
           and upper(matricola) = upper(:matricola)
       </querytext>
    </fullquery>


    <fullquery name="sel_opve_s">
       <querytext>
         select :cod_enve||trim(to_char(max(substr(cod_opve,5,3)) + 1, '999000')) as cod_opve 
           from coimopve 
          where cod_enve = :cod_enve
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_count">
       <querytext>
         select count(*) as conta_inco
           from coiminco
          where cod_opve = :cod_opve
            and cod_impianto is not null
       </querytext>
    </fullquery>

    <partialquery name="del_disp">
       <querytext>
                delete
                  from coiminco
                 where cod_opve = :cod_opve
		   and cod_impianto is null
       </querytext>
    </partialquery>


</queryset>
