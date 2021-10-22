<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

@link_inco;noquote@
@link_tab;noquote@
@dett_tab;noquote@
<if @flag_cimp@ ne S and @flag_inco@ ne S>
    <table width="25%" cellspacing=0 class=func-menu>
     <tr>
       <td width="25%" nowrap class=func-menu>
        <a href="coimcimp-filter?@link_filt;noquote@" class=func-menu>Ritorna</a>
      </td>
    </tr>
   </table>
</if>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="last_cod_cimp">
<formwidget   id="cod_impianto">
<formwidget   id="flag_cimp">
<formwidget   id="url_aimp">
<formwidget   id="url_list_aimp">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr>
  <td valign=top align=right class=form_title>Data Controllo</td>
  <td valign=top><formwidget id="data_controllo_edit">
      <formerror  id="data_controllo_edit"><br>
        <span class="errori">@formerror.data_controllo_edit;noquote@</span>
      </formerror>
  </td>
</tr>
<tr>
  <td valign=top align=right class=form_title>Data verbale</td>
  <td valign=top><formwidget id="data_verb_edit">
      <formerror  id="data_verb_edit"><br>
        <span class="errori">@formerror.data_verb_edit;noquote@</span>
      </formerror>
  </td>
</tr>
<tr>
  <td valign=top align=right class=form_title>Num.Verbale</td>
  <td valign=top><formwidget id="verb_n">
      <formerror  id="verb_n"><br>
        <span class="errori">@formerror.verb_n;noquote@</span>
      </formerror>
  </td>
</tr>
<tr>
  <td valign=top align=right class=form_title>Costo ispezione</td>
  <td valign=top><formwidget id="costo_verifica_edit">
      <formerror  id="costo_verifica_edit"><br>
        <span class="errori">@formerror.costo_verifica_edit;noquote@</span>
      </formerror>
  </td>
</tr>
<tr>
  <td valign=top align=right class=form_title>Num.Fattura</td>
  <td valign=top><formwidget id="num_fatt">
      <formerror  id="num_fatt"><br>
        <span class="errori">@formerror.num_fatt;noquote@</span>
      </formerror>
  </td>
</tr>
<tr>
  <td valign=top align=right class=form_title>Data Fattura</td>
  <td valign=top><formwidget id="data_fatt_edit">
      <formerror  id="data_fatt_edit"><br>
        <span class="errori">@formerror.data_fatt_edit;noquote@</span>
      </formerror>
  </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

