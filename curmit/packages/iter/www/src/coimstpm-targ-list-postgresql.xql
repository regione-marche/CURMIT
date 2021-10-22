<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_aimp_si_viae">
       <querytext>
       select   a.cod_impianto
              , a.cod_impianto_est
	      , coalesce(v.descr_topo,'')||' '||
                  coalesce(v.descrizione,'')||
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
		   as f_indirizzo
	      , coalesce(m.cognome,' ',m.nome) as nome_manu
	      , a.flag_targa_stampata as flag_stampato
       from coimaimp a
       left outer join coimmanu m on m.cod_manutentore = a.cod_manutentore
       left outer join coimviae v on v.cod_comune = a.cod_comune and v.cod_via = a.cod_via
       where 1=1
       $where_comune
       $where_cod_via
       $where_manu
       and a.flag_targa_stampata = 'N'			      
       </querytext>
    </partialquery>

    <partialquery name="sel_aimp_no_viae">
       <querytext>
       select   a.cod_impianto
              , a.cod_impianto_est
	      , coalesce(a.toponimo||' '||a.indirizzo) as f_indirizzo
	      , coalesce(m.nome,' ',m.cognome) as nome_manu
	      , flag_targa_stampata as flag_stampato
       from coimaimp a 
       left outer join coimmanu m on a.cod_manutentore = m.cod_manutentore
       where 1=1
       $where_comune
       $where_via
       $where_topo
       $where_manu
	and where flag_targa_stampata = 'F'      
       </querytext>
    </partialquery>

</queryset>
