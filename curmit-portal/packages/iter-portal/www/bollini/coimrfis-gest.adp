<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context_bar">@context_bar;noquote@</property>
  <property name="riga_vuota">f</property>
  
  <table width="100%" cellspacing=0 class=func-menu>
    <tr>
      <td width="25%" nowrap class=func-menu>&nbsp;</td>
      <td width="25%" nowrap class=func-menu>&nbsp;</td>
      <td width="25%" nowrap class=func-menu>&nbsp;</td>
      <td width="25%" nowrap class=func-menu>&nbsp;</td>
    </tr>
    <tr>
      <if @ritorna_gest@ eq "">
	<td width="25%" nowrap class=func-menu>
          <a href="coimrfis-list?@link_list;noquote@" class=func-menu>Ritorna</a>
	</td>
      </if>
      <else>
	<td width="25%" nowrap class=func-menu>
	  <a href=@ritorna_gest;noquote@ class=func-menu>Ritorna</a>
	</td>
      </else>
      <if @funzione@ eq "I">
	<td width="25%" nowrap class=func-menu>&nbsp;</td>
	<td width="25%" nowrap class=func-menu>&nbsp;</td>
	<td width="25%" nowrap class=func-menu>&nbsp;</td>
      </if>
      <else>
	<td width="25%" nowrap class=@func_v;noquote@>
          <a href="coimrfis-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
	</td>
	<td width="25%" nowrap class=@func_m;noquote@>
          <a href="coimrfis-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
	</td>
	<td width="25%" nowrap class=@func_d;noquote@>
          <a href="coimrfis-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
	</td>
      </else>
    </tr>
    <if @funzione@ ne "I">
      <tr>
	<td width="25%" nowrap class=func-menu> 
          <a href="coimrfis-layout?@link_stampa;noquote@" class=func-menu>Stampa ricevuta</a>
	</td>
	<td width="25%" nowrap class=func-menu>&nbsp;</td>
	<td width="25%" nowrap class=func-menu>&nbsp;</td>
	<td width="25%" nowrap class=func-menu>&nbsp;</td>
      </tr>
    </if>
  </table>
  
  <center>
    <formtemplate id="@form_name;noquote@">
      <formwidget   id="funzione">
	<formwidget   id="caller">
	  <formwidget   id="nome_funz">
	    <formwidget   id="nome_funz_caller">
	      <formwidget   id="extra_par">
		<formwidget   id="last_cod_rfis">
		  <formwidget   id="cod_rfis">
		    <formwidget   id="tipo_sogg">
		      <formwidget   id="cod_sogg">

			<!-- Inizio della form colorata -->
			<%=[iter_form_iniz]%>
			
			<!-- TODO: Ricordare di posizionare gli eventuali link ai pgm di zoom -->
			<tr>
			  <td valign=top align=right class=form_title>Data rfis</td>
			  <td valign=top><formwidget id="data_rfis">
			      <formerror  id="data_rfis"><br>
				<span class="errori">@formerror.data_rfis;noquote@</span>
			      </formerror>
			  </td>
			  <td valign=top align=right class=form_title>Numero R.Fisc.</td>
			  <td valign=top><formwidget id="num_rfis">
			      <formerror  id="num_rfis"><br>
				<span class="errori">@formerror.num_rfis;noquote@</span>
			      </formerror>
			  </td>
			  <td valign=top align=right class=form_title>Estr. Vers.</td>
			  <td valign=top><formwidget id="estr_pag">
			      <formerror  id="estr_vers"><br>
				<span class="errori">@formerror.estr_vers;noquote@</span>
			      </formerror>
			  </td>
			</tr>
			<tr>
			  <if @funzione@ eq I or @funzione@ eq M>
			    <td valign=top align=right class=form_title>Manutentore</td>
			    <td valign=top colspan=3><formwidget id="manutentore">
				<formerror  id="manutentore"><br>
				  <span class="errori">@formerror.manutentore;noquote@</span>
				</formerror>
			    </td>
			  </if>
			  <else>
			    <td valign=top align=right class=form_title>Manutentore</td>
			    <td valign=top colspan=3><formwidget id="manutentore">
				<formerror  id="manutentore"><br>
				  <span class="errori">@formerror.manutentore;noquote@</span>
				</formerror>
			    </td>
			  </else>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			</tr>
			<tr>
			  <td valign=top align=right class=form_title>Importo</td>
			  <td valign=top><formwidget id="imponibile">
			      <formerror  id="imponibile"><br>
				<span class="errori">@formerror.imponibile;noquote@</span>
			      </formerror>
			  </td>
			  <td valign=top align=right class=form_title>Percentuale iva</td>
			  <td valign=top><formwidget id="perc_iva">
			      <formerror  id="perc_iva"><br>
				<span class="errori">@formerror.perc_iva;noquote@</span>
			      </formerror>
			  </td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			</tr>
			<tr><td valign=top align=right class=form_title>Da matricola</td>
			  <td valign=top><formwidget id="matr_da">
			      <formerror  id="matr_da"><br>
				<span class="errori">@formerror.matr_da;noquote@</span>
			      </formerror>
			  </td>
			  <td valign=top align=right class=form_title>A matricola</td>
			  <td valign=top><formwidget id="matr_a">
			      <formerror  id="matr_a"><br>
				<span class="errori">@formerror.matr_a;noquote@</span>
			      </formerror>
			  </td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			</tr>
			<tr>
			  <td valign=top align=right class=form_title>Numero bollini</td>
			  <td valign=top><formwidget id="n_bollini">
			      <formerror  id="n_bollini"><br>
				<span class="errori">@formerror.n_bollini</span>
			      </formerror>
			  </td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			</tr>
			<tr>
			  <td valign=top align=right class=form_title>Pagato</td>
			  <td valign=top><formwidget id="flag_pag">
			      <formerror  id="flag_pag"><br>
				<span class="errori">@formerror.flag_pag;noquote@</span>
			      </formerror>
			  </td>
			  <td valign=top align=right class=form_title>Modalità di pagamento</td>
			  <td valign=top><formwidget id="mod_pag">
			      <formerror  id="mod_pag"><br>
				<span class="errori">@formerror.mod_pag;noquote@</span>
			      </formerror>
			  </td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			</tr>
			<tr>
			  <td valign=top align=right class=form_title>Spese legali</td>
			  <td valign=top><formwidget id="spe_legali">
			      <formerror  id="spe_legali"><br>
				<span class="errori">@formerror.spe_legali;noquote@</span>
			      </formerror>
			  </td>
			  <td valign=top align=right class=form_title>Spese postali</td>
			  <td valign=top><formwidget id="spe_postali">
			      <formerror  id="spe_postali"><br>
				<span class="errori">@formerror.spe_postali;noquote@</span>
			      </formerror>
			  </td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			</tr>
			<tr>
			  <td valign=top align=right class=form_title>Nota</td>
			  <td colspan=3 valign=top><formwidget id="nota">
			      <formerror  id="nota"><br>
				<span class="errori">@formerror.nota</span>
			      </formerror>
			  </td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			</tr>
			<tr>
			  <td valign=top align=right class=form_title>Descr. per fatt. se diversa vendita bollini</td>
			  <td colspan=3 valign=top><formwidget id="desc_fatt">
			      <formerror  id="desc_fatt"><br>
				<span class="errori">@formerror.nota</span>
			      </formerror>
			  </td>
			  <td>&nbsp;</td>
			  <td>&nbsp;</td>
			</tr>
			<tr><td colspan=6>&nbsp;</td></tr>
			<if @funzione@ ne "V">
			  <tr><td colspan=6 align=center><formwidget id="submit"></td></tr>
			</if>
			<!-- Fine della form colorata -->
			<%=[iter_form_fine]%>
    </formtemplate>
    <p>
  </center>
  
