<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>


<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>
Impianti caricati: @aimp_corretti;noquote@<br>
Rapporti di ispezione caricati: @count_cimp;noquote@<br>
Autocertificazioni caricate: @count_dimp;noquote@<br>
<hr>
Combustibili caricati: @cod_comb;noquote@<br>
Toponimi caricati: @cod_topo;noquote@<br>
Vie caricate: @codice_via;noquote@<br>
Comuni codificati correttamente: @n_comuni_cod;noquote@<br>
Cittadini caricati: @count_citt;noquote@<br>
Manutentori caricati: @count_manu;noquote@<br>
Progettisti caricati: @count_prog;noquote@<br>
Costruttori caricati: @count_cost;noquote@<br>
Generatori caricati: @count_gend;noquote@<br>
Anomalie caricate: @count_anom;noquote@<br>
Operatori caricati: @count_opve;noquote@<br>
<hr>
Per scaricare l'archivio contenente i file pronti per il copy <a href=@dat_link;noquote@>clicca qui</a><br>
<!-- Fine della form colorata -->
<%=[iter_form_fine]%>


</center>

