<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

   
    <partialquery name="del_cqua">
       <querytext>
                   delete
                     from coimcqua
                    where cod_comune = :cod_comune
                      and cod_qua    = :cod_qua
       </querytext>
    </partialquery>

    <partialquery name="upd_cqua">
       <querytext>
                   update coimcqua
                      set descrizione = :descrizione
                    where cod_comune  = :cod_comune
                      and cod_qua     = :cod_qua
       </querytext>
    </partialquery>

    <partialquery name="ins_cqua">
       <querytext>
                   insert
                     into coimcqua 
                        ( cod_qua
                        , cod_comune
                        , descrizione)
                   values 
                        (:cod_qua
                        ,:cod_comune
                        ,:descrizione)
       </querytext>
    </partialquery>
   

    <fullquery name="sel_cqua_check_2">
       <querytext>
                    select '1'
                      from coimcqua
                     where cod_comune = :cod_comune 
                       and cod_qua    = :cod_qua
       </querytext>
    </fullquery>

    <fullquery name="sel_cqua_check_1">
       <querytext>
                    select '1'
                      from coimcqua
                     where upper(descrizione) = upper(:descrizione)
                     $where_cod
       </querytext>
    </fullquery>

    <fullquery name="sel_cqua">
       <querytext>
                    select a.descrizione
                         , b.denominazione as comune
                      from coimcqua a
                         , coimcomu b 
                     where a.cod_qua        = :cod_qua
                       and a.cod_comune     = :cod_comune
                       and b.cod_comune (+) = a.cod_comune 
       </querytext>
    </fullquery>
  
</queryset>
