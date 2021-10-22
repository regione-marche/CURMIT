<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="del_fascia">
       <querytext>
                   delete
                     from coimfascia
                    where cod_fascia = :cod_fascia
       </querytext>
    </partialquery>

    <partialquery name="upd_fascia">
       <querytext>
                   update coimfascia
                      set ora_inizio = :ora_inizio
                        , ora_fine = :ora_fine
                    where cod_fascia   = :cod_fascia
       </querytext>
    </partialquery>

    <partialquery name="ins_fascia">
       <querytext>
                   insert
                     into coimfascia 
                        ( cod_fascia
                        , ora_inizio
                        , ora_fine)
                   values 
                        (:cod_fascia
                        ,:ora_inizio
                        ,:ora_fine)
       </querytext>
    </partialquery>

     <fullquery name="sel_check_fascia_2">
       <querytext>
                    select '1'
                      from coimfascia
                     where cod_fascia = :cod_fascia
       </querytext>
    </fullquery>


    <fullquery name="sel_fascia">
       <querytext>
                    select cod_fascia
                         , ora_inizio
                         , ora_fine
                      from coimfascia
                     where cod_fascia = :cod_fascia
       </querytext>
    </fullquery>

</queryset>
