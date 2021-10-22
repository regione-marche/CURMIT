<master   src="../master">
  <property name="title">@page_title;noquote@</property>
  <property name="context_bar">@context_bar;noquote@</property>
  <br>
  <center>
    <formtemplate id="@form_name;noquote@">
      <formwidget   id="funzione">
	<formwidget   id="caller">
	  <formwidget   id="nome_funz">
	    <formwidget   id="nome_funz_caller">
	      <formwidget   id="extra_par">
		<formwidget   id="last_id_impianto">
		  <formwidget   id="url_aimp">
		    <formwidget   id="url_list_aimp">
		      	      
		      <table>
			<tr>
			  <td valign=top width="20%" align=right class=form_title>Data Controllo</td>
			  <td valign=top width="30%"><formwidget id="data_controllo_pretty">
			      <formerror  id="data_controllo_pretty"><br>
				<span class="errori">@formerror.data_controllo_pretty;noquote@</span>
			      </formerror>
			  </td>
			  <td valign=top width="20%" align=right nowrap class=form_title>Data Protocollo</td>
			  <td valign=top width="30%"><formwidget id="data_protocollo_pretty">
			      <formerror  id="data_protocollo_pretty"><br>  
				<span class="errori">@formerror.data_protocollo_pretty;noquote@</span>
			      </formerror>
			  </td>
			</tr>
			
			<tr>
			  <td valign=top width="20%" align=right class=form_title>RESPONSABILE Imp.</td>
			  <td valign=top colspan=3><formwidget id="respnom">
			      <formerror  id="respnom"><br>
				<span class="errori">@formerror.respnom;noquote@</span>
			      </formerror>
			  </td>
			</tr>
			
			<tr>
			  <td valign=top width="20%" align=right class=form_title>RESPONSABILE Indirizzo</td>
			  <td valign=top colspan=3><formwidget id="respindirizzo">
			      <formerror  id="respindirizzo"><br>
				<span class="errori">@formerror.respindirizzo;noquote@</span>
			      </formerror>
			  </td>
			<tr>
			  
			<tr>
			  <td valign=top width="20%" align=right class=form_title>Costruttore</td>
			  <td valign=top width="30%"><formwidget id="caldcostr">
			      <formerror  id="caldcostr"><br>
				<span class="errori">@formerror.caldcostr;noquote@</span>
			      </formerror>
			  </td>
			  <td valign=top width="20%" align=right class=form_title>Modello</td>
			  <td valign=top width="30%"><formwidget id="caldmodel">
			      <formerror  id="caldmodel"><br>
				<span class="errori">@formerror.caldmodel;noquote@</span>
			      </formerror>
			  </td>
			<tr>
			  
			<tr>
			  <td valign=top width="20%" align=right class=form_title>Potenza</td>
			  <td valign=top width="30%"><formwidget id="caldpotkw">
			      <formerror  id="caldpotkw"><br>
				<span class="errori">@formerror.caldpotkw;noquote@</span>
			      </formerror>
			  </td>
			  <td valign=top width="20%" align=right class=form_title>Matricola</td>
			  <td valign=top width="30%"><formwidget id="caldmatr">
			      <formerror  id="caldmatr"><br>
				<span class="errori">@formerror.caldmatr;noquote@</span>
			      </formerror>
			  </td>
			<tr>

			<tr>
			  <td valign=top width="20%" align=right class=form_title>Manutentore</td>
			  <td valign=top width="30%"><formwidget id="tecnid">
			      <formerror  id="tecnid"><br>
				<span class="errori">@formerror.tecnid;noquote@</span>
			      </formerror>
			  </td>
			  <td valign=top width="20%" align=right class=form_title>&nbsp;</td>
			  <td valign=top width="30%" align=right class=form_title>&nbsp;</td>
			<tr>

		      </table>
		      <!-- Fine della form colorata -->

    </formtemplate>
    <p>
  </center>
