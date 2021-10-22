<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimogge-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimogge-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimogge-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimogge-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
   </else>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="last_scelta">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<!-- TODO: Ricordare di posizionare gli eventuali link ai pgm di zoom -->

<tr><td valign=top align=right class=form_title>Livello</td>
    <td valign=top><formwidget id="livello">
        <formerror  id="livello"><br>
        <span class="errori">@formerror.livello;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Scelta 1</td>
    <td valign=top><formwidget id="scelta_1">
        <formerror  id="scelta_1"><br>
        <span class="errori">@formerror.scelta_1;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Scelta 2</td>
    <td valign=top><formwidget id="scelta_2">
        <formerror  id="scelta_2"><br>
        <span class="errori">@formerror.scelta_2;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Scelta 3</td>
    <td valign=top><formwidget id="scelta_3">
        <formerror  id="scelta_3"><br>
        <span class="errori">@formerror.scelta_3;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Scelta 4</td>
    <td valign=top><formwidget id="scelta_4">
        <formerror  id="scelta_4"><br>
        <span class="errori">@formerror.scelta_4;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Tipo</td>
    <td valign=top><formwidget id="tipo">
        <formerror  id="tipo"><br>
        <span class="errori">@formerror.tipo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Descrizione</td>
    <td valign=top><formwidget id="descrizione">
        <formerror  id="descrizione"><br>
        <span class="errori">@formerror.descrizione;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Nome Funzione</td>
    <td valign=top><formwidget id="nome_funz_d">
        <formerror  id="nome_funz_d"><br>
        <span class="errori">@formerror.nome_funz_d;noquote@</span>
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

