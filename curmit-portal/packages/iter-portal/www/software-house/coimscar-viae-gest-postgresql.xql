<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>


    <partialquery name="sel_viae">
       <querytext>
       select 
          a.cod_via
         ,a.cod_comune
         ,a.descrizione
         ,a.descr_topo
         ,a.descr_estesa
         ,a.cap
         ,a.da_numero
         ,a.a_numero
         ,a.cod_via_new
         ,substr(lpad(b.cod_istat,6,'0'),4,3) as cod_comu
         from coimviae a ,
              coimcomu b
        where a.cod_comune = b.cod_comune
        $where_comune
       order by descrizione
       </querytext>
    </partialquery>

</queryset>
