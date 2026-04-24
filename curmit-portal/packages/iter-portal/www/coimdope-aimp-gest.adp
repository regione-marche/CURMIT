<!--
    USER  DATA       MODIFICHE
    ===== ========== ============================================================================================
    mat01 03/09/2025 Modifiche fatte per l'accessibilità.(ho usato mauve++ per vedere gli errori)
    mat01            Sostituiti i tag b con tag strong.Sostituito il tag center con un div.
    mat01            Aggiunti 2 script in fondo.

    innes 22/05/2018 Innesto da iter-dev a iter-portal-dev. Tutte le query verranno eseguite
    innes            passando il dbn che riceviamo dalla pagina di filtro. Abbiamo gestito il
    innes            dbn anche per le proc iter_get_coimtgen.

-->

<!-- <master   src="../master"> -->
<master> <!-- innes -->
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>
<!--mat01 <center>--> <!-- innes -->
<div align="center"><!--mat01-->
<script type="text/javascript">
  function onSearchClose() {
      document.@form_name@.__refreshing_p.value = '1';
      document.@form_name@.submit();
  }
</script>
<!-- innes il cittadino non deve vedere i bottoni in alto -->

<formtemplate id="@form_name;noquote@">
<formwidget   id="cod_impianto">
<formwidget   id="flag_tipo_impianto">
<formwidget   id="cod_dope_aimp">

<formwidget   id="last_cod_dimp">

<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">

<formwidget   id="url_aimp">
<formwidget   id="url_list_aimp">

<formwidget   id="f_cod_via">
<formwidget   id="cod_manutentore">
<formwidget   id="cod_responsabile">
<formwidget   id="cod_legale_rapp">
<formwidget   id="cognome_legale">
<formwidget   id="nome_legale">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>
        <tr>
          <td colspan=10 align="center" class="errori">@errori;noquote@</td>
        </tr>
        <tr>
          <td align=right class=form_title width=20%>Cognome dichiarante</td>
          <td align=left colspan=9>
            <formwidget id="cognome_dichiarante">
            <formerror  id="cognome_dichiarante">
              <br>
              <span class="errori">@formerror.cognome_dichiarante;noquote@</span>
            </formerror>
          </td>
        </tr>
        <tr>
          <td align=right class=form_title>Nome dichiarante</td>
          <td align=left colspan=9>
            <formwidget id="nome_dichiarante">
            <formerror  id="nome_dichiarante">
              <br>
              <span class="errori">@formerror.nome_dichiarante;noquote@</span>
            </formerror>
          </td>
        </tr>
        <tr>
          <td align=right class=form_title>Data dichiarazione</td>
          <td align=left colspan=9>
            <formwidget id="data_dich">
            <formerror  id="data_dich">
              <br>
              <span class="errori">@formerror.data_dich;noquote@</span>
            </formerror>
          </td>
        </tr>
        <tr>
          <td align=right class=form_title>In qualita' di</td>
          <td align=left colspan=9>
            <formwidget id="flag_dichiarante">
            <formerror  id="flag_dichiarante">
              <br>
              <span class="errori">@formerror.flag_dichiarante;noquote@</span>
            </formerror>
          </td>
        </tr>

        <tr>
          <td align=right nowrap class=form_title>della Ditta</td>
          <td align=left colspan=9>
            <formwidget id="cognome_manu"><formwidget id="nome_manu">@cerca_manu;noquote@
            <formerror  id="cognome_manu"><br>
              <span class="errori">@formerror.cognome_manu;noquote@</span>
            </formerror>
          </td>
        </tr>

        <tr>
	  <td align=right class=form_title width=21% nowrap>iscritta alla CCIAA di</td>
          <td><formwidget id="localita_reg">
             <formerror   id="localita_reg"><br>
               <span class="errori">@formerror.localita_reg;noquote@</span>
             </formerror>
          </td>
          <td align=right nowrap>al numero</td>
          <td colspan=7><formwidget id="reg_imprese">
             <formerror   id="reg_imprese"><br>
               <span class="errori">@formerror.reg_imprese;noquote@</span>
             </formerror>
          </td>
        </tr>

	<tr>
          <td align=right>abilitata ad operare per gli impianti di cui alle lettere:</td>
          <td colspan=9>
            <table width=100%>
              <tr>
                <td>a)<formgroup id="flag_a">@formgroup.widget;noquote@</formgroup></td>
                <td>b)<formgroup id="flag_b">@formgroup.widget;noquote@</formgroup></td>
                <td>c)<formgroup id="flag_c">@formgroup.widget;noquote@</formgroup></td>
                <td>d)<formgroup id="flag_d">@formgroup.widget;noquote@</formgroup></td>
                <td>e)<formgroup id="flag_e">@formgroup.widget;noquote@</formgroup></td>
                <td>f)<formgroup id="flag_f">@formgroup.widget;noquote@</formgroup></td>
                <td>g)<formgroup id="flag_g">@formgroup.widget;noquote@</formgroup></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td align=right nowrap class=form_title>in qualità di</td>
          <td align=left colspan=9>
            <formwidget id="flag_tipo_tecnico">
            <formerror  id="flag_tipo_tecnico">
              <br>
              <span class="errori">@formerror.flag_tipo_tecnico;noquote@</span>
            </formerror>
          </td>
        </tr>

        <tr>
          <td align=right class=form_title valign=top>Dell'impianto adibito a</td>
          <td align=left colspan=9><formwidget id="cod_utgi">
            <formerror  id="cod_utgi"><br>
              <span class="errori">@formerror.cod_utgi;noquote@</span>
            </formerror>
          </td>
        </tr>

        <tr>
          <td align=right class=form_title valign=top>Catasto impianti/codice </td>
          <td align=left colspan=9><formwidget id="cod_impianto_est">
            <formerror  id="cod_impianto_est"><br>
              <span class="errori">@formerror.cod_impianto_est;noquote@</span>
            </formerror>
          </td>
        </tr>

        <tr>
          <td valign=top align=right class=form_title width=21%>Indirizzo</td>
          <td valign=top width=28%><formwidget id="toponimo">
            <formwidget id="indirizzo">
            <formerror  id="indirizzo"><br>
              <span class="errori">@formerror.indirizzo;noquote@</span>
            </formerror>
            <formerror  id="toponimo"><br>
              <span class="errori">@formerror.toponimo;noquote@</span>
            </formerror>
          </td>
          <td valign=top align=right class=form_title width=7%>N&deg; Civ.</td>
          <td valign=top width=6% nowrap>
            <formwidget id="numero">/<formwidget id="esponente">
            <formerror  id="numero"><br>
              <span class="errori">@formerror.numero;noquote@</span>
            </formerror>
          </td>
          <td valign=top align=right class=form_title width=4%>Scala</td>
          <td valign=top width=3%><formwidget id="scala">
            <formerror  id="scala"><br>
              <span class="errori">@formerror.scala;noquote@</span>
            </formerror>
          </td>
          <td valign=top align=right class=form_title width=4%>Piano</td>
          <td valign=top width=3%><formwidget id="piano">
            <formerror  id="piano"><br>
              <span class="errori">@formerror.piano;noquote@</span>
            </formerror>
          </td>
          <td valign=top align=right class=form_title width=3%>Int.</td>
          <td valign=top><formwidget id="interno">
            <formerror  id="interno"><br>
              <span class="errori">@formerror.interno;noquote@</span>
            </formerror>
          </td>
        </tr>
        <tr>
          <td valign=top align=right class=form_title>Comune</td>
          <if @flag_ente@ eq P>
            <td valign=top colspan=9><formwidget id="cod_comune">
              <formerror  id="cod_comune"><br>
                <span class="errori">@formerror.cod_comune;noquote@</span>
              </formerror>
            </td>
          </if>
          <else>
            <td valign=top colspan=9><formwidget id="descr_comune"></td>
          </else>
        </tr>

      <if @flag_tipo_impianto@ eq "R">
        <tr>
          <td valign=top align=right class=form_title>Di potenza termica nominale utile</td>
          <td colspan=9>
            <formwidget id="pot_nom_risc">kW
            <formerror  id="pot_nom_risc"><br>
              <span class="errori">@formerror.pot_nom_risc;noquote@</span>
            </formerror>
          </td>
        </tr>
      </if>
      <else>
        <tr>
          <td valign=top align=right class=form_title>Della potenza frigorifera nominale</td>
          <td colspan=9>
            <formwidget id="pot_nom_raff">kW
            <formerror  id="pot_nom_raff"><br>
              <span class="errori">@formerror.pot_nom_raff;noquote@</span>
            </formerror>
          </td>
        </tr>
        <tr>
          <td valign=top align=right class=form_title>Della potenza termica nominale</td>
          <td colspan=9>
             <formwidget id="pot_nom_risc">kW
             <formerror  id="pot_nom_risc"><br>
               <span class="errori">@formerror.pot_nom_risc;noquote@</span>
             </formerror>
          </td>
        </tr>
      </else>

      <tr>
        <td valign=top align=right class=form_title>N&deg; generatori</td>
        <td colspan=9>
          <formwidget id="num_generatori">
          <formerror  id="num_generatori"><br>
            <span class="errori">@formerror.num_generatori;noquote@</span>
          </formerror>
        </td>
      </tr>

      <if @flag_tipo_impianto@ eq "R">
      <tr>
        <td valign=top align=right class=form_title>Combustibile</td>
        <td colspan=9>
          <formwidget id="cod_combustibile">
          <formerror  id="cod_combustibile"><br>
            <span class="errori">@formerror.cod_combustibile;noquote@</span>
          </formerror>
        </td>
      </tr>
      </if>

      <tr>
        <td valign=top align=right class=form_title>Nominativo fornitore di energia</td>
        <td colspan=9>
          <formwidget id="fornitore_energia">
          <formerror  id="fornitore_energia"><br>
            <span class="errori">@formerror.fornitore_energia;noquote@</span>
          </formerror>
        </td>
      </tr>      

      <tr>
        <td align=right class=form_title>Responsabile dell'impianto </td>
        <td align=left colspan=9>
          <formwidget id="cognome_resp">
          <formwidget id="nome_resp">@cerca_prop;noquote@<!-- innes| @link_ins_prop;noquote@ -->
          <formerror  id="cognome_resp"><br>
            <span class="errori">@formerror.cognome_resp;noquote@</span>
          </formerror>
        </td>
      </tr>

      <tr>
        <td align=right class=form_title>In qualit&agrave; di</td>
        <td align=left>
          <formwidget id="flag_resp">
          <formerror  id="flag_resp"><br>
            <span class="errori">@formerror.flag_resp;noquote@</span>
          </formerror>
        </td>
      </tr>

      <tr>
        <td colspan=2>&nbsp;</td>
      </tr>

      <tr><td colspan=10 align=center><strong>Visti</strong></td></tr>

      <tr>
        <td align=right colspan=2 class="form_title">La documentazione tecnica rilasciata dal progettista dell'impianto</td>
        <td align=left colspan=8>
          <formwidget id="flag_doc_tecnica">
          <formerror  id="flag_doc_tecnica"><br>
            <span class="errori">@formerror.flag_doc_tecnica;noquote@</span>
          </formerror>
        </td>
      </tr>

      <tr>
        <td align=right colspan=2 class=form_title>Le istr. tecniche per l'uso e la manut. rese disponibili dall'impresa installatrice</td>
        <td align=left colspan=8>
          <formwidget id="flag_istr_tecniche">
          <formerror  id="flag_istr_tecniche"><br>
            <span class="errori">@formerror.flag_istr_tecniche;noquote@</span>
          </formerror>
        </td>
      </tr>

      <tr>
        <td align=right colspan=2 class=form_title>I manuali tecnici di uso e manut. elaborati dal costruttore degli apparecchi</td>
        <td align=left colspan=8>
          <formwidget id="flag_man_tecnici">
          <formerror  id="flag_man_tecnici"><br>
            <span class="errori">@formerror.flag_man_tecnici;noquote@</span>
          </formerror>
        </td>
      </tr>

      <tr>
        <td align=right colspan=2 class=form_title>I regolamenti locali</td>
        <td align=left colspan=8>
          <formwidget id="flag_reg_locali">
          <formerror  id="flag_reg_locali"><br>
            <span class="errori">@formerror.flag_reg_locali;noquote@</span>
          </formerror>
        </td>
      </tr>

      <tr>
        <td align=right colspan=2 class=form_title>Le norme UNI e CEI applicabili per lo specifico elemento o tipo di apparecchio</td>
        <td align=left colspan=8>
          <formwidget id="flag_norme_uni_cei">
          <formerror  id="flag_norme_uni_cei"><br>
            <span class="errori">@formerror.flag_norme_uni_cei;noquote@</span>
          </formerror>
        </td>
      </tr>

      <tr>
        <td align=right colspan=2 class=form_title>Altro</td>
        <td align=left colspan=8>
          <formwidget id="altri_doc">
          <formerror  id="altri_doc"><br>
            <span class="errori">@formerror.altri_doc;noquote@</span>
          </formerror>
        </td>
      </tr>

      <tr><td>&nbsp;</td></tr>
      <tr><td>&nbsp;</td></tr>

</table>
      
<table width="100%" align="center">
      <tr><td colspan=6 align=center><strong>Operazioni</strong></td></tr>

      <multiple name="campi_operazioni">
        <tr><td align=center>&nbsp;</td></tr>

        <tr>
          <td align="right" class="form_title" nowrap><strong>Gruppo termico:</strong></td>
          <td align="left"  class="form_title">@campi_operazioni.gen_prog@</td>

          <td align="right" class="form_title"><strong>Data Installazione:</strong></td>
          <td align="left"  class="form_title">@campi_operazioni.data_installaz@</td>

          <td align="right" class="form_title"><strong>Pot. term. nom. utile:</strong></td>
          <td align="left"  class="form_title">@campi_operazioni.pot_utile_nom@ kW</td>
        </tr>

        <tr>
          <td align="right" class="form_title"><strong>Fabbricante:</strong></td>
          <td align="left"  class="form_title">@campi_operazioni.fabbricante@</td>

          <td align="right" class="form_title"><strong>Modello:</strong></td>
          <td align="left"  class="form_title">@campi_operazioni.modello@</td>

          <td align="right" class="form_title"><strong>Matricola:</strong></td>
          <td align="left"  class="form_title">@campi_operazioni.matricola@</td>
        </tr>

        <group column="gen_prog">
            <tr>
                <td align="right" class="form_title">Operazione</td>
                <td align="left" colspan=3>
                    <formwidget id="@campi_operazioni.campo_operazione@">
                    <span class="errori"><br>
                        <formerror id="@campi_operazioni.campo_operazione@"></formerror>
                    </span>
                </td>
                <td align="right" class="form_title">Frequenza</td>
                <td align="left">
                    <formwidget id="@campi_operazioni.campo_frequenza@">
                    <span class="errori"><br>
                        <formerror id="@campi_operazioni.campo_frequenza@"></formerror>
                    </span>
                </td>
            </tr>
        </group>
      </multiple>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=6 align=center><formwidget id="submit_btn"></td></tr>
</if>
<else><!--mat01 aggiunto else e contenuto-->
                <tr style="display:none;"><td colspan=1 align=center><formwidget id="submit_btn"></td></tr>

</else>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

<!-- Fine della form colorata -->
</formtemplate>
<!--mat01 <p>
</center> -->
</div><!--mat01-->

<script>
  // mat01 aggiunto script
    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll("form input, form textarea, form select").forEach(function (el) {
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