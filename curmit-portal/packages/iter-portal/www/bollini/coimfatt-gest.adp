<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context_bar">@context_bar;noquote@</property>
  <property name="riga_vuota">f</property>

  <table width="100%" cellspacing=0 class=func-menu>
    <tr>
      <td colspan=4>&nbsp;</td>
    </tr>
    <tr>
      <if @ritorna_gest@ eq "">
	<td width="25%" nowrap class=func-menu>
          <a href="coimfatt-list?@link_list_fatt;noquote@" class=func-menu>Ritorna</a>
	</td>
      </if>
      <else>
	<td width="25%" nowrap class=func-menu>
	  <a href=@ritorna_gest;noquote@ class=func-menu>Ritorna</a>
	</td>
      </else>
      <if @funzione@ eq "I">
	<td colspan=3 nowrap class=func-menu>&nbsp;</td>
      </if>
      <else>
	<td width="25%" nowrap class=@func_v;noquote@>
          <a href="coimfatt-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
	</td>
	<td width="25%" nowrap class=@func_m;noquote@>
          <a href="coimfatt-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
	</td>
	<td width="25%" nowrap class=@func_d;noquote@>
          <a href="coimfatt-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
	</td>
      </else>
    </tr>
    <if @funzione@ ne "I">
      <tr>
	<td width="25%" nowrap class=func-menu> 
          <a href="coimfatt-layout?@link_stampa;noquote@" class=func-menu>Stampa fattura</a>
	</td>
	<td colspan=2 class=func-menu>&nbsp;</td>
      </tr>
    </if>
    <tr>
      <td colspan=4>&nbsp;</td>
    </tr>
  </table>

  <center>
    <formtemplate id="@form_name;noquote@">
      <formwidget   id="funzione">
	<formwidget   id="caller">
	  <formwidget   id="nome_funz">
	    <formwidget   id="nome_funz_caller">
	      <formwidget   id="extra_par">
		<formwidget   id="last_cod_fatt">
		  <formwidget   id="cod_fatt">
		    <formwidget   id="tipo_sogg">
		      <formwidget   id="cod_sogg">
			
			<!-- Inizio della form colorata -->
			<%=[iter_form_iniz]%>
			
			<!-- TODO: Ricordare di posizionare gli eventuali link ai pgm di zoom -->
			<tr>
			  <td valign=top align=right class=form_title>Data fattura</td>
			  <td valign=top><formwidget id="data_fatt">
			      <formerror  id="data_fatt"><br>
				<span class="errori">@formerror.data_fatt;noquote@</span>
			      </formerror>
			  </td>
			  <td valign=top align=right class=form_title>Numero fattura</td>
			  <td valign=top><formwidget id="num_fatt">
			      <formerror  id="num_fatt"><br>
				<span class="errori">@formerror.num_fatt;noquote@</span>
			      </formerror>
			  </td>
			  <td valign=top align=right class=form_title>Tot. bollini</td>
			  <td valign=top><formwidget id="n_bollini">
			      <formerror  id="n_bollini"><br>
				<span class="errori">@formerror.n_bollini</span>
			      </formerror>
			  </td>	
			</tr>
			<tr>
			  <if @funzione@ eq I or @funzione@ eq M>
			    <td valign=top align=right class=form_title>Manutentore</td>
			    <td valign=top colspan=5><formwidget id="manutentore">
				<formerror  id="manutentore"><br>
				  <span class="errori">@formerror.manutentore;noquote@</span>
				</formerror>
			    </td>
			  </if>
			  <else>
			    <td valign=top align=right class=form_title>Manutentore</td>
			    <td valign=top colspan=5><formwidget id="manutentore">
				<formerror  id="manutentore"><br>
				  <span class="errori">@formerror.manutentore;noquote@</span>
				</formerror>
			    </td>
			  </else>
			</tr>
			<tr>
			  <td valign=top align=right class=form_title>Imponibile</td>
			  <td valign=top><formwidget id="imponibile">
			      <formerror  id="imponibile"><br>
				<span class="errori">@formerror.imponibile;noquote@</span>
			      </formerror>
			  </td>
			  <td valign=top align=right class=form_title>Perc. iva</td>
			  <td valign=top><formwidget id="perc_iva">
			      <formerror  id="perc_iva"><br>
				<span class="errori">@formerror.perc_iva;noquote@</span>
			      </formerror>
			  </td>
			  <td valign=top align=right class=form_title>Importo Fattura</td>
			  <td valign=top><formwidget id="importo">
			      <formerror  id="importo"><br>
				<span class="errori">@formerror.importo</span>
			      </formerror>
			  </td>	
			</tr>
			<tr>
			  <td valign=top align=right class=form_title>Pagato</td>
			  <td valign=top><formwidget id="flag_pag">
			      <formerror  id="flag_pag"><br>
				<span class="errori">@formerror.flag_pag;noquote@</span>
			      </formerror>
			  </td>
			  <td valign=top align=right class=form_title>Modalita' di pagamento</td>
			  <td valign=top><formwidget id="mod_pag">
			      <formerror  id="mod_pag"><br>
				<span class="errori">@formerror.mod_pag;noquote@</span>
			      </formerror>
			  </td>
			  <td valign=top align=right class=form_title>Importo pag.</td>
			  <td valign=top><formwidget id="importo_pag_edit">
			      <formerror  id="importo_pag_edit"><br>
				<span class="errori">@formerror.importo_pag_edit;noquote@</span>
			      </formerror>
			  </td>
			</tr>
			<tr>
			    <td valign=top align=right class=form_title>Data pag.</td>
			  <td valign=top><formwidget id="data_pag_edit">
			      <formerror  id="data_pag_edit"><br>
				<span class="errori">@formerror.data_pag_edit;noquote@</span>
			      </formerror>
			  </td>
			  <td valign=top align=right class=form_title>Split Payment</td>
                          <td valign=top><formwidget id="flag_split_payment">
                              <formerror  id="flag_split_payment"><br>
                                <span class="errori">@formerror.flag_split_payment;noquote@</span>
                              </formerror>
                          </td>
			  <td></td>

			</tr>
			<tr>
			  <td valign=top align=right class=form_title>Nota</td>
			  <td colspan=6 valign=top><formwidget id="nota">
			      <formerror  id="nota"><br>
				<span class="errori">@formerror.nota</span>
			      </formerror>
			  </td>
			</tr>
			<tr>
  			  <td colspan=6>&nbsp;</td>
			</tr>

			<!-- Fine della form colorata -->
			<%=[iter_form_fine]%>

			<!-- Inizio della form colorata -->
			<%=[iter_form_iniz]%>

			<tr>
			  <td width=10% valign=top align=right class=form_title>Nr. bollini</td>
			  <td width=11% valign=top><formwidget id="n_bollini1">
			      <formerror  id="n_bollini1"><br>
				<span class="errori">@formerror.n_bollini1</span>
			      </formerror>
			  </td>
			  <td width=10% valign=top align=right class=form_title>Da matricola</td>
			  <td width=11% valign=top><formwidget id="matr_da1">
			      <formerror  id="matr_da1"><br>
				<span class="errori">@formerror.matr_da1;noquote@</span>
			      </formerror>
			  </td>
			  <td width=10% valign=top align=right class=form_title>A matricola</td>
			  <td width=11% valign=top><formwidget id="matr_a1">
			      <formerror  id="matr_a1"><br>
				<span class="errori">@formerror.matr_a1;noquote@</span>
			      </formerror>
			  </td>

			  <td valign=top align=right class=form_title>Imp. bollini</td>
			  <td valign=top><formwidget id="imp_pagato1">
			      <formerror id="imp_pagato1"><br>
				<span class="errori">@formerror.imp_pagato1;noquote@</span>
			      </formerror>
			  </td>
			</tr>
			<tr>
			  <td width=10% valign=top align=right class=form_title>Nr. bollini</td>
			  <td width=11% valign=top><formwidget id="n_bollini2">
			      <formerror  id="n_bollini2"><br>
				<span class="errori">@formerror.n_bollini2</span>
			      </formerror>
			  </td>
			  <td width=10% valign=top align=right class=form_title>Da matricola</td>
			  <td width=11% valign=top><formwidget id="matr_da2">
			      <formerror  id="matr_da2"><br>
				<span class="errori">@formerror.matr_da2;noquote@</span>
			      </formerror>
			  </td>

			  <td width=10% valign=top align=right class=form_title>A matricola</td>
			  <td width=11% valign=top><formwidget id="matr_a2">
			      <formerror  id="matr_a2"><br>
				<span class="errori">@formerror.matr_a2;noquote@</span>
			      </formerror>
			  </td>

			  <td valign=top align=right class=form_title>Imp. bollini</td>
			  <td valign=top><formwidget id="imp_pagato2">
			      <formerror id="imp_pagato2"><br>
				<span class="errori">@formerror.imp_pagato2;noquote@</span>
			      </formerror>
			  </td>
			</tr>

			<tr>
			  <td width=10% valign=top align=right class=form_title>Nr. bollini</td>
			  <td width=11% valign=top><formwidget id="n_bollini3">
			      <formerror  id="n_bollini3"><br>
				<span class="errori">@formerror.n_bollini3</span>
			      </formerror>
			  </td>

			  <td width=10% valign=top align=right class=form_title>Da matricola</td>
			  <td width=11% valign=top><formwidget id="matr_da3">
			      <formerror  id="matr_da3"><br>
				<span class="errori">@formerror.matr_da3;noquote@</span>
			      </formerror>
			  </td>
			  <td width=10% valign=top align=right class=form_title>A matricola</td>
			  <td width=11% valign=top><formwidget id="matr_a3">
			      <formerror  id="matr_a3"><br>
				<span class="errori">@formerror.matr_a3;noquote@</span>
			      </formerror>
			  </td>

			  <td valign=top align=right class=form_title>Imp. bollini</td>
			  <td valign=top><formwidget id="imp_pagato3">
			      <formerror id="imp_pagato3"><br>
				<span class="errori">@formerror.imp_pagato3;noquote@</span>
			      </formerror>
			  </td>
			</tr>

			<tr>
			  <td width=10% valign=top align=right class=form_title>Nr. bollini</td>
			  <td width=11% valign=top><formwidget id="n_bollini4">
			      <formerror  id="n_bollini4"><br>
				<span class="errori">@formerror.n_bollini4</span>
			      </formerror>
			  </td>

			  <td width=10% valign=top align=right class=form_title>Da matricola</td>
			  <td width=11% valign=top><formwidget id="matr_da4">
			      <formerror  id="matr_da4"><br>
				<span class="errori">@formerror.matr_da4;noquote@</span>
			      </formerror>
			  </td>

			  <td width=10% valign=top align=right class=form_title>A matricola</td>
			  <td width=11% valign=top><formwidget id="matr_a4">
			      <formerror  id="matr_a4"><br>
				<span class="errori">@formerror.matr_a4;noquote@</span>
			      </formerror>
			  </td>
			  <td valign=top align=right class=form_title>Imp. bollini</td>
			  <td valign=top><formwidget id="imp_pagato4">
			      <formerror id="imp_pagato4"><br>
				<span class="errori">@formerror.imp_pagato4;noquote@</span>
			      </formerror>
			  </td>
			</tr>
			<tr>
  			  <td colspan=8>&nbsp;</td>
			</tr>
			<if @funzione@ ne "V">
			  <tr>
			    <td colspan=8 align=center><formwidget id="submit"></td>
			  </tr>
			</if>
			<!-- Fine della form colorata -->
			<%=[iter_form_fine]%>
			
    </formtemplate>
    <p>
  </center>
  
