<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>



<table align=center>
      <tr>
         <td align=center>Categoria Ente verificatore: <b>@den_enre;noquote@</b></td>
      </tr>
</table>
<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimenti-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimenti-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimenti-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimenti-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
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
<formwidget   id="last_denominazione">
<formwidget   id="cod_enre">
<formwidget   id="cod_ente">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title>denominazione</td>
    <td valign=top><formwidget id="denominazione">
        <formerror  id="denominazione"><br>
        <span class="errori">@formerror.denominazione;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Indirizzo</td>
    <td valign=top><formwidget id="indirizzo">
        <formerror  id="indirizzo"><br>
        <span class="errori">@formerror.indirizzo;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Civico</td>
    <td valign=top><formwidget id="numero">
        <formerror  id="numero"><br>
        <span class="errori">@formerror.numero;noquote@</span>
        </formerror>
    </td>    
</tr>


<tr><td valign=top align=right class=form_title>comune</td>
    <td valign=top><formwidget id="comune">
        <formerror  id="comune"><br>
        <span class="errori">@formerror.comune;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>localita</td>
    <td valign=top><formwidget id="localita">
        <formerror  id="localita"><br>
        <span class="errori">@formerror.localita;noquote@</span>
        </formerror>
    </td>
</tr>


<tr><td valign=top align=right class=form_title>provincia</td>
    <td valign=top><formwidget id="provincia">
        <formerror  id="provincia"><br>
        <span class="errori">@formerror.provincia;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>cap</td>
    <td valign=top><formwidget id="cap">
        <formerror  id="cap"><br>
        <span class="errori">@formerror.cap;noquote@</span>
        </formerror>
    </td>
</tr>



<tr><td valign=top align=right class=form_title>Codice area</td>
    <td valign=top><formwidget id="cod_area">
        <formerror  id="cod_area"><br>
        <span class="errori">@formerror.cod_area;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p/>
</center>

