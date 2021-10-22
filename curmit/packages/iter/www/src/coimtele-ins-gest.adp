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
<formwidget   id="extra_par">
<formwidget   id="cod_provincia">
<if @coimtgen.flag_ente@ eq "C">
   <formwidget   id="cod_comune">
</if>
<formwidget   id="cod_impianto">
<formwidget   id="last_cod_impianto">
<formwidget   id="cod_citt_terzi">
<formwidget   id="cod_citt_inte">
<formwidget   id="cod_citt_prop">
<formwidget   id="cod_citt_occ">
<formwidget   id="cod_citt_amm">
<formwidget   id="cod_manu_manu">
<formwidget   id="cod_manu_inst">
<formwidget   id="cod_impianto_est_new">
<formwidget   id="f_resp_cogn"> 
<formwidget   id="f_resp_nome"> 
<formwidget   id="f_comune">
<formwidget   id="f_cod_via">
<formwidget   id="f_desc_via">
<formwidget   id="f_desc_topo">
<formwidget   id="flag_ins_occu">
<formwidget   id="flag_ins_prop">
<formwidget   id="flag_ins_terzi">
<formwidget   id="cod_manut">

<!-- Inizio della form colorata -->
   <table border="0" width="96%" align="center">
      <tr>
         <td class="func-menu"><b>Allegato E3 - Scheda identificativa per sottostazioni di teleriscaldamento</b></td>
      </tr>
   </table>

   <table width="100%" border="0" allign="center" cellpadding="0" cellspacing="2">
      <tr><td colspan=6>&nbsp;</td></tr>
      <tr><td colspan=6> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>1.1 UBICAZIONE E DESTINAZIONE DELL'EDIFICIO</b></td></tr>
      <tr><td colspan=6>&nbsp;</td></tr>
      <tr>
         <td valign="top" align="right" nowrap class="form_title">n. catasto impianto</td>
         <td valign="top">
            <formwidget id="cod_impianto_est">
            <formerror  id="cod_impianto_est">
               <br>
               <span class="errori">@formerror.cod_impianto_est;noquote@</span>
            </formerror>
         </td>
	 <td valign="top" align="right" class="form_title" nowrap>Volumetria riscaldata (m<sup><small>3</small></sup>)</td>
	 <td valign="top">
	    <formwidget id="volimetria_risc"> 
	    <formerror id="volimetria_risc">
	      <br>
	      <span class="errori">@formerror.volimetria_risc;noquote@</span>
            </formerror>
         </td>
         <td colspan=2>&nbsp;</td>
      </tr>

      <tr>
         <td valign="top" align="right" class="form_title">Localit&agrave;</td>
         <td colspan="5">
         
            <table border="0" width="100%" cellpadding="0" cellspacing="0">
	       <tr>
		  <td valign="top" width="185">
		     <formwidget id="localita">
		     <formerror  id="localita">
		        <br>
			<span class="errori">@formerror.localita;noquote@</span>
                     </formerror>
                  </td>
		  <if @coimtgen.flag_ente@ eq "P">
		  <td valign="top" align="right" class="form_title" width="14%">Comune&nbsp;</td>
		  <td valign="top" width="214">
		     <formwidget id="cod_comune">
		     <formerror id="cod_comune">
		        <span class="errori">@formerror.cod_comune;noquote@</span>
		     </formerror>
                  </td>
                  </if>

		  <if @coimtgen.flag_ente@ eq "C">
		  <td valign="top" align="right" class="form_title" width="14%">Comune&nbsp</td>
		  <td valign="top" width="214">
		     <formwidget id="descr_comu">
		     <formerror id="descr_comu">
		        <span class="errori">@formerror.descr_comu;noquote@</span>
		     </formerror>
                  </td>
                  </if>

		  <td valign="top" width="32">(<formwidget id="provincia">)</td>
		  <td valign="top" align="right" class="form_title" width="35">CAP&nbsp;</td>
		  <td valign="top">
		     <formwidget id="cap">
		     <formerror  id="cap">
			<br>
			<span class="errori">@formerror.cap;noquote@</span>
		     </formerror>
		     <a target="cap" href="http://www.poste.it/online/cercacap/">Ricerca CAP</a>
                  </td>
               </tr>
	    </table>
	 </td>
      </tr>

      <tr>
         <td valign="top" align="right" class="form_title">Indirizzo</td>     
         <td valign="top" colspan="5">
        
	   <table border="0" cellpadding="0" cellaspacing="0">
              <tr>
	         <td valign="top" width="350">
	            <formwidget id="descr_topo">
                    <formerror  id="descr_topo">
	               <br>
                       <span class="errori">@formerror.descr_topo;noquote@</span>
                    </formerror>
                    <formwidget id="descr_via">@cerca_viae;noquote@
                    <formerror  id="descr_via">
	               <br>
                       <span class="errori">@formerror.descr_via;noquote@</span>
                    </formerror>
                 </td>
                 <td valign="top" align="right" class="form_title" width="18">N&deg;</td>
                 <td valign="top" width="115">
		    <formwidget id="numero">/<formwidget id="esponente">
                    <formerror  id="numero">
		       <br>
		       <span class="errori">@formerror.numero;noquote@</span>
                    </formerror>
                 </td>
		 <td valign="top" align="right" class="form_title" width="25">Scala</td>
		 <td valign="top" width="60"><formwidget id="scala"></td>
		 <td valign="top" align="right" class="form_title" width="25">Piano</td>
		 <td valign="top" width="45"><formwidget id="piano"></td>
		 <td valign="top" align="right" class="form_title" width="25">Int.</td>    
		 <td valign="top" width="40"><formwidget id="interno"></td>
	      </tr>
           </table>
         
	 </td>
      </tr>

      <tr>
         <td valign="top" align="right" class="form_title" nowrap>Categoria di edificio</td>
	 <td valign="top" colspan="5">
	    <formwidget id="cod_cted"> 
            <formerror id="cod_cted">
	        <br>
		<span class="errori">@formerror.cod_cted;noquote@</span>
            </formerror>
	 </td>
      </tr>

      <tr><td colspan="6">&nbsp;</td></tr>
      <tr><td colspan="3" width="10%"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>1.2 IMPIANTO TERMICO DESTINATO A</b></td>
	  <td valign="top" align=left colspan=3>
	     <formwidget id="cod_utgi">
	     <formerror  id="cod_utgi">
	        <br>
	        <span class="errori">@formerror.cod_utgi;noquote@</span>
             </formerror>
          </td>
      </tr>
    <tr><td valign="top" align="right" class="form_title">Note</td>
    	<td valign="top" colspan="5"><formwidget id="note_dest">
    	<formerror  id="note_dest"><br><span class="errori">@formerror.note_dest;noquote@</span></formerror>
        </td>
	</tr>

  </table>
  <table width=100%>
      <tr>
	 <td valign="top" align="left" class="form_title" width="39%" nowrap> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>1.3 DATA DI INSTALLAZIONE/RISTRUTTURAZIONE</b></td>
	 <td valign="top" align="left" colspan=5>
	    <formwidget id="data_installaz"> 
            <formerror id="data_installaz"><br>
		<span class="errori">@formerror.data_installaz;noquote@</span>
            </formerror>
         </td>
      </tr>

   </table>

  <table width=100%>
      <tr><td  width="23%"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>1.4 CIRCUITO PRIMARIO</b></td>
	  <td valign="top" align=left colspan=3>
	     <formwidget id="circuito_primario">
	     <formerror  id="circuito_primario">
	        <br>
	        <span class="errori">@formerror.circuito_primario;noquote@</span>
             </formerror>
          </td>
      </tr>

      <tr><td  width="23%" nowrap> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>1.5 DISTRIBUZIONE DEL CALORE</b></td>
	  <td valign="top" align=left colspan=3>
	     <formwidget id="distr_calore">
	     <formerror  id="distr_calore">
	        <br>
	        <span class="errori">@formerror.distr_calore;noquote@</span>
             </formerror>
          </td>
      </tr>

      <tr><td  width="23%" nowrap> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>1.6 RETE DI TELERISCALDAMENTO</b></td>
	  <td valign="top" align=left colspan=3>
	     <formwidget id="cod_distributore">
	     <formerror  id="cod_distributore">
	        <br>
	        <span class="errori">@formerror.cod_distributore;noquote@</span>
             </formerror>
          </td>
      </tr>

      <tr><td  width="23%" nowrap> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Numero di scambiatori di calore</td>
	  <td valign="center" align=left>
	     <formwidget id="n_scambiatori">
	     <formerror  id="n_scambiatori">
	        <br>
	        <span class="errori">@formerror.n_scambiatori;noquote@</span>
             </formerror>
          </td>
          <td width="10%" nowrap>Potenza complessiva</td>
	  <td valign="center" align=left>
	     <formwidget id="potenza_scamb_tot">
	     <formerror  id="potenza_scamb_tot">
	        <br>
	        <span class="errori">@formerror.potenza_scamb_tot;noquote@</span>
             </formerror>
          </td>
      </tr>
  </table>
  <tr><td align=left colspan=2><table width="100%">

    <formwidget id="conta_max">

    <multiple name=multiple_form>
    <tr>
        <td valign=top align=right width="20%"> scambiatore n.<formwidget id="scamb_prog.@multiple_form.conta;noquote@"></td>
        <td valign=top align=left> &nbsp; &nbsp; potenza <formwidget id="potenza_scamb.@multiple_form.conta;noquote@">kW
            <formerror  id="potenza_scamb.@multiple_form.conta;noquote@"><br>
            <span class="errori"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<%= $formerror(potenza_scamb.@multiple_form.conta;noquote@) %></span>
            </formerror>
        </td>
    </tr>
    </multiple>
</table></td></tr>
<tr><td colspan=2> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;@link_aggiungi_gen;noquote@</td></tr>
<tr><td colspan=2>&nbsp;</td></tr>

   <table border="0" width="100%" align="center" cellpadding="0" cellspacing="2">
      <tr>
	 <td valign="top" align="right" class="form_title"><b>Resp.</b></td>
	 <td valign="top" colspan="5">
	    <formwidget id="flag_responsabile"> 
	    <formerror id="flag_responsabile">
	       <br>
	       	<span class="errori">@formerror.flag_responsabile;noquote@</span>
            </formerror>
         </td>
      </tr>
 
      <tr>
	 <td>&nbsp;</td>
	 <td valign="bottom" width="12%"><b>Cognome</b></td>
	 <td valign="bottom"><b>Nome</b></td>
	 <td>&nbsp;</td>
	 <td valign="bottom" width="135"><b>Cognome</b></td>
	 <td valign="bottom"><b>Nome</b></td>
      </tr>

      <tr>
	 <td valign="top" align="right" class="form_title"><b>Propr.</b></td>
	 <td valign="top" nowrap colspan="2" width="40%">
	    <formwidget id="cognome_prop"><formwidget id="nome_prop">@cerca_prop;noquote@|@link_ins_prop;noquote@
	    <formerror id="cognome_prop">
	       <br>
	       <span class="errori">@formerror.cognome_prop;noquote@</span>
            </formerror>
         </td>
         <td valign="top" align="right" class="form_title"><b>Intestat.</b></td>
	 <td valign="top" nowrap colspan="2">
	    <formwidget id="cognome_inte"><formwidget id="nome_inte">@cerca_inte;noquote@
	    <formerror id="cognome_inte">
	       <br>
	       <span class="errori">@formerror.cognome_inte;noquote@</span>
            </formerror>
         </td>
      </tr>
 
      <tr>
	 <td valign="top" align="right" class="form_title"><b>Occup.</b></td>
         <td valign="top" nowrap colspan="2" width="40%">
	     <formwidget id="cognome_occ"><formwidget id="nome_occ">@cerca_occ;noquote@|@link_ins_occu;noquote@
	     <formerror  id="cognome_occ">
	        <br>
                <span class="errori">@formerror.cognome_occ;noquote@</span>
             </formerror>
         </td>
	 <td valign="top" align="right" class="form_title"><b>Ammin.</b></td>
	 <td valign="top" nowrap colspan="2">
	    <formwidget id="cognome_amm"><formwidget id="nome_amm">@cerca_amm;noquote@
	    <formerror  id="cognome_amm">
	       <br>
	       <span class="errori">@formerror.cognome_amm;noquote@</span>
            </formerror>
         </td>
      </tr>
            
      <tr>
	 <td valign="top" align="right" class="form_title"><b>Terzi</b></td>
	 <td valign="top" nowrap colspan="2" width="40%">
	    <formwidget id="cognome_terzi"><formwidget id="nome_terzi">@cerca_terzi;noquote@
	    <formerror  id="cognome_terzi">
	       <br>
	       <span class="errori">@formerror.cognome_terzi;noquote@</span>
            </formerror>
         </td>
	 <td valign="top" align="right" class="form_title"><b>Progett.</b></td>
	 <td valign="top" nowrap colspan="2">
	     <formwidget id="cognome_prog"><formwidget id="nome_prog">@cerca_prog;noquote@
	     <formerror  id="cognome_prog">
	        <br>
		<span class="errori">@formerror.cognome_prog;noquote@</span>
	     </formerror>
         </td>
      </tr>

      <tr>
	 <td valign="top" align="right" class="form_title"><b>Manut.</b></td>
	 <td valign="top" nowrap colspan="2" width="40%">
	    <formwidget id="cognome_manu"><formwidget id="nome_manu">@cerca_manu;noquote@
	    <formerror  id="cognome_manu">
	       <br>
	       <span class="errori">@formerror.cognome_manu;noquote@</span>
            </formerror>
	 </td>
	 <td valign="top" align="right" class="form_title"><b>Install.</b></td>
	 <td valign="top" nowrap colspan="2">
	     <formwidget id="cognome_inst"><valign="top"><formwidget id="nome_inst">@cerca_inst;noquote@
	     <formerror  id="cognome_inst">
		<br>
		<span class="errori">@formerror.cognome_inst;noquote@</span>
             </formerror>
	 </td>
      </tr>
   </table>

    <table border="0" width="100%" align="center">
       <tr>
          <td align="center">
	     <formwidget id="submit">
	  </td>
       </tr>
    </table>
</formtemplate>
<p>


