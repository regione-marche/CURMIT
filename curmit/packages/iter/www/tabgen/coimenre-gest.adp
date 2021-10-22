<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimenre-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimenre-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimenre-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimenre-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
      <tr>
          <td width="25%" nowrap class=func-menu>
             <a href="coimenti-list?@link_enti;noquote@" class=func-menu>Enti competenti</a>
          </td>
          <td colspan=3 width="75%" class=func-menu>&nbsp;</td>
      </tr> 
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
<formwidget   id="last_cod_enre">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>


<tr><td valign=top align=right class=form_title>Codice</td>
    <td valign=top><formwidget id="cod_enre">
        <formerror  id="cod_enre"><br>
        <span class="errori">@formerror.cod_enre;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Denominazione</td>
    <td valign=top><formwidget id="denominazione">
        <formerror  id="denominazione"><br>
        <span class="errori">@formerror.denominazione;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td>&nbsp;</td>
    <td valign=top><formwidget id="denominazione2">
        <formerror  id="denominazione2"><br>
        <span class="errori">@formerror.denominazione2;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=4>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

