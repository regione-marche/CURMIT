<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_opdi">
       <querytext>
           select prog_disp
                , ora_da
                , ora_a
             from coimopdi
            where cod_opve = :cod_opve
       </querytext>
    </fullquery>

    <fullquery name="sel_fascia_ora_iniz">
       <querytext>
           select ora_da as ora_iniz
             from coimopdi
            where cod_opve  = :cod_opve
	      and prog_disp = :conta_fasce
       </querytext>
    </fullquery>

    <partialquery name="dml_ins_inco">
       <querytext>
          insert into 
           coiminco(cod_inco
                  , cod_cinc
                  , data_estrazione 
                  , cod_opve
                  , data_verifica
                  , ora_verifica
                  , data_ins
                  , utente
              ) values (
                   :cod_inco
                  ,:cod_cinc
                  , sysdate
                  ,:cod_opve
                  ,:data
                  ,:ora
                  , sysdate
                  ,:id_utente
              )
       </querytext>
    </partialquery>

    <fullquery name="sel_inco_dual">
       <querytext>
          select coiminco_s.nextval as cod_inco
            from dual
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc_cod">
       <querytext>
             select cod_cinc
               from coimcinc
              where stato = '1'
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_check">
       <querytext>
     select * 
       from (
             select /* FIRST_ROWS */ 
                    cod_impianto as impianto_check
               from coiminco
              where cod_opve      = :cod_opve
                and data_verifica = :data_inco
                and ora_verifica  = :fascia_da
             )
       where rownum <= 1
       </querytext>
    </fullquery>


    <fullquery name="sel_opdi_ore">
       <querytext>
           select ora_da as fascia_da
                , ora_a  as fascia_a
             from coimopdi
            where cod_opve  = :cod_opve
	      and prog_disp = :conta_fasce
       </querytext>
    </fullquery>

    <fullquery name="del_inco_no_aimp">
       <querytext>
             delete
               from coiminco
              where cod_opve      = :cod_opve
                and data_verifica between :mese_inizio and :mese_fine
                and cod_impianto is null
       </querytext>
    </fullquery>

    <fullquery name="sel_opve_nome">
       <querytext>
             select nvl(cognome,'')||' '||nvl(nome,'') as nome_opve
               from coimopve
              where cod_opve      = :cod_opve
       </querytext>
    </fullquery>

    <fullquery name="sel_opve_next">
       <querytext>
               select cod_opve 
                 from coimopve 
                where cod_enve = :cod_enve
                  and cod_opve > :cod_opve
                limit 1
       </querytext>
    </fullquery>

    <fullquery name="sel_opve_prew">
       <querytext>
               select cod_opve 
                 from coimopve 
                where cod_enve = :cod_enve
                  and cod_opve < :cod_opve
                order by cod_opve desc
                limit 1
       </querytext>
    </fullquery>

    <fullquery name="sel_opve_max">
       <querytext>
               select max(cod_opve) as cod_opve
                 from coimopve 
                where cod_enve = :cod_enve
       </querytext>
    </fullquery>

</queryset>
