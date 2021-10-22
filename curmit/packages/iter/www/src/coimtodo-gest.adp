<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

@link_tab;noquote@
@dett_tab;noquote@
<table width="100%" cellspacing=0 class=func-menu>
<tr>
<!--
   <td width=20% nowrap class=func-menu>
       <a href="coimtodo-list?@link_list;noquote@" class=func-menu>Lista</a>
   </td>
-->
   <if @funzione@ eq "I">
      <td width=100% nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width=25% nowrap class=@func_v;noquote@>
         <a href="coimtodo-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width=25% nowrap class=@func_m;noquote@>
         <a href="coimtodo-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width=25% nowrap class=@func_d;noquote@>
         <a href="coimtodo-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
      @dettaglio;noquote@
   </else>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="cod_todo">
<formwidget   id="last_cod_todo">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title>Tipologia</td>
    <td valign=top><formwidget id="tipologia">
        <formerror  id="tipologia"><br>
        <span class="errori">@formerror.tipologia;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Data Competenza</td>
    <td valign=top><formwidget id="data_evento">
        <formerror  id="data_evento"><br>
        <span class="errori">@formerror.data_evento;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data limite intervento</td>
    <td valign=top><formwidget id="data_scadenza">
        <formerror  id="data_scadenza"><br>
        <span class="errori">@formerror.data_scadenza;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Note</td>
    <td valign=top colspan=3><formwidget id="note">
        <formerror  id="note"><br>
        <span class="errori">@formerror.note;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Stato</td>
    <td valign=top><formwidget id="flag_evasione">
        <formerror  id="flag_evasione"><br>
        <span class="errori">@formerror.flag_evasione;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data evasione</td>
    <td valign=top><formwidget id="data_evasione">
        <formerror  id="data_evasione"><br>
        <span class="errori">@formerror.data_evasione;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=4>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

