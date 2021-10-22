<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="del_curb">
       <querytext>
                   delete
                     from coimcurb
                    where cod_urb = :cod_urb
       </querytext>
    </partialquery>

    <partialquery name="upd_curb">
       <querytext>
                    update coimcurb
                       set descrizione = :descrizione
                     where cod_urb     = :cod_urb
       </querytext>
    </partialquery>

    <partialquery name="ins_curb">
       <querytext>
                   insert
                     into coimcurb 
                        ( cod_urb
                        , cod_comune
                        , descrizione)
                   values 
                        (:cod_urb
                        ,:cod_comune
                        ,:descrizione)
       </querytext>
    </partialquery>

    <fullquery name="sel_curb_check_2">
       <querytext>
                    select '1'
                      from coimcurb
                     where upper(descrizione) = upper(:descrizione)
                     $where_cod
       </querytext>
    </fullquery>

    <fullquery name="sel_curb_check">
       <querytext>
                    select '1'
                      from coimcurb
                     where cod_urb = :cod_urb
       </querytext>
    </fullquery>

    <fullquery name="sel_curb">
       <querytext>
                    select a.descrizione
                         , b.denominazione as comune
                      from coimcurb a
                         , coimcomu b 
                     where a.cod_urb        = :cod_urb
                       and a.cod_comune     = :cod_comune
                       and b.cod_comune (+) = a.cod_comune
       </querytext>
    </fullquery>

</queryset>
