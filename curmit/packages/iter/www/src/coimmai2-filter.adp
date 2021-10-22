<!--
    USER  DATA       MODIFICHE
    ===== ========== =================================================================================
    rom01 21/06/2018 Agguinto campo f_numero_bollino

-->


<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="f_cod_via">
<formwidget   id="dummy">
<if @flag_ente@ eq "C">
    <formwidget id="f_comune">
</if>
<!-- Inizio della form colorata -->

<%=[iter_form_iniz]%>

<if @flag_risultato@ ne t>
<tr>
   <td>
   <table>
      <tr>
         <td valign=top colspan=2 nowrap align=left class=form_title>
             <b>Ricerca per Indirizzo (obbligatorio)</b>
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
         <td valign=top colspan=2 align=left class=form_title>
             <b>Indicare almeno @num_min_parametri@ dei seguenti parametri</b>
         </td>
      </tr>
      <tr>
         <td valign=top align=right class=form_title>Civico</td>
         <td valign=top><formwidget id="f_civico">
             <formerror  id="f_civico"><br>
             <span class="errori">@formerror.f_civico;noquote@</span>
             </formerror>
         </td>
      </tr>

      <tr>
         <td valign=top align=right class=form_title>Codice impianto</td>
         <td valign=top><formwidget id="f_cod_impianto_est">
            <formerror  id="f_cod_impianto_est"><br>
            <span class="errori">@formerror.f_cod_impianto_est;noquote@</span>
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
      </tr>
      <tr>
         <td valign=top align=right class=form_title>Nome</td>
         <td valign=top><formwidget id="f_resp_nome">
            <formerror  id="f_resp_nome"><br>
            <span class="errori">@formerror.f_resp_nome;noquote@</span>
            </formerror>
         </td>
      </tr>
      <tr>
         <td valign=top align=right class=form_title>Matricola</td>
         <td valign=top><formwidget id="f_matricola">
             <formerror  id="f_matricola"><br>
             <span class="errori">@formerror.f_matricola;noquote@</span>
             </formerror>
         </td>
      </tr>
      <tr>
         <td valign=top align=right class=form_title>Modello</td>
         <td valign=top><formwidget id="f_modello">
             <formerror  id="f_modello"><br>
             <span class="errori">@formerror.f_modelloa;noquote@</span>
             </formerror>
         </td>
      </tr>
      <tr>
         <td valign=top align=right class=form_title>Costruttore</td>
         <td valign=top><formwidget id="f_costruttore">
             <formerror  id="f_costruttore"><br>
             <span class="errori">@formerror.f_costruttore;noquote@</span>
             </formerror>
         </td>
      </tr>
<!--   </td> -->
      <tr>
         <td valign=top align=right class=form_title>PDR</td>
         <td valign=top><formwidget id="f_pdr">
             <formerror  id="f_pdr"><br>
             <span class="errori">@formerror.f_pdr;noquote@</span>
             </formerror>
         </td>
      </tr>
      <tr> <!-- rom01 aggiunto tr e contenuto -->
         <td valign=top align=right class=form_title>Numero Bollino</td>
         <td valign=top><formwidget id="f_numero_bollino">
             <formerror  id="f_numero_bollino"><br>
             <span class="errori">@formerror.f_numero_bollino;noquote@</span>
             </formerror>
         </td>
      </tr>
<!--   </td> -->
   </table>
</tr>

<tr><td>&nbsp;</td>
<tr><td align=center><formwidget id="submit"></td></tr>
</if>
<else>
    <tr><td align=center><br><br><br>@error_mex;noquote@</td></tr>
</else>
<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

