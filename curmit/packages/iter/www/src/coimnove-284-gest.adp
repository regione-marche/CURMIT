<!--
    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    gac01 21/11/2018 Modificata struttura e alcuni campi per regione marche

  -->
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
<formwidget   id="cod_impianto">
<formwidget   id="cod_manutentore">
<formwidget   id="cod_cittadino">
<formwidget   id="url_list_aimp">
<formwidget   id="__refreshing_p"><!-- nic01 -->
<formwidget   id="changed_field"> <!-- nic01 -->
     

@link_tab;noquote@
@dett_tab;noquote@
<table width="100%" cellspacing=0 class=func-menu>
<tr>
<if @funzione@ ne I and @menu@ eq 1>
<td width="25%" nowrap class=@func_v;noquote@>
  <a href="coimnove-284-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
</td>
<td width="25%" nowrap class=@func_m;noquote@>
  <a href="coimnove-284-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
</td>
<td width="25%" nowrap class=@func_d;noquote@>
  <a href="coimnove-284-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
</td>
</if>
<else>
       <td width="25%" nowrap class=func-menu>Visualizza</td>
       <td width="25%" nowrap class=func-menu>Modifica</td>
       <td width="25%" nowrap class=func-menu>Cancella</td>
</else>
<if @funzione@ eq V>
   <td width="25%" nowrap class=func-menu>
       <a href="coimnove-284-layout?@link_gest;noquote@" class=func-menu target="Stampa allegato IX B">Stampa dichiarazione art.284 D. Lgs. 152/2006</a>
   </td>
</if>
<else>
   <td width="25%" nowrap class=func-menu>Stampa dichiarazione art.284 D. Lgs. 152/2006</td>
</else>
</tr>
</table>

<table width="70%" cellspacing=1 cellpadding=1 border=0>
  <tr><td colspan=2>&nbsp;</td></tr>

    <tr><td valign=top align=left class=form_title>Progressivo:</td>
        <td valign=top align=left><formwidget id="cod_noveb">
            <formerror  id="cod_noveb"><br>
            <span class="errori">@formerror.cod_noveb;noquote@</span>
            </formerror></td>
    </tr>
    <tr>
      <td valign=top align=right class=form_title nowrap>Num. protocollo</td>
      <td valign=top><formwidget id="n_prot">
          <formerror  id="n_prot"><br>
            <span class="errori">@formerror.n_prot;noquote@</span>
          </formerror>
      </td>
    </tr>
      <tr>      
	<td valign=top align=right class=form_title>Data protocollo</td>
	<td valign=top><formwidget id="dat_prot">
            <formerror  id="dat_prot"><br>
              <span class="errori">@formerror.dat_prot;noquote@</span>
            </formerror>
	</td>
      </tr>
      <tr><td align=right colspan=4><b></b></td></tr>
    <tr><td align=center colspan=4>DICHIARAZIONE PER IMPIANTI TERMICI CIVILI DI POTENZA TERMICA NOMINALE AL FOCOLARE > 35 kW</td></tr>
      <tr><td align=center colspan=4>(D.Lgs. 152/06 art. 284)</td></tr>
      <tr><td align=center colspan=4><i>Da allegare alla Dichiarazione di conformit�' per nuova installazione o modifica (art.248 c.1); e da allegare al Libretto d'impianto per gli impianti in esercizio (art.284 c.2);</i></td></tr>
    <tr><td colspan=2>&nbsp;</td></tr>
    <tr><td valign=top align=left class=form_title width=10%>Data consegna:</td>
        <td valign=top align=left><formwidget id="data_consegna">
            <formerror  id="data_consegna"><br>
            <span class="errori">@formerror.data_consegna;noquote@</span>
            </formerror>
        </td>
      <td valign=top align=right class=form_title>Luogo consegna:</td>
      <td valign=top><formwidget id="luogo_consegna">
    </tr>

</table>
<table width="70%" border=0 cellspacing=0><tr><td>
    <tr>
      <td>&nbsp;</td>
    </tr>
	  <tr>
	    <td colspan=2>Relativamente all'impianto termico adibito a: <formgroup id="riscaldamento_ambienti">@formgroup.widget;noquote@</formgroup> riscaldamento ambienti &nbsp; <formgroup id="produzione_acs">@formgroup.widget;noquote@</formgroup> produzione acqua calda sanitaria 
	    </td>
	  </tr>
	  <tr>
	    <td>Catasto impianti/codice <formwidget id="cod_impianto_est">
	        <formerror  id="cod_impianto_est"><br>
	          <span class="errori">@formerror.cod_impianto_est;noquote@</span>
	        </formerror>
	    </td>
	    <td colspan=2>sito in via <formwidget id="indirizzo_impianto"></td>
	  </tr>
	  <tr>
	    <td colspan=3>di potenza termica nominale utile complessiva pari a <formwidget id="potenza_utile">
                kW n° gruppi termici presenti <formwidget id="n_generatori_marche">
            </td>
	  </tr>
	  <tr>
	    <td colspan=4>
	      Combustibile <formwidget id="combustibile">
	    </td>
	  </tr>
          <tr>
	    <td colspan=3>&nbsp;</td>
	  </tr>
</table>
<table width="70%" border=1 cellspacing=0><tr><td>
<table width="100%" cellspacing=0 cellpadding=1 border=0>
	  <tr>
            <td colspan=3 align=left class=form_title>Il sottoscritto
	      <formwidget id="cognome_dichiarante">
		<formwidget id="nome_dichiarante">
		  <formerror  id="nome_dichiarante">
		    <br>
		    <span class="errori">@formerror.nome_dichiarante;noquote@</span>
		  </formerror>@cerca_manu;noquote@ installatore/manutentore
		  <formerror  id="cognome_dichiarante">
		  <br>
		  <span class="errori">@formerror.cognome_dichiarante;noquote@</span>
	      </formerror>

	    </td>
	  </tr>
	  
    <tr>
      <td>In qualità di: 
	<formwidget id="flag_dichiarante">
	  <formerror  id="flag_dichiarante">
	    <br>
	    <span class="errori">@formerror.flag_dichiarante;noquote@</span>
	  </formerror>
      </td>
      
    </tr>
    <tr>
      <td colspan=2>della ditta <formwidget id="cognome_manu"><formwidget id="nome_manu">
           <formerror  id="cognome_manu"><br>
            <span class="errori">@formerror.cognome_manu;noquote@</span>
            </formerror>
        </td>
      <td>P.IVA <formwidget id="piva">
	  <formerror  id="piva">
            <br>
            <span class="errori">@formerror.piva;noquote@</span>
          </formerror>
      </td>
    </tr>
    <tr>
      <td colspan=2>con sede sita in via <formwidget id="indirizzo_manu">
          <formerror  id="indirizzo_manu">
            <br>
            <span class="errori">@formerror.indirizzo_manu;noquote@</span>
          </formerror>
      </td>
      <td>Comune <formwidget id="comune_manu">
          <formerror  id="comune_manu">
            <br>
            <span class="errori">@formerror.comune_manu;noquote@</span>
          </formerror>
      </td>
    </tr>
    <tr>
      <td>Provincia <formwidget id="provincia_manu">
          <formerror  id="provincia_manu">
            <br>
            <span class="errori">@formerror.provincia_manu;noquote@</span>
          </formerror>
      </td>
    </tr>
    <tr>
      <td>Telefono <formwidget id="telefono">
          <formerror  id="telefono">
            <br>
            <span class="errori">@formerror.telefono;noquote@</span>
          </formerror>
      </td>
      <td>Fax <formwidget id="fax">
          <formerror  id="fax">
            <br>
            <span class="errori">@formerror.fax;noquote@</span>
          </formerror>
      </td>
      <td width=25%>E-mail <formwidget id="email">
          <formerror  id="email">
            <br>
            <span class="errori">@formerror.email;noquote@</span>
          </formerror>
      </td>
    </tr>
    <tr>
      <td>Iscritta alla CCIAA di <formwidget id="localita_reg">
          <formerror   id="localita_reg"><br>
            <span class="errori">@formerror.localita_reg;noquote@</span>
	  </formerror>
      </td>
      <td>al numero <formwidget id="reg_imprese">
          <formerror   id="reg_imprese"><br>
            <span class="errori">@formerror.reg_imprese;noquote@</span>
	  </formerror>
      </td>
    </tr>
	  <tr>
	    <td colspan=3>abilitata ad operare agli impianti di cui alle lettere: a)<formgroup id="flag_a">@formgroup.widget;noquote@</formgroup> c)<formgroup id="flag_c">@formgroup.widget;noquote@</formgroup> e)<formgroup id="flag_e">@formgroup.widget;noquote@</formgroup> dell'articolo 1 del D.M. 37/08,</td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	  </tr>
    <tr>
      <td colspan=3><formgroup id="flag_installatore">@formgroup.widget;noquote@</formgroup> (per gli impianti di nuova installazione) in qualità di <b>installatore</b> dell'impianto di cui sopra, dichiara che lo stesso è dotato dell'attestazione del costruttore prevista all'articolo 282, comma 2-bis del F.Lgs. 152/2006</td>
    </tr>
    <tr>
      <td colspan=3><formgroup id="flag_rispetta_val_min">@formgroup.widget;noquote@</formgroup> (solo per impianti alimentati a legna, carbone, biomasse combustibili, biogas) rispetta i valori limite di emissione prevista dall'articolo 286 del D. Lgs. 152/2006.</td>
    </tr>
    <tr>
      <td colspan=3><formgroup id="flag_manutentore">@formgroup.widget;noquote@</formgroup> (per gli impianti già in esercizio) in qualità di <b>manutentore/terzo responsabile</b> dell'impianto di cui sopra, dichiara che lo stesso è conforme alle caratteristiche tecmiche di cui all'art.285 ed è idoneo a rispettare i valori di cui all'art. 286 del D.Lgs. 152/06</td>
</tr>
<tr><td colspan=3><font color=red>@errore_3;noquote@</font></td></tr>
        <tr><td align=left colspan=3>&nbsp;</td></tr>

</table></td></tr>
  </table>

<table width="70%" cellspacing=0 cellpadding=1 border=0>
<tr><td>OPPURE (per gli impianti già in esercizio, in alternativa alla dichiarazione del manutentore/terzo responsabile)</td></tr>
<tr><td>
  <table width="100%" cellspacing=0 cellpadding=1 border=1>
<tr>
<td>
   <table width="100%" cellspacing=0>
	  <tr>
            <td colspan=3 align=left class=form_title>Il sottoscritto
	      <formwidget id="cognome">
		<formwidget id="nome">
		     @cerca_citt;noquote@ soggetto responsabile
		  <formerror  id="cognome">
		  <br>
		  <span class="errori">@formerror.cognome;noquote@</span>
	      </formerror>

	    </td>
	  </tr>
<tr><td>in qualità di <b>responsabile dell'impianto</b> di cui sopra, dichiara che lo stesso è conforme alle caratteristiche tecniche di cui all'art. 285 ed è idoneo a rispettare i valori di cui all'art. 286 del D.Lgs. 152/06.</td></tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>

  <table width="70%" cellspacing=0 cellpadding=1 border=0>
<tr><td colspan=2>&nbsp;</td></tr>
    <tr><td align=left colspan=2>Dichiara, ai sensi di quanto previsto dal D.Lgs. 152/06 art. 284 e ss.mm.ii.</td></tr>
    <tr><td colspan=2>&nbsp;</td></tr>
    <tr><td align=left colspan=2>Che l’impianto è conforme alle caratteristiche tecniche di cui all’art. 285 del D.Lgs. 152/06, come specificate nella parte II dell’allegato IX alla parte V del Decreto citato</td></tr>
<tr><td align=left colspan=2>Che l’impianto è idoneo a rispettare i valori di cui all all’art. 286 del D.Lgs. 152/06, come specificate nella parte III  dell’allegato IX alla parte V del Decreto citato.</td></tr>


    <tr><td colspan=2>&nbsp;</td></tr>
    <tr><td align=left colspan=2>Il presente documento viene allegato a:</td></tr>
    <tr><td align=left colspan=2> 
                       <formgroup id="flag_dich_conformita">@formgroup.widget;noquote@</formgroup>
		       Dichiarazione conformita' n° <formwidget id="dich_conformita_nr">
                       del
                       <formwidget id="data_dich_conform">
		       <formerror  id="dich_conformita_nr"><br>
                             <span class="errori">@formerror.dich_conformita_nr;noquote@</span>
                       </formerror>
                       
		       <formerror  id="data_dich_conform">
                             <span class="errori">@formerror.data_dich_conform;noquote@</span>
                       </formerror>   
           </td>  
    </tr>

    <tr><td align=left><formgroup id="flag_libretto_centr">@formgroup.widget;noquote@</formgroup>Libretto d'impianto (per gli impianti già in esercizio)</td>
    </tr>

    <tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>
</table>
</table>
</formtemplate>
<p>
</center>

