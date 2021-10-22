<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimtp_pag-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
     <if @cod_tipo_pag@ eq BO or @cod_tipo_pag@ eq BP or @cod_tipo_pag@ eq CN or @cod_tipo_pag@ eq BB or @cod_tipo_pag@ eq CC or @cod_tipo_pag@ eq PS or @cod_tipo_pag@ eq LM>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimtp_pag-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimtp_pag-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>Cancella</td>
     </if>
     <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimtp_pag-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimtp_pag-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimtp_pag-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
     </else>
   </else>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="last_descrizione">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<!-- TODO: Ricordare di posizionare gli eventuali link ai pgm di zoom -->
<tr><td valign=top align=right class=form_title>Codice</td>
    <td valign=top><formwidget id="cod_tipo_pag">
    <formerror  id="cod_tipo_pag"><br>
       <span class="errori">@formerror.cod_tipo_pag;noquote@</span>
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
<tr><td valign=top align=right class=form_title>Ordinamento</td>
    <td valign=top><formwidget id="ordinamento">
        <formerror  id="ordinamento"><br>
        <span class="errori">@formerror.ordinamento;noquote@</span>
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


