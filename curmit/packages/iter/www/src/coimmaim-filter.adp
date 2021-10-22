<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="dummy">
<formwidget   id="f_cod_via">
<formwidget   id="f_cod_manu">
<if @flag_ente@ eq "C">
    <formwidget id="f_comune">
</if>
<!-- Inizio della form colorata -->

<%=[iter_form_iniz]%>

<tr>

</tr>
<tr>
   <td>
   <table>
      <tr>
         <td valign=top colspan=2 align=left class=form_title>
             <b>CRITERI PRINCIPALI</b>
         </td>
         <td valign=top nowrap    align=left class=form_title>
             <b>CRITERI AGGIUNTIVI</b>
         </td>
         <td align=right>
            <a href="#" onclick="javascript:window.open('coimaimp-help', 'help', 'scrollbars=yes, resizable=yes, width=580, height=320').moveTo(110,140)"><b>Help</b></a>
         </td>
      </tr>

      <tr><td colspan=4>&nbsp;</td>

      <tr>
         <td valign=top nowrap align=right class=form_title>
             <b>Ricerca per Codice</b>
         </td>
         <td>&nbsp;</td>

         <td valign=top align=right class=form_title>Da Potenza (kW)</td>
         <td valign=top><formwidget id="f_potenza_da">
            <formerror id="f_potenza_da"><br>
            <span class="errori">@formerror.f_potenza_da;noquote@</span>
            </formerror>
         </td>
      </tr>

      <tr>
         <td valign=top align=right class=form_title>Codice Impianto</td>
         <td valign=top><formwidget id="f_cod_impianto_est">
            <formerror  id="f_cod_impianto_est"><br>
            <span class="errori">@formerror.f_cod_impianto_est;noquote@</span>
            </formerror>
         </td>


         <td valign=top align=right class=form_title>A Potenza (kW)</td>
         <td valign=top><formwidget id="f_potenza_a">
            <formerror  id="f_potenza_a"><br>
            <span class="errori">@formerror.f_potenza_a;noquote@</span>
            </formerror>
         </td>
      </tr>

      <tr>
         <td valign=top colspan=2 align=left class=form_title>
             <b>Ricerca per Responsabile</b>
         </td>


         <td valign=top align=right class=form_title>Da Data Installazione</td>
         <td valign=top><formwidget id="f_data_installaz_da">
            <formerror id="f_data_installaz_da"><br>
            <span class="errori">@formerror.f_data_installaz_da;noquote@</span>
            </formerror>
         </td>
      </tr>

      <tr>
         <td valign=top align=right class=form_title>Cognome</td>
         <td valign=top><formwidget id="f_resp_cogn">
            <formerror  id="f_resp_cogn"><br>
            <span class="errori">@formerror.f_resp_cogn;noquote@</span>
            </formerror>
         </td>

         <td valign=top align=right class=form_title>A Data Installazione</td>
         <td valign=top><formwidget id="f_data_installaz_a">
            <formerror  id="f_data_installaz_a"><br>
            <span class="errori">@formerror.f_data_installaz_a;noquote@</span>
            </formerror>
         </td>
      </tr>

      <tr>
         <td valign=top align=right class=form_title>Nome</td>
         <td valign=top><formwidget id="f_resp_nome">
            <formerror  id="f_resp_nome"><br>
            <span class="errori">@formerror.f_resp_nome;noquote@</span>
            </formerror>
         </td>


         <td valign=top align=right class=form_title>Stato dichiarazione</td>
         <td valign=top><formwidget id="f_flag_dichiarato">
             <formerror  id="f_flag_dichiarato"><br>
             <span class="errori">@formerror.f_flag_dichiarato;noquote@</span>
             </formerror>
         </td>
      </tr>

      <tr>
         <td valign=top colspan=2 nowrap align=left class=form_title>
             <b>Ricerca per Indirizzo</b>
         </td>

         <td valign=top align=right class=form_title> 
             Stato conformit&agrave;
         </td>
         <td valign=top><formwidget id="f_stato_conformita">
            <formerror  id="f_stato_conformita"><br>
            <span class="errori">@formerror.f_stato_conformita;noquote@</span>
            </formerror>
         </td>
      </tr>

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

         <td valign=top align=right class=form_title>Combustibile</td>
         <td valign=top><formwidget id="f_cod_combustibile">
            <formerror  id="f_cod_combustibile"><br>
            <span class="errori">@formerror.f_cod_combustibile;noquote@</span>
            </formerror>
         </td>
      </tr>

      <tr>
         <td valign=top align=right class=form_title>Via</td>
         <td valign=top><formwidget id="f_desc_topo">
             <formwidget id="f_desc_via">@cerca_viae;noquote@
             <formerror  id="f_desc_via"><br>
             <span class="errori">@formerror.f_desc_via;noquote@</span>
             </formerror>
         </td>

         <td valign=top align=right class=form_title>Tipologia</td>
         <td valign=top><formwidget id="f_cod_tpim">
            <formerror  id="f_cod_tpim"><br>
            <span class="errori">@formerror.f_cod_tpim;noquote@</span>
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

         <td valign=top align=right class=form_title>Dest. uso edificio</td>
         <td valign=top><formwidget id="f_cod_tpdu">
            <formerror  id="f_cod_tpdu"><br>
            <span class="errori">@formerror.f_cod_tpdu;noquote@</span>
            </formerror>
         </td>
      </tr>

      <tr>
         <td  valign=top colspan=2 nowrap align=left class=form_title>
             <b>Ricerca per periodo di scadenza</b>
         </td>
         
         <td valign=top align=right class=form_title>Stato impianto</td>
         <td valign=top><formwidget id="f_stato_aimp">
            <formerror  id="f_stato_aimp"><br>
            <span class="errori">@formerror.f_stato_aimp;noquote@</span>
            </formerror>
         </td>

      </tr>

<if @tipo_filtro@ eq MAN or @tipo_filtro@ eq  "" >    <!-- rom01 aggiunta if    -->
      <tr>
         <td valign=top align=right class=form_title colspan=2>Impianti con manutenzione in scadenza tra mesi:
	    <formwidget id="f_mesi_scad_manut">
            <formerror  id="f_mesi_scad_manut"><br>
            <span class="errori">@formerror.f_mesi_scad_manut;noquote@</span>
            </formerror>
         </td>
</if>

<if @tipo_filtro@ eq DICH or @tipo_filtro@ eq "" >	<!-- rom01 aggiunta if    -->
      </tr>
      <tr>
         <td valign=top align=right class=form_title colspan=2>Impianti con dichiarazione in scadenza tra mesi:
	    <formwidget id="f_mesi_scad">
            <formerror  id="f_mesi_scad"><br>
            <span class="errori">@formerror.f_mesi_scad;noquote@</span>
            </formerror>
         </td>

      </tr>
</if>

   </td>
   </table>
</tr>

<tr><td>&nbsp;</td>
<tr><td align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

