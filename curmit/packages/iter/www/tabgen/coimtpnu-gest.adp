<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimtpnu-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimtpnu-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimtpnu-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimtpnu-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
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
<formwidget   id="last_descr">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<!-- TODO: Ricordare di posizionare gli eventuali link ai pgm di zoom -->
<tr><td valign=top align=right class=form_title>Codice</td>
    <td valign=top><formwidget id="cod_tpnu">
    <formerror  id="cod_tpnu"><br>
       <span class="errori">@formerror.cod_tpnu;noquote@</span>
       </formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>Descrizione</td>
    <td valign=top><formwidget id="descr">
        <formerror  id="descr"><br>
        <span class="errori">@formerror.descr;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Descrizione estesa</td>
    <td valign=top><formwidget id="descr_est">
        <formerror  id="descr_est"><br>
        <span class="errori">@formerror.descr_est;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Progressivo</td>
    <td valign=top><formwidget id="progressivo">
        <formerror  id="progressivo"><br>
        <span class="errori">@formerror.progressivo;noquote@</span>
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


