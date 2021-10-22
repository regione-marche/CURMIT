<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_cod_fisc">
       <querytext>
         select id_utente
              , cod_distr
           from coimddis
          where cod_fiscale = upper(:cod_fisc)
       </querytext>
    </fullquery>

</queryset>
