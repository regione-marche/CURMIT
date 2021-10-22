<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

@js_function;noquote@

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="@url_cout_comu_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <td width="75%" nowrap class=func-menu>&nbsp;</td>
</tr>
</table>

<!-- barra con il cerca, link di aggiungi e righe per pagina -->
@list_head;noquote@

<formtemplate id="@form_name;noquote@">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">

<formwidget   id="funzione">
<formwidget   id="cod_utente">
<formwidget   id="cod_comune">
<formwidget   id="url_cout_comu_list">

<formwidget   id="flag_ins">
<formwidget   id="last_comune">

<center>
<!-- genero la tabella -->

<input type=hidden name=function value="I">
<if @funzione@ ne V>
    <table>
        <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
    </table>
</if>

  @table_result;noquote@

<if @funzione@ ne V>
    <table>
        <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
    </table>
</if>
</center>
</formtemplate>

