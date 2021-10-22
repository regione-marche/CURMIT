<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_aimp">
       <querytext>
       select   a.cod_impianto_est
              , coalesce(d.descr_topo,'')||' '||
                coalesce(d.descrizione,'')||
                case
                  when a.numero is null then ''
                  else ', '||a.numero
                end ||
                case
                  when a.esponente is null then ''
                  else '/'||a.esponente
                end ||
                case
                  when a.scala is null then ''
                  else ' S.'||a.scala
                end ||
                case
                  when a.piano is null then ''
                  else ' P.'||a.piano   
                end ||
                case
                 when a.interno is null then ''
                  else ' In.'||a.interno
                end
                as indirizzo
		, c.denominazione as comune
             from coimaimp a
	       left outer join coimviae d on d.cod_comune    = a.cod_comune	
                                            and d.cod_via       = a.cod_via
               left outer join coimcomu c on c.cod_comune    = a.cod_comune
             where a.cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="upd_aimp_targa">
       <querytext>
       update coimaimp
           set flag_targa_stampata = 'S'
	   where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>


</queryset>
