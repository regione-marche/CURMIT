<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table align=center>
      <tr>
         <td align=center>Ente verificatore: <b>@nome_enve;noquote@</b> &nbsp; Ispettore: <b>@nome_opve;noquote@</b></td>
      </tr>
</table>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimopdi-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimopdi-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimopdi-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimopdi-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
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
<formwidget   id="last_prog_disp">
<formwidget   id="cod_opve">
<formwidget   id="prog_disp">
<formwidget   id="cod_enve">
<formwidget   id="url_enve">
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<!-- TODO: Ricordare di posizionare gli eventuali link ai pgm di zoom -->

<tr><td valign=top align=right class=form_title>Da ora</td>
    <td valign=top><formwidget id="ora_da">
        <formerror  id="ora_da"><br>
        <span class="errori">@formerror.ora_da;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>A ora</td>
    <td valign=top><formwidget id="ora_a">
        <formerror  id="ora_a"><br>
        <span class="errori">@formerror.ora_a;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

