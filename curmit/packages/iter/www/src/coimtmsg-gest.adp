<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width=100% cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimtmsg-list?@link_list;noquote@ class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimtmsg-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimtmsg-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimtmsg-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
   </else>
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
<formwidget   id="cod_tmsg">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>


<if @funzione@ ne "I">
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
</if>

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

<tr><td valign=top align=right class=form_title>Destinatario (Unità Organizzativa)</td>
    <td valign=top nowrap><formwidget id="unita_dest">
        <formerror id="unita_dest"><br>
        <span class="errori">@formerror.unita_dest;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<tr><td>&nbsp;</td>
    <td>@table_result;noquote@</td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V" and @vieta_azione@ eq "f">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

