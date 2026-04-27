<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    mat01 02/09/2025 Sostituito il tag b con strong. Sostituito il tag center con un div
    mat01            Modifiche fatte per l'accessibilità.(ho usato mauve++ per vedere gli errori)

    gac01 17/05/2018 Aggiunto coimdimp-list al portale
-->
<master> <!--innes -->
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

@js_function;noquote@

<br>
<!-- mat01<center>-->
<div align="center"><!--mat01-->
<!-- genero la tabella -->

<strong>Lista RCEE e moduli regionali</strong><br>
&Egrave; possibile visualizzare (Selez.) e stampare (Stampa) i documenti.
<br><br>
@table_result;noquote@

<if @sw_dichiarazioni_frequenza@ eq "t"><!-- ant01: aggiunta if ed il suo contenuto -->
  <br><br><strong>Lista Dichiarazioni di Frequenza ed Elenco Operazioni di Controllo e Manutenzione</strong>
  <br><br>
  @table_result4;noquote@
</if>

<if @flag_sup@ eq S>
  <br><br><strong>Lista Allegati IX</strong>
  <br><br>
  @table_result2;noquote@

  <br><br><strong>Lista Allegati IX B</strong>
  <br><br>
  @table_result3;noquote@
</if>
</div><!--mat01-->
<!--mat01 </center>-->

