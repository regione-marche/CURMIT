<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimpesi-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimpesi-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimpesi-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimpesi-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
   </tr>
   </else>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="last_campo">
<if @funzione@ ne "I">
   <formwidget    id="tipo_peso">
</if>
<br>
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

    <tr><td valign=top align=right class=form_title>Codice interno</td>
         <td valign=top><formwidget id="nome_campo">
             <formerror  id="nome_campo"><br>
             <span class="errori">@formerror.nome_campo;noquote@</span>
            </formerror>
         </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Codice esterno</td>
         <td valign=top><formwidget id="codice_esterno">
             <formerror  id="codice_esterno"><br>
             <span class="errori">@formerror.codice_esterno;noquote@</span>
            </formerror>
         </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Nome del campo sul modello</td>
         <td valign=top><formwidget id="descrizione_dimp">
             <formerror  id="descrizione_dimp"><br>
             <span class="errori">@formerror.descrizione_dimp;noquote@</span>
            </formerror>
         </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Descrizione</td>
         <td valign=top><formwidget id="descrizione_uten">
             <formerror  id="descrizione_uten"><br>
             <span class="errori">@formerror.descrizione_uten;noquote@</span>
            </formerror>
         </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Peso</td>
         <td valign=top><formwidget id="peso">
             <formerror  id="peso"><br>
             <span class="errori">@formerror.peso;noquote@</span>
            </formerror>
         </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Tipo peso</td>
         <td valign=top>
	 <if @funzione@ eq "I">
	 <formwidget id="tipo_peso">
             <formerror  id="tipo_peso"><br>
             <span class="errori">@formerror.tipo_peso;noquote@</span>
            </formerror>
	 </if>
	 <else>
	 <formwidget id="tipo_peso_ed">
	 </else>
         </td>
    </tr>

   <tr><td valign=top align=right class=form_title>Codice Raggruppamento</td>
        <td valign=top><formwidget id="cod_raggruppamento">
            <formerror  id="cod_raggruppamento"><br>
            <span class="errori">@formerror.cod_raggruppamento;noquote@</span>
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

