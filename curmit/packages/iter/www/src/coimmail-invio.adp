<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    san01 19/07/2016 Aggiunto filtro per cod_zona.
-->

<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="dummy">

<table width="100%" cellspacing=0 class=func-menu>
    <tr>
        <td width="25%" class=func-menu>
           &nbsp;
        </td>
        <td width="50%" class=func-menu align=center>
	Spedisci Mail PEC 		
        </td>
        <td width="25%" class=func-menu>
           &nbsp;
        </td>
    </tr>
</table>
<br>
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>


<tr><td valign=top align=left  class=form_title>Mittente <font color=red>*</font></td>
    <td colspan=2 nowrap class=form_title><formwidget id="mittente">
        <formerror id="mittente"><br>
        <span class="errori">@formerror.mittente;noquote@</span>
        </formerror>
 </td>
</tr> 
<tr><td valign=top align=left class=form_title>Destinatari <font color=red>*</font></td>
    <td valign=top colspan=2 nowrap><formwidget id="destinatario">
        <formerror id="destinatario"><br>
        <span class="errori">@formerror.destinatario;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=left class=form_title>CC</td>
    <td valign=top colspan=2 nowrap><formwidget id="copia_conoscenza">
        <formerror id="copia_conoscenza"><br>
        <span class="errori">@formerror.copia_conoscenza;noquote@</span>
        </formerror>
</td>
</tr>
<tr><td valign=top align=left class=form_title>Oggetto <font color=red>*</td>
    <td valign=top colspan=2 nowrap><formwidget id="oggetto">
        <formerror  id="oggetto"><br>
        <span class="errori">@formerror.oggetto;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
<td valign=top align=left class=form_title>Testo</td>
    <td valign=top colspan=2 nowrap><formwidget id="testo">
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

<tr><td colspan=4>&nbsp;</td></tr>

<tr><td colspan=4 align=center><formwidget id="submitbut"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

