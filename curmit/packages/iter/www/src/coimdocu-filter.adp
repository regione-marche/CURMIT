<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="dummy">
<formwidget   id="nome_funz_caller">
<formwidget   id="f_cod_sogg">
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr>

</tr>
      <tr>
         <td valign=top align=right class=form_title>Codice impianto</td>
         <td valign=top><formwidget id="f_cod_impianto_est">
            <formerror  id="f_cod_impianto_est"><br>
            <span class="errori">@formerror.f_cod_impianto_est;noquote@</span>
            </formerror>
         </td>
         <td valign=top align=right class=form_title>Tipologia documento</td>
         <td valign=top><formwidget id="f_tipo_doc">
            <formerror  id="f_tipo_doc"><br>
            <span class="errori">@formerror.f_tipo_doc;noquote@</span>
            </formerror>
         </td>
      </tr>

      <tr>
         <th valign=top align=right classform_title>Selezione per protocollo 1</th>
      <tr>
      <tr>
         <td valign=top align=right class=form_title>Numero Da</td>
         <td valign=top><formwidget id="f_da_num_prot">
            <formerror  id="f_da_num_prot"><br>
            <span class="errori">@formerror.f_da_num_prot;noquote@</span>
            </formerror>
         </td>

         <td valign=top align=right class=form_title>A</td>
         <td valign=top><formwidget id="f_a_num_prot">
            <formerror id="f_a_num_prot"><br>
            <span class="errori">@formerror.f_a_num_prot;noquote@</span>
            </formerror>
         </td>
      </tr>

      <tr>
         <td valign=top align=right class=form_title>Data Da</td>
         <td valign=top><formwidget id="f_da_dat_prot">
            <formerror id="f_da_dat_prot"><br>
            <span class="errori">@formerror.f_da_dat_prot;noquote@</span>
            </formerror>
         </td>
 
         <td valign=top align=right class=form_title>A</td>
         <td valign=top><formwidget id="f_a_dat_prot">
            <formerror id="f_a_dat_prot"><br>
            <span class="errori">@formerror.f_a_dat_prot;noquote@</span>
            </formerror>
         </td>
      </tr>

      <tr>
         <th valign=top align=right classform_title>Selezione per protocollo 2</th>
      <tr>
      <tr>
         <td valign=top align=right class=form_title>Numero Da</td>
         <td valign=top><formwidget id="f_da_num_prot2">
            <formerror  id="f_da_num_prot2"><br>
            <span class="errori">@formerror.f_da_num_prot2;noquote@</span>
            </formerror>
         </td>

         <td valign=top align=right class=form_title>A</td>
         <td valign=top><formwidget id="f_a_num_prot2">
            <formerror id="f_a_num_prot2"><br>
            <span class="errori">@formerror.f_a_num_prot2;noquote@</span>
            </formerror>
         </td>
      </tr>

      <tr>
         <td valign=top align=right class=form_title>Data Da</td>
         <td valign=top><formwidget id="f_da_dat_prot2">
            <formerror id="f_da_dat_prot2"><br>
            <span class="errori">@formerror.f_da_dat_prot2;noquote@</span>
            </formerror>
         </td>
 
         <td valign=top align=right class=form_title>A</td>
         <td valign=top><formwidget id="f_a_dat_prot2">
            <formerror id="f_a_dat_prot2"><br>
            <span class="errori">@formerror.f_a_dat_prot2;noquote@</span>
            </formerror>
         </td>
      </tr> 
 
      <tr>
          <th valign=top align=right class=form_title>Selezione per data Stampa</th>
      </tr>
      <tr> 
         <td valign=top align=right class=form_title>Da</td>
         <td valign=top><formwidget id="f_da_data_stp">
            <formerror  id="f_da_data_stp"><br>
            <span class="errori">@formerror.f_da_data_stp;noquote@</span>
            </formerror>
         </td>

         <td valign=top align=right class=form_title>A</td>
         <td valign=top><formwidget id="f_a_data_stp">
            <formerror id="f_a_data_stp"><br>
            <span class="errori">@formerror.f_a_data_stp;noquote@</span>
            </formerror>
         </td>
      </tr>

      <tr>
          <th valign=top align=right class=form_title>Selezione Responsabile</th>
      </tr>
      <tr>
         <td valign=top align=right class=form_title>Cognome</td>
         <td valign=top><formwidget id="f_cogn_resp">
            <formerror  id="f_cogn_resp"><br>
            <span class="errori">@formerror.f_cogn_resp;noquote@</span>
            </formerror>
         </td>
         <td valign=top align=right class=form_title>Nome</td>
         <td valign=top><formwidget id="f_nome_resp">@cerca_resp;noquote@
            <formerror  id="f_nome_resp"><br>
            <span class="errori">@formerror.f_nome_resp;noquote@</span>
            </formerror>
         </td>
      </tr>
      <tr>
         <th valign=top align=right class=form_title>Selezione Manutentore</th>
      </tr>
      <tr>
         <td valign=top align=right class=form_title>Cognome</td>
         <td valign=top><formwidget id="f_manu_cogn">
	    <formerror  id="f_manu_cogn"><br>
	    <span class="errori">@formerror.f_manu_cogn;noquote@</span>
	    </formerror>
         </td>
         <td valign=top align=right class=form_title>Nome</td>
         <td valign=top><formwidget id="f_manu_nome">@cerca_manu;noquote@
	    <formerror  id="f_manu_nome"><br>
	    <span class="errori">@formerror.f_manu_nome;noquote@</span>
	    </formerror>
         </td>
      </tr>


<tr><td>&nbsp;</td>
<tr><td align=center colspan=4><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

