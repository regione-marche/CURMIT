<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

@js_function;noquote@
@link_tab;noquote@
@dett_tab;noquote@

<!-- barra con il cerca, link di aggiungi e righe per pagina -->
@list_head;noquote@

<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="flag_ins">
<formwidget   id="last_qua">
<formwidget   id="cod_qua">
<formwidget   id="url_list_area">

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

