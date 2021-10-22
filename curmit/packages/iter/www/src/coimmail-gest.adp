<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width=100% cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimmail-list?@link_list;noquote@ class=func-menu>Ritorna</a>
   </td>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimmail-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="last_id_mail">
<formwidget   id="last_destinatario">
<formwidget   id="id_mail">



<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=left class=form_title>Mittente:  </td>
    <td colspan=2 nowrap class=form_title><formwidget id="mittente">
        <formerror id="mittente"><br>
        <span class="errori">@formerror.mittente;noquote@</span>
        </formerror>
 </td>
</tr> 
<tr><td valign=top align=left class=form_title>Destinatari:  </td>
    <td valign=top colspan=2 nowrap class=form_title><formwidget id="destinatario">
        <formerror id="destinatario"><br>
        <span class="errori">@formerror.destinatario;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=left class=form_title>CC:  </td>
    <td valign=top colspan=2 nowrap class=form_title><formwidget id="copia_conoscenza">
        <formerror id="copia_conoscenza"><br>
        <span class="errori">@formerror.copia_conoscenza;noquote@</span>
        </formerror>
</td>
</tr>
<tr><td valign=top align=left class=form_title>Oggetto:    </td>
    <td valign=top colspan=2 nowrap class=form_title><formwidget id="oggetto">
        <formerror  id="oggetto"><br>
        <span class="errori">@formerror.oggetto;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
<td valign=top align=left class=form_title>Testo:    </td>
    <td valign=top colspan=2 nowrap class=form_title><formwidget id="testo">
        <formerror id="testo"><br>
        <span class="errori">@formerror.testo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
<td valign=top align=left class=form_title>Allegato</td>
    <td valign=top colspan=2 nowrap class=form_title><formwidget id="link_allegato">
        <formerror  id="link_allegato"><br>
        <span class="errori">@formerror.link_allegato;noquote@</span>
        </formerror>
</td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V" and @nodelete@ eq "F">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>


<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>


