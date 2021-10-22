<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<style type="text/css">
fieldset table, input[type="submit"] {
	font-size: 11px;
	line-height: 11px;
}
fieldset input[type="text"] {
	font-size: 11px;
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

<center>

<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_tabella">
<formwidget   id="id_riga">

<!-- Inizio della form colorata -->
  
 	<if @script@ ne "">
		@script;noquote@
	</if>
	<else>
	<table width="100%">
	<font size="1">
		<tr>
			<td align="center" colspan=2>
				<fieldset>
					<legend>Riga: @num_riga_tab;noquote@</legend>
								
					<table width="100%" border="0">
				    <multiple name=multiple_form>
					    <tr>
					    	<td valign="center" align="right" ><%= [set denominazione.@multiple_form.count_anom;noquote@] %></td>
							<td valign="center" align="left" onKeyPress="return noenter(event);">
								<formwidget id="campo.@multiple_form.count_anom;noquote@">
								<formerror  id="campo.@multiple_form.count_anom;noquote@"><br>
						        <span class="errori"><%= $formerror(campo.@multiple_form.count_anom;noquote@) %></span>
						        </formerror>
							</td>
						</tr>
						<tr><td>&nbsp;</td></tr>
					</multiple>
					</table>
			    </fieldset>
		    </td>
	    </tr>
	    <tr><td>&nbsp;</td></tr>
	    <tr>
	    	<td valign=top align="center"><formwidget id="submit_correggi"></td>
	    	<td valign=top align="center"><formwidget id="submit_scarta"></td>
	    </tr>
	    </font>
	</table>
	</else>
    
</formtemplate>
<p>
</center>

