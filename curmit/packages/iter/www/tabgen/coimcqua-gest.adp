<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width=100% cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimcqua-list?@link_list;noquote@ class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimcqua-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimcqua-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimcqua-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
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
<formwidget   id="last_cod_qua">
<formwidget   id="last_cod_comune">


<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title>Codice</td>
    <td valign=top nowrap><formwidget id="cod_qua">
        <formerror  id="cod_qua"><br>
        <span class="errori">@formerror.cod_qua;noquote@</span>
        </formerror>
    </td>
</tr>
<if @flag_ente@ eq C>
   <tr><td valign=top align=right class=form_title>Comune</td>
       <td valign=top nowrap><formwidget id="comune">
           <formerror  id="comune"><br>
           <span class="errori">@formerror.comune;noquote@</span>
           </formerror>
       </td>
   </tr>
</if>
<else>
 <if @funzione@ ne I>
   <tr><td valign=top align=right class=form_title>Comune</td>
       <td valign=top nowrap><formwidget id="comune">
           <formerror  id="comune"><br>
           <span class="errori">@formerror.comune;noquote@</span>
           </formerror>
       </td>
   </tr>
 </if>
 <else>
   <tr><td valign=top align=right class=form_title>Comune</td>
       <td valign=top nowrap><formwidget id="cod_comune">
           <formerror  id="cod_comune"><br>
           <span class="errori">@formerror.cod_comune;noquote@</span>
           </formerror>
       </td>
   </tr>
 </else>
</else>

<tr><td valign=top align=right class=form_title>Descrizione</td>
    <td valign=top nowrap><formwidget id="descrizione">
        <formerror  id="descrizione"><br>
        <span class="errori">@formerror.descrizione;noquote@</span>
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

