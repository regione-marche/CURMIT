<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>


<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>
Impianti scartati per errori nel numero dei record letti: @aimp_mod;noquote@<br>
Rapporti scartati per errori nel numero dei record letti: @cimp_mod;noquote@<br>
Dichiarazioni scartate per errori nel numero dei record letti: @dimp_mod;noquote@<br>
<hr>
Impianti letti @impianti_letti;noquote@<br>
Impianti scartati @impianti_scarti;noquote@<br>
Impianti accettati con riserva @impianti_riserva;noquote@<br>
Rapporti letti @rapporti_letti;noquote@<br>
Rapporti scartati @rapporti_scarti;noquote@<br>
Rapporti accettati con riserva @rapporti_riserva;noquote@<br>
Dichiarazioni lette @autocertificazioni_letti;noquote@<br>
Dichiarazioni scartate @autocertificazioni_scarti;noquote@<br>
Dichiarazioni accettate con riserva @autocertificazioni_riserva;noquote@<br>
<hr>
Per scaricare i file corretti <a href=@corretti_link;noquote@>clicca qui</a><br>
Per scaricare i file con i report degli errore <a href=@errati_link;noquote@>clicca qui</a>
<br><br>
<a href=@coimcari_dati_link;noquote@>Procedi</a>
<!-- Fine della form colorata -->
<%=[iter_form_fine]%>


</center>

