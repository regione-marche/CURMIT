<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>

  <center>
    <formtemplate id="@form_name;noquote@">
      <formwidget   id="nome_funz">
	<formwidget   id="nome_funz_caller">
	  <!-- Inizio della form colorata -->
	  <%=[iter_form_iniz]%>

	  <tr>
            <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
	    <td valign=top align=right class=form_title>Manutentore</td>
	    <td valign=top nowrap><formwidget id="f_cod_manu">
		<formerror  id="f_cod_manu"><br>
		  <span class="errori">@formerror.f_cod_manu;noquote@</span>
		</formerror>
	    </td>
	  </tr>
	  <tr>
	    <td valign=top align=right class=form_title>Numero fattura</td>
	    <td valign=top nowrap><formwidget id="f_num_fatt">
		<formerror  id="f_num_fatt"><br>
		  <span class="errori">@formerror.f_num_fatt;noquote@</span>
		</formerror>
	    </td>
	  </tr>
	  <tr>
	    <td valign=top align=right class=form_title>Da data fattura</td>
	    <td valign=top nowrap colspan=3><formwidget id="f_da_data_fatt">
		<formerror  id="f_da_data_fatt"><br>
		  <span class="errori">@formerror.f_da_data_fatt;noquote@</span>
		</formerror>
	    </td>
	  </tr>
	  <tr>
	    <td valign=top align=right class=form_title>A data fattura</td>
	    <td valign=top nowrap><formwidget id="f_a_data_fatt">
		<formerror  id="f_a_data_fatt"><br>
		  <span class="errori">@formerror.f_a_data_fatt;noquote@</span>
		</formerror>
	    </td>
	  </tr>
          <tr>
	    <td valign=top align=right class=form_title>Pagato S/N</td>
	    <td valign=top nowrap><formwidget id="f_flag_pag">
		<formerror  id="f_flag_pag"><br>
		  <span class="errori">@formerror.f_flag_pag;noquote@</span>
		</formerror>
	    </td>
	  </tr>

	  <tr><td colspan=2>&nbsp;</td></tr>
	  <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>

	  <!-- Fine della form colorata -->
	  <%=[iter_form_fine]%>

    </formtemplate>
    <p>
  </center>
