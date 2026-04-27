<!--
	USER  DATA       COMMENTO
	===== ========== ===================================================================================================
	mat01 05/09/2025 Modifiche fatte per l'accessibilità. Aggiunto gli script in fondo alla pagina. Sostituito il tag
	mat01            center con un div.


-->

<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context_bar">@context_bar;noquote@</property>

<!--mat01 <center>-->
<div align="center"><!--mat01-->
<formtemplate id="@form_name;noquote@">
  <formwidget   id="function">
    <formwidget   id="caller">
      <formwidget   id="extra_par">
	<formwidget   id="last_id_documento">
	    <formwidget   id="save_tipo_doc">
	      <formwidget   id="last_cognome">
		<formwidget   id="extra_par_occu">
		  <formwidget   id="id_documento">
		    <formwidget id="update_p">
		      
		      
			<!-- Inizio della form colorata -->
			<%=[iter_form_iniz]%>
		      
		      <tr>
			<td valign=top align=right class=form_title>Tipo</td>
			<td valign=top align=left nowrap><formwidget id="tipo_doc">
			    <formerror  id="tipo_doc"><br>
			      <span class="errori">@formerror.tipo_doc@</span>
			    </formerror>
			</td>
			<td valign=top align=right class=form_title>Documento</td>
			<td valign=top align=left colspan=3><formwidget id="documento"><br>@link_docu;noquote@
			    <formerror  id="documento"><br>
			      <span class="errori">@formerror.documento@</span>
			    </formerror>
			</td>
		      </tr>
		      
		      <tr><td valign=top align=right class=form_title>Oggetto</td>
			<td valign=top align=left colspan=3><formwidget id="oggetto">
			    <formerror  id="oggetto"><br>
			      <span class="errori">@formerror.oggetto@</span>
			    </formerror>
			</td>
		      </tr>
		      
		      <tr><td valign=top align=right class=form_title>Protocollo</td>
			<td valign=top align=left><formwidget id="id_num_protocollo">
			    <formerror  id="id_num_protocollo"><br>
			      <span class="errori">@formerror.id_num_protocollo@</span>
			    </formerror>
			</td>
			<td valign=top align=right class=form_title>Data protocollo</td>
			<td valign=top align=left><formwidget id="protocollo_dt">
			    <formerror  id="protocollo_dt"><br>
			      <span class="errori">@formerror.protocollo_dt@</span>
			    </formerror>
			</td>
		      </tr>

		      <if @update_p@ eq t>
			<tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
		      </if>
			<!-- Fine della form colorata -->
			<%=[iter_form_fine]%>
		      
</formtemplate>
<!--mat01 </center>-->
<!--mat01 <p> -->
</div><!--mat01-->
<!--mat01 aggiunto script-->
<script>
  <!--mat01 aggiunto script-->
    document.addEventListener("DOMContentLoaded", function() {
        document.querySelectorAll("form input, form textarea, form select").forEach(function(el) {
	      el.setAttribute("autocomplete", "off");
	          });
		    });
</script>

<script>
  document.addEventListener("DOMContentLoaded", function () {
      const tables = document.querySelectorAll("table");

    tables.forEach(function (table) {
          const rows = table.querySelectorAll("tr");

      for (let rowIndex = 0; rowIndex < rows.length; rowIndex++) {
              const currentRow = rows[rowIndex];
	              const titleTds = currentRow.querySelectorAll("td.form_title");

        titleTds.forEach(function (titleTd, columnIndex) {
	          // Salta se già etichettato
		            if (titleTd.querySelector("label")) return;

          let input = null;

          // 1. Prova a trovare input nel td accanto nella stessa riga
	            const siblingTd = titleTd.nextElementSibling;
		              if (siblingTd) {
			                  input = siblingTd.querySelector("[id]");
					            }

          // 2. Se non trovato, cerca nella stessa colonna del tr successivo
	            if (!input && rowIndex + 1 < rows.length) {
		                const nextRow = rows[rowIndex + 1];
				            const nextTds = nextRow.querySelectorAll("td");
					                if (nextTds[columnIndex]) {
							              input = nextTds[columnIndex].querySelector("[id]");
								                  }
										            }

          if (input && input.id) {
	              const label = document.createElement("label");
		                  label.setAttribute("for", input.id);

            while (titleTd.firstChild) {
	                  label.appendChild(titleTd.firstChild);
			              }

            titleTd.appendChild(label);
	              }
		              });
			            }
				        });
					  });
</script>
					  
