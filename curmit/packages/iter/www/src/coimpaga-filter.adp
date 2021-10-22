<master   src="../master">
  <property name="title">@page_title;noquote@</property>
  <property name="context_bar">@context_bar;noquote@</property>
  <property name="riga_vuota">f</property>


  <center>
    <formtemplate id="@form_name;noquote@">
      <formwidget   id="funzione">
	<formwidget   id="caller">
	  <formwidget   id="nome_funz">
	    <formwidget   id="nome_funz_caller">
	      <if @flag_ente@ eq C>
		<formwidget id="f_cod_comune">
	      </if>
	      <!-- Inizio della form colorata -->
	      <%=[iter_form_iniz]%>

	      <if @flag_ente@ ne C>
		<tr><td valign=top align=right class=form_title>Comune</td>
		  <td valign=top><formwidget id="f_cod_comune">
		      <formerror  id="f_cod_comune"><br>
			<span class="errori">@formerror.f_cod_comune;noquote@</span>
		      </formerror>
		  </td>
		</tr>
	      </if>

	      <tr><td valign=top align=right class=form_title>Da data scadenza</td>
		<td valign=top><formwidget id="f_data_da">
		    <formerror  id="f_data_da"><br>
		      <span class="errori">@formerror.f_data_da;noquote@</span>
		    </formerror>
		</td>
	      </tr>

	      <tr>
		<td valign=top align=right class=form_title>A data scadenza</td>
		<td valign=top nowrap><formwidget id="f_data_a">
		    <formerror  id="f_data_a"><br>
		      <span class="errori">@formerror.f_data_a;noquote@</span>
		    </formerror>
		</td>
	      </tr>

	      <tr><td valign=top align=right class=form_title>Tipo</td>
		<td valign=top><formwidget id="f_id_caus">
		    <formerror  id="f_id_caus"><br>
		      <span class="errori">@formerror.f_id_caus;noquote@</span>
		    </formerror>
		</td>
	      </tr>

	      <tr><td colspan=2>&nbsp;</td></tr>

	      <if @funzione@ eq "V">
		<tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
	      </if>

	      <!-- Fine della form colorata -->
	      <%=[iter_form_fine]%>

    </formtemplate>
    <p>
  </center>

