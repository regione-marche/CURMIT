<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width=100% cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimcinc-list?@link_list;noquote@ class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimcinc-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimcinc-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimcinc-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
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
<formwidget   id="last_cod_cinc">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<!-- TODO: Ricordare di posizionare gli eventuali link ai pgm di zoom -->

<if @funzione@ ne I>
    <tr><td valign=top align=right class=form_title>Codice</td>
        <td valign=top><formwidget id="cod_cinc">
            <formerror  id="cod_cinc"><br>
            <span class="errori">@formerror.cod_cinc;noquote@</span>
            </formerror>
        </td>
    </tr>
</if>

<tr><td valign=top align=right class=form_title>Tipologia Impianto</td>
    <td valign=top><formwidget id="flag_tipo_impianto">
        <formerror  id="flag_tipo_impianto"><br>
        <span class="errori">@formerror.flag_tipo_impianto;noquote@</span>
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

<tr><td valign=top align=right class=form_title>Stato</td>
    <td valign=top><formwidget id="stato">
        <formerror  id="stato"><br>
        <span class="errori">@formerror.stato;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Data inizio</td>
    <td valign=top><formwidget id="data_inizio">
        <formerror  id="data_inizio"><br>
        <span class="errori">@formerror.data_inizio;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Data fine</td>
    <td valign=top><formwidget id="data_fine">
        <formerror  id="data_fine"><br>
        <span class="errori">@formerror.data_fine;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Controlli previsti</td>
    <td valign=top><formwidget id="controlli_prev">
        <formerror  id="controlli_prev"><br>
        <span class="errori">@formerror.controlli_prev;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Note</td>
    <td valign=top><formwidget id="note">
        <formerror  id="note"><br>
        <span class="errori">@formerror.note;noquote@</span>
        </formerror>
    </td>
</tr>

@msg_att;noquote@

<if @funzione@ ne "V">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>


<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

