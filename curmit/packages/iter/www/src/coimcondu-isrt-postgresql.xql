<?xml version="1.0"?>
<!--
    USER  DATA       MODIFICHE
    ===== ========== =========================================================================

-->
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_condu">
        <querytext>
                 insert
                  into coimcondu 
                     ( cod_conduttore
                     , cognome
                     , nome
                     , cod_fiscale
                     , indirizzo
                     , cap
                     , comune
                     , provincia
                     , telefono
                     , cellulare
                     , fax
                     , email
                     , pec
		     , data_patentino
                     , ente_rilascio_patentino
                     )
                values 
                     (:cod_conduttore
                     ,upper(:cognome)
                     ,upper(:nome)
                     ,upper(:cod_fiscale)
                     ,upper(:indirizzo)
                     ,:cap
                     ,upper(:comune)
                     ,upper(:provincia)
                     ,:telefono
                     ,:cellulare
                     ,:fax
                     ,:email
                     ,:pec
                     ,:data_patentino
                     ,:ente_rilascio_patentino                     
		     )
       </querytext>
    </partialquery>


    <fullquery name="sel_cod">
        <querytext>
           select nextval('coimcondu_s') as cod_conduttore
       </querytext>
    </fullquery>

    <fullquery name="sel_comu_desc">
        <querytext>
             select denominazione as comu_denom
               from coimcomu
              where cod_comune = :cod_comune
       </querytext>
    </fullquery>

</queryset>
