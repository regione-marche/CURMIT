<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_nominativo">
       <querytext>
       cognome||' '||nvl(nome,'') as nominativo
       </querytext>
    </partialquery>

    <fullquery name="sel_opve">
       <querytext>
           select 1
             from coimopve
            where cod_enve = :cod_enve
              and cod_opve = :cod_opve
       </querytext>
    </fullquery>

    <fullquery name="sel_cod_enve">
       <querytext>
	  select cod_enve as cd_enve
            from coimopve
           where cod_opve = :cd_tecn
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc_att">
       <querytext>
            select cod_cinc as cod_cinc_att
              from coimcinc
             where stato = '1'
       </querytext>
    </fullquery>

</queryset>
