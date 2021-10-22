<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width=100% cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimdmsg-list?@link_list;noquote@ class=func-menu>Ritorna</a>
   </td>
   <td width="25%" nowrap class=@func_v;noquote@>
       <a href="coimdmsg-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
   </td>
   <td width="50%" nowrap class=func-menu>&nbsp;</td>
</tr>
</table>

<p></p>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="last_key_order_by">
<formwidget   id="cod_dmsg">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title>Data/Ora invio</td>
    <td valign=top nowrap><formwidget id="ts_ins_edit">
        <formerror id="ts_ins_edit"><br>
        <span class="errori">@formerror.ts_ins_edit;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Mittente</td>
    <td valign=top nowrap><formwidget id="utente_ins">
        <formerror id="utente_ins"><br>
        <span class="errori">@formerror.utente_ins;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Oggetto</td>
    <td valign=top nowrap><formwidget id="oggetto">
        <formerror id="oggetto"><br>
        <span class="errori">@formerror.oggetto;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Messaggio</td>
    <td valign=top nowrap><formwidget id="messaggio">
        <formerror id="messaggio"><br>
        <span class="errori">@formerror.messaggio;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Letto?</td>
    <td valign=top nowrap><formwidget id="flag_letto">
        <formerror id="flag_letto"><br>
        <span class="errori">@formerror.flag_letto;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Data/Ora Lettura</td>
    <td valign=top nowrap><formwidget id="ts_lettura_edit">
        <formerror id="ts_lettura_edit"><br>
        <span class="errori">@formerror.ts_lettura_edit;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

