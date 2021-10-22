<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

@link_tab;noquote@
@dett_tab;noquote@

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <if @funzione@ ne I>
       <if @cod_impianto@ not nil>
       <td width="14.29%">
            <a href="coim_as_resp-list?funzione=V&@link_list;noquote@">Ritorna</a>
       </td>
       </if>
       <else>
       <td width="14.29%">
            <a href="coim_as_resp_admin-list?funzione=V&@link_list_admin;noquote@">Ritorna</a>
       </td>
       </else>
       <td width="14.29%" nowrap class=@func_v;noquote@>
            <a href="coim_as_resp-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
       </td>
       <if @flag_modifica@ eq T>
           <td width="14.29%" nowrap class=@func_m;noquote@>
               <a href="coim_as_resp-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
           </td>
           <td width="14.29%" nowrap class=@func_d;noquote@>
               <a href="coim_as_resp-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
           </td>
       </if>
       <else>
            <td width="14.29%" nowrap class=func-menu>Modifica</td>
            <td width="14.29%" nowrap class=func-menu>Cancella</td>
       </else>
       <td width="14.29%" nowrap class=func-menu>
           <a href="coim_as_resp-layout?@link_gest;noquote@" class=func-menu target="Stampa">Stampa</a>
       </td>
       <td width="42.84%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
       <td width="14.29%" nowrap class=func-menu>Visualizza</td>
       <td width="14.29%" nowrap class=func-menu>Modifica</td>
       <td width="14.29%" nowrap class=func-menu>Cancella</td>
       <td width="14.29%" nowrap class=func-menu>Stampa</td>
       <td width="42.84%" nowrap class=func-menu>&nbsp;</td>
   </else>
</tr>
</table>


<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="last_cod_as_resp">
<formwidget   id="cod_impianto">
<formwidget   id="f_cod_via">
<formwidget   id="cod_as_resp">
<formwidget   id="cod_responsabile">
<formwidget   id="url_list_aimp">
<formwidget   id="url_aimp">
<formwidget   id="cod_legale_rapp">
<formwidget   id="flag_tracciato">
<formwidget   id="dummy">
<formwidget	  id="flag_ammi">

<!-- Inizio della form colorata -->
<br><br>
<table width=70% border=1 cellspacing=0 cellpadding=20 align=center>
<tr><td>
	<table width=100% align=center>
		<tr><td colspan=2 align="center" class="errori">@errori;noquote@</td></tr>
		<tr>
		   <td align=right class=form_title width=15%>Il sottoscritto</td>
		   <td align=left><formwidget id="cognome_legale">
		   				<formwidget id="nome_legale">@cerca_ammi;noquote@
		       			<formerror  id="cognome_legale"><br>
					    <span class="errori">@formerror.cognome_legale;noquote@</span>
					    </formerror>
		   </td>
		</tr>
		<tr>
		   <td align=right class=form_title>In qualit&agrave; di</td>
		   <td align=left class=form_title>amministratore</td>
		</tr>
		
		<tr><td colspan=2>&nbsp</td></tr>
		<tr><td align=center colspan=2><b>Comunica</b></td></tr>
		
		<tr>
		   <td width=100% colspan=2>
			   <table width=100%>
			      <tr>
			         <td>
			         	<table width=100%>
					        <formgroup id="swc_inizio_fine">
					           <tr><td nowrap>@formgroup.widget;noquote@ @formgroup.label;noquote@</td></tr>
					        </formgroup>
			             </table>
			         </td>
			         <td>
			         	<table width=100%>
						    <tr>
								<td><formwidget id="nome_condominio_1">
				                   <formerror id="nome_condominio_1"><br>
				                   <span class="errori">@formerror.nome_condominio_1;noquote@</span>
				                   </formerror>
					            </td>
						     	<td valign=bottom>dalla data</td>
					         	<td><formwidget id="data_inizio">
				                   <formerror id="data_inizio"><br>
				                   <span class="errori">@formerror.data_inizio;noquote@</span>
				                   </formerror>
					             </td>
					         </tr>
						     <tr>
						     	<td><formwidget id="nome_condominio_2">
				                   <formerror  id="nome_condominio_2"><br>
				                   <span class="errori">@formerror.nome_condominio_2;noquote@</span>
				                   </formerror>
					            </td>
						     	<td>dalla data</td>
				                 <td><formwidget id="data_fine">
				                   <formerror id="data_fine"><br>
				                   <span class="errori">@formerror.data_fine;noquote@</span>
				                   </formerror>
				                 </td>
					         </tr>
				         </table>
			         </td>
			      </tr>
			   </table>
			</td>
		</tr>

                 <tr>
		   <td align=right class=form_title valign=top nowrap>Tipo responsabilita' </td>
		   <td align=left><formwidget id="flag_ammimp">
		       <formerror  id="flag_ammimp"><br>
		       <span class="errori">@formerror.flag_ammimp;noquote@</span>
		       </formerror>
		   </td>
		</tr>

		<tr><td colspan=2>&nbsp</td></tr>
		
                 <tr>
		   <td align=right class=form_title valign=top nowrap>Destinazione uso impianto </td>
		   <td align=left><formwidget id="cod_utgi">
		       <formerror  id="cod_utgi"><br>
		       <span class="errori">@formerror.cod_utgi;noquote@</span>
		       </formerror>
		   </td>
		</tr>
		<tr>
		   <td  align=right class=form_title valign=top nowrap>catasto impianti/codice </td>
		   <td  align=left><formwidget id="cod_impianto_est">
		       <formerror  id="cod_impianto_est"><br>
		       <span class="errori">@formerror.cod_impianto_est;noquote@</span>
		       </formerror>
		   </td>
		</tr>
		<tr>
			<td valign=top align=right class=form_title width=15%>Indirizzo</td>
		   	<td width=100%>
				<table width=100%>
					<tr>
				    	<td valign=top ><formwidget id="toponimo">
						    <formwidget id="indirizzo">@cerca_viae;noquote@
					            <formerror  id="indirizzo"><br>
					            <span class="errori">@formerror.indirizzo;noquote@</span>
					            </formerror>
					            <formerror  id="toponimo"><br>
					            <span class="errori">@formerror.toponimo;noquote@</span>
					            </formerror>
					    </td>
					    <td valign=top align=right class=form_title >N&deg; Civ.</td>
					    <td valign=top nowrap><formwidget id="numero">/<formwidget id="esponente">
					    	<formerror  id="numero"><br>
					            <span class="errori">@formerror.numero;noquote@</span>
					        </formerror>
					    </td>
					    <td valign=top align=right class=form_title>Comune</td>
					   	<if @flag_ente@ eq P>
					       <td valign=top><formwidget id="cod_comune">
					            <formerror  id="cod_comune"><br>
					            <span class="errori">@formerror.cod_comune;noquote@</span>
					            </formerror>
					       </td>
					   	</if>
					   	<else>
					       	<td valign=top><formwidget id="descr_comune"></td>
					   	</else>
				     </tr>
			   </table>
			</td>
		</tr>
		
		<!-- <tr>
		   <td valign=top align=right class=form_title>Localit&agrave;</td>
		   <td valign=top><formwidget id="localita">
		       <formerror  id="localita"><br>
		       <span class="errori">@formerror.localita;noquote@</span>
		       </formerror>
		   </td>
		</tr> -->
		<tr>
		   <td  align=right class=form_title width=20%>di propriet&agrave; di </td>
		   <td  align=left><formwidget id="cognome_resp">
		                  <formwidget id="nome_resp">@cerca_prop;noquote@|@link_ins_prop;noquote@
		       <formerror  id="cognome_resp"><br>
		       <span class="errori">@formerror.cognome_resp;noquote@</span>
		       </formerror>
		   </td>
		</tr>
		<tr><td colspan=2>&nbsp;</td></tr>
		<tr>
		   <td  align=left class=form_title colspan=2> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; composto dai seguenti generatori di calore:</td>
		</tr>
		
		<tr><td align=left colspan=2><table width="100%">
		
		    <formwidget id="conta_max">
		
		    <multiple name=multiple_form>
		    <tr>
		        <td valign=top align=right> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<formwidget id="gen_prog.@multiple_form.conta;noquote@"></td>
		        <td valign=top align=left> &nbsp; &nbsp; potenza termica del focolare nominale di <formwidget id="potenza_gend.@multiple_form.conta;noquote@">kW
		            <formerror  id="potenza_gend.@multiple_form.conta;noquote@"><br>
		            <span class="errori"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<%= $formerror(potenza_gend.@multiple_form.conta;noquote@) %></span>
		            </formerror>
		        </td>
		        <td valign=top>Combustibile <formwidget id="cod_combustibile.@multiple_form.conta;noquote@">
		            <formerror  id="cod_combustibile.@multiple_form.conta;noquote@"><br>
		            <span class="errori"><%= $formerror(cod_combustibile.@multiple_form.conta;noquote@) %></span>
		            </formerror>
		        </td>
		    </tr>
		    </multiple>
		</table></td></tr>
		
		<tr><td colspan=2><small> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;@link_aggiungi_gen;noquote@</small></td></tr>
		<tr><td colspan=2>&nbsp;</td></tr>
		<tr>
			<td align=right class=form_title>Nominativo del fornitore di energia</td>
			<td><formwidget id="fornitore_energia">
               	<formerror id="fornitore_energia"><br>
               		<span class="errori">@formerror.fornitore_energia;noquote@</span>
               	</formerror>
        	</td>
		</tr>
		
		<tr><td colspan=2 align=center>&nbsp;</td></tr>
		<if @funzione@ ne "V">
		    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
		</if>
		
		<!-- Fine della form colorata -->
	</table>
</td></tr>
</table>

</formtemplate>

