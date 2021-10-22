<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_ucit_allgsc">
      <querytext>
          select  al.id                          as id
                , al.respnom   
                , al.respind||' '||coalesce(al.respcivico, '')||' - '||coalesce(al.respcom, '')||' '||coalesce(al.respcap, '') as respindirizzo
                , al.respind
                , al.respcivico
                , al.respcom
                , al.respcap
                , 'MA'||coalesce(lpad(al.tecnid, 6, '0'), '0')||' '||coalesce(m.cognome, '') as tecnid
                , al.caldpotkw as caldpotkw
                , al.caldmatr  as caldmatr
                , al.caldcostr as caldcostr
                , al.caldmodel as caldmodel
                , al.dtcontr                     as data_controllo
                , al.dtprot                      as data_protocollo
                , iter_edit_data(al.dtcontr)     as data_controllo_pretty
                , iter_edit_data(al.dtprot)      as data_protocollo_pretty
             from ucit_allgsc al  left outer join coimmanu m on m.cod_manutentore = 'MA'||lpad(al.tecnid, 6, '0')
            where al.id = :id
       </querytext>
    </fullquery>

</queryset>
