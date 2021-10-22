<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>


<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="f_cod_via">
<formwidget   id="f_cod_manu">
<formwidget   id="dummy">

<if @flag_ente@ eq "C">
    <formwidget id="f_comune">
</if>
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

      <tr><td><strong>Ricerca per indirizzo</strong></td></tr>
      <tr>
      <if @flag_ente@ eq "P">
         <td valign=top align=right class=form_title>Comune</td>
         <td valign=top><formwidget id="f_comune">
            <formerror  id="f_comune"><br>
            <span class="errori">@formerror.f_comune;noquote@</span>
            </formerror>
         </td>
      </if>
      <else>
         <td valign=top align=right class=form_title>Quartiere</td>
         <td valign=top><formwidget id="f_quartiere">
            <formerror  id="f_quartiere"><br>
            <span class="errori">@formerror.f_quartiere;noquote@</span>
            </formerror>
         </td>
      </else>
      </tr>

      <tr>
         <td valign=top align=right class=form_title>Indirizzo</td>
         <td valign=top><formwidget id="f_desc_topo">
             <formwidget id="f_desc_via">@cerca_viae;noquote@
             <formerror  id="f_desc_via"><br>
             <span class="errori">@formerror.f_desc_via;noquote@</span>
             </formerror>
         </td>
      </tr>

      <tr>
         <td valign=top align=right class=form_title>Da Civico</td>
         <td valign=top><formwidget id="f_civico_da"> A
             <formwidget id="f_civico_a">
             <formerror  id="f_civico_da"><br>
             <span class="errori">@formerror.f_civico_da;noquote@</span>
             </formerror>
         </td>
	 </tr>

       <tr>
         <td valign=top colspan=2 nowrap align=left class=form_title>
             <b>Ricerca per Manutentore</b>
         </td>         
      </tr>
      <tr>
         <td valign=top align=right class=form_title>Cognome</td>
         <td valign=top><formwidget id="f_manu_cogn">
            <formerror  id="f_manu_cogn"><br>
            <span class="errori">@formerror.f_manu_cogn;noquote@</span>
            </formerror>
         </td>   
      </tr>
      <tr>
         <td valign=top align=right class=form_title>Nome</td>
         <td valign=top><formwidget id="f_manu_nome">@cerca_manu;noquote@
            <formerror  id="f_manu_nome"><br>
            <span class="errori">@formerror.f_manu_nome;noquote@</span>
            </formerror>
         </td>   

	 </tr>

<tr><td colspan 4>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->

<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

