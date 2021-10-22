<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_file_pagamenti_postali">
       <querytext>
   select a.data_caricamento
        , iter_edit_data(a.data_caricamento)        as data_caricamento_edit
	, a.cod_file
        , a.nome_file
        , b.cognome||' '||b.nome                    as cog_nom_utente
        , iter_edit_num(a.record_caricati,0)        as record_caricati_edit
        , iter_edit_num(a.importo_caricati,2)       as importo_caricati_edit
        , iter_edit_num(a.record_scartati,0)        as record_scartati_edit
        , iter_edit_num(a.importo_scartati,2)       as importo_scartati_edit
        , a.file_caricamento
        , a.file_caricati
        , a.file_scartati
     from coimfile_pagamenti_postali a
left join coimuten b
       on b.id_utente = a.utente_ins
    where 1 = 1
   $where_word
   $where_data_caricamento
   $where_last
 order by a.data_caricamento desc
        , a.cod_file         desc
       </querytext>
    </partialquery>

    <fullquery name="sel_file_pagamenti_postali_sum">
       <querytext>
   select count(*)                               as num_file_pagamenti_postali
        , iter_edit_num(coalesce(sum(record_caricati),0),0)  as tot_record_caricati
        , iter_edit_num(coalesce(sum(importo_caricati),0),2) as tot_importo_caricati
        , iter_edit_num(coalesce(sum(record_scartati),0),0)  as tot_record_scartati
        , iter_edit_num(coalesce(sum(importo_scartati),0),2) as tot_importo_scartati
     from coimfile_pagamenti_postali a
    where 1 = 1
   $where_word
   $where_data_caricamento
   $where_last
       </querytext>
    </fullquery>

</queryset>
