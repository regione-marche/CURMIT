<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

   <fullquery name="sel_desc_count">
       <querytext>
                   select count(*) as conta_desc 
		     from coimdesc   
       </querytext>
    </fullquery>

    <partialquery name="ins_desc">
       <querytext>
                insert
                  into coimdesc 
                     ( cod_desc
                     , nome_ente
                     , tipo_ufficio
                     , assessorato
                     , indirizzo
                     , telefono
                     , resp_uff
                     , uff_info
                     , dirigente)
                values 
                     (1
                     ,:nome_ente
                     ,:tipo_ufficio
                     ,:assessorato
                     ,:indirizzo
                     ,:telefono
                     ,:resp_uff
                     ,:uff_info
                     ,:dirigente)
       </querytext>
    </partialquery>

    <partialquery name="upd_desc">
       <querytext>
                update coimdesc
                   set nome_ente = :nome_ente
                     , tipo_ufficio = :tipo_ufficio
                     , assessorato = :assessorato
                     , indirizzo = :indirizzo
                     , telefono = :telefono
                     , resp_uff = :resp_uff
                     , uff_info = :uff_info
                     , dirigente = :dirigente
                 where cod_desc = :cod_desc
       </querytext>
    </partialquery>

    <partialquery name="del_desc">
       <querytext>
                delete
                  from coimdesc
                 where cod_desc = :cod_desc
       </querytext>
    </partialquery>

    <fullquery name="sel_desc">
       <querytext>
             select iter_edit_num(cod_desc, 0) as cod_desc
                  , nome_ente
                  , tipo_ufficio
                  , assessorato
                  , indirizzo
                  , telefono
                  , resp_uff
                  , uff_info
                  , dirigente
               from coimdesc
              where cod_desc = :cod_desc
       </querytext>
    </fullquery>

    <fullquery name="sel_desc_check">
       <querytext>
        select '1'
          from coimdesc
         where cod_desc = :cod_desc
       </querytext>
    </fullquery>

</queryset>
