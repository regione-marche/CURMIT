<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<style type="text/css">
table {
	line-height: 15px;
}
fieldset table, input[type="button"], input[type="submit"] {
	font-size: 11px;
	line-height: 12px;
}
fieldset input[type="text"] {
	font-size: 11px;
}
fieldset select {
	font-size: 11px;
	font-family: 'Courier New';
}
fieldset a {
	font-size: 12px;
}
</style>

<script type="text/javascript">
function noenter(e) {
  var key;     
  if(window.event)
  	key = window.event.keyCode; //IE
  else
  	key = e.which; //firefox     
  return (key != 13);
}
</script>

<!-- barra con il cerca, link di aggiungi e righe per pagina -->
@list_head;noquote@

<center>

<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="dummy">
<formwidget   id="nome_tabella">
<formwidget   id="cod_batc">
	
	<if @funzione@ eq "R">
		<tr>
			<td valign=top class=form_title align=center colspan=4><b>ELABORAZIONE AVVIATA</b></td>
		</tr>
		<tr>
			<td valign=top class=form_title align=center colspan=4>Clicca 'Chiudi finestra' e controlla lo stato dell'elaborazione in 'Consultazione lavori in esecuzione'</td>
		</tr>
	</if>
	<else>
	<tr><td valign="top" align="center" class="form_title"><b>Dichiarazioni accettate: @count_imp_acc;noquote@</b></td></tr>
 	<tr><td>&nbsp;</td></tr>
 	<tr><td valign="top" align="center" class="form_title"><b>Dichiarazioni scartate: @count_imp_scar;noquote@</b></td></tr>
 	<tr><td>&nbsp;</td></tr>	
	<tr><td valign="top" align="center" class="form_title"><b>Dichiarazioni  con errori: @count_imp_anom;noquote@</b></td></tr>
    <tr><td>&nbsp;</td></tr>	
	<tr><td valign="top" align="center" class="form_title"><b><font color=red>Correggere tutte le righe o scartarle e rilanciare l'elaborazione</b></font></td></tr>
	<tr><td>&nbsp;</td></tr>
	
	<multiple name=multiple_form>
		<tr>
			<td>
				<fieldset>
				<legend>Riga: @multiple_form.count_imp_anom;noquote@</legend>
				
				<table width="100%" border="0">
				
				<tr>
	    	    	<formwidget id="id_riga_@multiple_form.count_imp_anom;noquote@">
	    	    	<formwidget id="num_riga_tab_@multiple_form.count_imp_anom;noquote@">
		    	</tr>
		    	
		    	<tr>
			    	<td valign="center" align="right" >Codice</td>
			  		<td valign="center" align="left" onKeyPress="return noenter(event);">
						<formwidget id="cod_impianto_est.@multiple_form.count_imp_anom;noquote@">
						<formerror  id="cod_impianto_est.@multiple_form.count_imp_anom;noquote@"><br>
				        <span class="errori"><%= $formerror(cod_impianto_est.@multiple_form.count_imp_anom;noquote@) %></span>
				        </formerror>
			        </td>
				<if @tabella_caricamento_rcee_tipo_1@ ne "rce1">
			        <td valign="center" align="right">Pot.Nom.</td>
				    <td valign="center" align="left" onKeyPress="return noenter(event);">
				    	<formwidget id="potenza_foc_nom.@multiple_form.count_imp_anom;noquote@">
					    <formerror  id="potenza_foc_nom.@multiple_form.count_imp_anom;noquote@"><br>
				        <span class="errori"><%= $formerror(potenza_foc_nom.@multiple_form.count_imp_anom;noquote@) %></span>
				        </formerror>
				    </td>
				</if>
			        <td valign="center" align="right" >Combustibile</td>
				    <td valign="center" align="left">
					    <formwidget id="cod_combustibile.@multiple_form.count_imp_anom;noquote@">
					    <formerror  id="cod_combustibile.@multiple_form.count_imp_anom;noquote@"><br>
		         		<span class="errori"><%= $formerror(cod_combustibile.@multiple_form.count_imp_anom;noquote@) %></span>
		         		</formerror>
	         		</td>
	         		
	         		<td valign="center" align="right" >Indirizzo</td>
				    <td valign="center" align="left" onKeyPress="return noenter(event);">
				    	<formwidget id="descr_topo_@multiple_form.count_imp_anom;noquote@">&nbsp;
				    	<formwidget id="descr_via_@multiple_form.count_imp_anom;noquote@"><%= [set cerca_viae.@multiple_form.count_imp_anom;noquote@] %>
				    	<formerror  id="descr_topo_@multiple_form.count_imp_anom;noquote@"><br>
	         				<span class="errori"><%= $formerror(descr_topo_@multiple_form.count_imp_anom;noquote@) %></span>
	     				</formerror>
				    	<formerror  id="descr_via_@multiple_form.count_imp_anom;noquote@"><br>
	         				<span class="errori"><%= $formerror(descr_via_@multiple_form.count_imp_anom;noquote@) %></span>
	     				</formerror>
	 				</td>
         		</tr>
		        <tr>
			        <td valign="center" align="right" >Matricola</td>
				    <td valign="center" align="left" onKeyPress="return noenter(event);">
				    	<formwidget id="matricola.@multiple_form.count_imp_anom;noquote@">
					    <formerror  id="matricola.@multiple_form.count_imp_anom;noquote@"><br>
				        <span class="errori"><%= $formerror(matricola.@multiple_form.count_imp_anom;noquote@) %></span>
				        </formerror>
				    </td>
				    <if @tabella_caricamento_rcee_tipo_1@ ne "rce1">
				    <if @tipo_modello@ eq "G">
				    	<td valign="center" align="right">Pot.Utile Nom.</td>
				   	</if>
				   	<else>
				   		<td valign="center" align="right">Pot.Nom.Foc.Gen.</td>
				   	</else>
				    <td valign="center" align="left" onKeyPress="return noenter(event);">
				    	<formwidget id="potenza_nominale.@multiple_form.count_imp_anom;noquote@">
						<formerror  id="potenza_nominale.@multiple_form.count_imp_anom;noquote@"><br>
				        <span class="errori"><%= $formerror(potenza_nominale.@multiple_form.count_imp_anom;noquote@) %></span>
				        </formerror>
			        </td>
				</if>
				    <td valign="center" align="right" >Costruttore</td>
				    <td valign="center" align="left">
					    <formwidget id="cod_cost.@multiple_form.count_imp_anom;noquote@">
					    <formerror  id="cod_cost.@multiple_form.count_imp_anom;noquote@"><br>
		         		<span class="errori"><%= $formerror(cod_cost.@multiple_form.count_imp_anom;noquote@) %></span>
		         		</formerror>
		         	</td>
		         	<td valign="center" align="right" >Comune</td>
	         		 <td colspan="3" valign="center" align="left">
				    	<formwidget id="cod_comune_@multiple_form.count_imp_anom;noquote@">
					    <formerror  id="cod_comune_@multiple_form.count_imp_anom;noquote@"><br>
				        <span class="errori"><%= $formerror(cod_comune_@multiple_form.count_imp_anom;noquote@) %></span>
				        </formerror>
				    </td>
	         	</tr>

				<tr>
					<td colspan="4" align="left">
						<%= [set link_altri_err.@multiple_form.count_imp_anom;noquote@] %>
				    </td>
				    <td colspan="4" align="right">
						<formwidget id="submit_scarta.@multiple_form.count_imp_anom;noquote@">
				    </td>
				</tr>
				</table>
				</fieldset>
			</td>
		</tr>
		<tr><td  >&nbsp;</td></tr>
	</multiple>
	
	<tr><td valign=top align="center"><formwidget id="submit_rilancia"></td></tr>
	
	</else>
</formtemplate>
<p>
</center>


