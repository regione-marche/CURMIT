<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_manu">
        <querytext>
                   select cod_manutentore
                        , nvl(cognome,'')||' '||nvl(nome,'') as nominativo
                        , indirizzo
                        , comune
                        , nvl(cod_fiscale, '&nbsp;') as cod_fiscale
                     from coimmanu
                    where cod_manutentore = :cod_manu
       </querytext>
   </fullquery>

    <partialquery name="upd_aimp">
       <querytext>
          update coimaimp
	     set cod_manutentore = :destinazione
           where cod_manutentore = :cod_manu
       </querytext>
    </partialquery>

    <partialquery name="upd_boll">
       <querytext>
          update coimboll
	     set cod_manutentore = :destinazione
           where cod_manutentore = :cod_manu
       </querytext>
    </partialquery>

    <partialquery name="upd_coma">
       <querytext>
          update coimcoma
	     set cod_manutentore = :destinazione
           where cod_manutentore = :cod_manu
       </querytext>
    </partialquery>

    <partialquery name="upd_dimp">
       <querytext>
          update coimdimp
	     set cod_manutentore = :destinazione
           where cod_manutentore = :cod_manu
       </querytext>
    </partialquery>

    <partialquery name="upd_mtar">
       <querytext>
          update coimmtar
	     set cod_manutentore = :destinazione
           where cod_manutentore = :cod_manu
       </querytext>
    </partialquery>

    <partialquery name="del_manu">
       <querytext>
           delete 
             from coimmanu
            where cod_manutentore = :cod_manu
       </querytext>
    </partialquery>


</queryset>
