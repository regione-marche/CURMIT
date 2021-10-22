<?xml version="1.0"?>
<!--
    USER  DATA       MODIFICHE
    ===== ========== =========================================================================

-->
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="del_condu">
        <querytext>
                delete
                  from coimcondu
                 where cod_conduttore = :cod_conduttore 
       </querytext>
    </partialquery>


    <partialquery name="mod_condu">
        <querytext>
                 update coimcondu
                   set cognome                 = upper(:cognome)
                     , nome                    = upper(:nome)
                     , indirizzo               = upper(:indirizzo)
                     , cap                     = :cap
                     , comune                  = upper(:comune)
                     , provincia               = upper(:provincia)
                     , cod_fiscale             = upper(:cod_fiscale)
                     , telefono                = :telefono
                     , cellulare               = :cellulare
                     , fax                     = :fax
                     , email                   = :email
                     , pec                     = :pec               
                     , data_patentino          = :data_patentino
                     , ente_rilascio_patentino = :ente_rilascio_patentino
                 where cod_conduttore    = :cod_conduttore
       </querytext>
    </partialquery>

    <partialquery name="ins_condu">
        <querytext>
                 insert
                  into coimcondu 
                     ( cod_conduttore
                     , cognome
                     , nome
                     , indirizzo
                     , cap
                     , comune
                     , provincia
                     , cod_fiscale
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
                     ,upper(:indirizzo)
                     ,:cap
                     ,upper(:comune)
                     ,upper(:provincia)
                     ,upper(:cod_fiscale)
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

    <fullquery name="sel_condu_chk">
        <querytext> 
        select '1'
          from coimcondu
         where cod_conduttore = :cod_conduttore
       </querytext>
    </fullquery>

    <fullquery name="sel_condu">
        <querytext>
              select cod_conduttore
                  , cognome
                  , nome
                  , indirizzo
                  , cap
                  , comune
                  , provincia
                  , cod_fiscale
                  , telefono
                  , cellulare
                  , fax
                  , email
                  , pec
                  , iter_edit_data(data_patentino) as data_patentino
                  , ente_rilascio_patentino
               from coimcondu
              where cod_conduttore = :cod_conduttore
       </querytext>
    </fullquery>
</queryset>
