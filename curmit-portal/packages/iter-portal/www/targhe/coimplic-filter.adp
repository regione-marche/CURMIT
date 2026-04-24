<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context_bar">@context_bar;noquote@</property>

  <center>
    <formtemplate id="@form_name@">
      <formwidget   id="funzione">
	<formwidget   id="caller">
	  <formwidget   id="nome_funz">
	      <formwidget   id="dummy">

		<!-- Inizio della form colorata -->
		<%=[iter_form_iniz]%>
		<tr><td colspan=2>&nbsp;</td></tr>
		<tr>
		  <td valign=top align=right class=form_title>Manutentore</td>
		  <td valign=top nowrap><formwidget id="cognome_manu">@cerca_manu;noquote@ <!-- gab01 -->
		      <formerror  id="cognome_manu"><br>
			<span class="errori">@formerror.cognome_manu;noquote@</span>
		      </formerror>
		  </td>
		</tr>
		<tr>
		  <td valign=top align=right class=form_title>Da data consegna</td>
		  <td valign=top nowrap><formwidget id="f_data_ril_da">
		      <formerror  id="f_data_ril_da"><br>
			<span class="errori">@formerror.f_data_ril_da;noquote@</span>
		      </formerror>
		  </td>
		</tr>
		<tr>
		  <td valign=top align=right class=form_title>A data consegna</td>
		  <td valign=top nowrap><formwidget id="f_data_ril_a">
		      <formerror  id="f_data_ril_a"><br>
			<span class="errori">@formerror.f_data_ril_a;noquote@</span>
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


