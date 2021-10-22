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
<formwidget   id="url_list_aimp">
<formwidget   id="__refreshing_p"><!-- nic01 -->
<formwidget   id="changed_field"> <!-- nic01 -->
     

@link_tab;noquote@
@dett_tab;noquote@
<table width="100%" cellspacing=0 class=func-menu>
<tr>
<if @funzione@ ne I and @menu@ eq 1>
<td width="25%" nowrap class=@func_v;noquote@>
  <a href="coimnove-286-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
</td>
<td width="25%" nowrap class=@func_m;noquote@>
  <a href="coimnove-286-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
</td>
<td width="25%" nowrap class=@func_d;noquote@>
  <a href="coimnove-286-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
</td>
</if>
<else>
       <td width="25%" nowrap class=func-menu>Visualizza</td>
       <td width="25%" nowrap class=func-menu>Modifica</td>
       <td width="25%" nowrap class=func-menu>Cancella</td>
</else>
<if @funzione@ eq V>
   <td width="25%" nowrap class=func-menu>
       <a href="coimnove-286-layout?@link_gest;noquote@" class=func-menu target="Stampa allegato IX B">Stampa dichiarazione art.286 D. Lgs. 152/2006</a>
   </td>
</if>
<else>
   <td width="25%" nowrap class=func-menu>Stampa dichiarazione art.286 D. Lgs. 152/2006</td>
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

      <tr><td colspan=2>&nbsp;</td></tr>
    <tr><td align=center colspan=4>VERIFICA STRUMENTALE PERIODICA DELLE EMISSIONI PER IMPIANTI TERMICI CIVILI DI POTENZA TERMICA NOMINALE AL FOCOLARE > 35 kW ALIMENTATI A BIOMASSE, BIOGAS, LEGNA E CARBONE, O PER I QUALI NON SONO STATE REGOLARMENTE ESEGUITE LE OPERAZIONI DI MANUTENZIONE PERIODICA</td></tr>
      <tr><td align=center colspan=4>(D.Lgs 152/06 art.286 ss.mm.ii)</td></tr>

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
</table></td></tr>


  </table>

  <table width="70%" cellspacing=0 cellpadding=1 border=0>
    <tr><td colspan=2>&nbsp;</td></tr>
    <tr><td align=left colspan=2>dichiara di  </td></tr>
    <tr><td colspan=2>&nbsp;</td></tr>

    <tr><td align=left colspan=2>
        <formgroup id="verif_emis_286_no">@formgroup.widget;noquote@</formgroup>
        non aver effettuato la verifica trattandosi di impianto che rientra nei casi previsti dalla parte III sez. 1 dell'allegato IX alla parte V del D.lgs. 152/2006 e ss.mm.ii)</td></tr>
    <tr><td colspan=2>&nbsp;</td></tr>
    
    <tr><td align=left colspan=2>
        <formgroup id="verif_emis_286_si">@formgroup.widget;noquote@</formgroup>
        aver eseguito in data in data 
        <formwidget id="data_verif_emiss">
          <formerror  id="data_verif_emiss">
            <span class="errori">@formerror.data_verif_emiss;noquote@</span>
          </formerror>
          la verifica del rispetto dei valori limite di emissione prevista dal D.Lgs 152/06 art.286 ss.mm.ii., con i seguenti risultati: 
      </td>
    </tr>
<tr><td colspan=2>&nbsp;</td></tr>
    <tr>
      <td>polveri totali</td>
      <td><formwidget id="polveri_totali">
	    Mg/Nmc all'ora
        <formerror  id="polveri_totali">
        <span class="errori">@formerror.polveri_totali;noquote@</span>
        </formerror>	
      </td>
    </tr>      
    <tr>
      <td>monossido di carbonio (CO)</td>
      <td><formwidget id="monossido_carbonio">
	    Mg/Nmc all'ora  
        <formerror  id="monossido_carbonio">
        <span class="errori">@formerror.monossido_carbonio;noquote@</span>
        </formerror>	
    </td>
    </tr>      
    <tr>
      <td>ossidi di azoto (NO2)</td>
      <td><formwidget id="ossidi_azoto">
	    Mg/Nmc all'ora
        <formerror  id="ossidi_azoto">
        <span class="errori">@formerror.ossidi_azoto;noquote@</span>
        </formerror>	
      </td>
    </tr>      
    <tr>
      <td>ossidi di zolfo (SO2)</td>
      <td><formwidget id="ossidi_zolfo">
	    Mg/Nmc all'ora
        <formerror  id="ossidi_zolfo">
        <span class="errori">@formerror.ossidi_zolfo;noquote@</span>
        </formerror>	
      </td>
    </tr>      
    <tr>
      <td>carbonio organico totale (COT)</td>
      <td><formwidget id="carbonio_organico_totale">
	    Mg/Nmc all'ora  
        <formerror  id="carbonio_organico_totale">
        <span class="errori">@formerror.carbonio_organico_totale;noquote@</span>
        </formerror>	
      </td>
    </tr>      
    <tr>
      <td nowrap>composti inorganici del cloro sotto forma di gas o vapori (come HCI)</td>
      <td><formwidget id="composti_inorganici_cloro">
	    Mg/Nmc all'ora  
        <formerror  id="composti_inorganici_cloro">
        <span class="errori">@formerror.composti_inorganici_cloro;noquote@</span>
        </formerror>	
    </td>
    </tr>      

    <tr><td colspan=2>&nbsp;</td></tr>
    <tr>  
        <td align=left colspan=2>Tali risultati sono
                       <formgroup id="risultato_conforme_si">@formgroup.widget;noquote@</formgroup>
                       conformi 
                       <formgroup id="risultato_conforme_no">@formgroup.widget;noquote@</formgroup>
                       non conformi ai valori-limite previsti dalla parte III, sez. 1, 2 e 3 dell'allegato IX alla parte V del D.lgs. 152/2006 e ss.mm.ii.
        </td>
    </tr>
  
    <tr><td colspan=2>&nbsp;</td></tr>
    <tr><td colspan=2>Per il campionamento, l'analisi e la valutazione delle emissioni sono stati applicati i metodi contenuti nelle seguenti norme tecniche e nei relativi aggiornamenti:</td></tr>
    
    <tr><td><formgroup id="flag_uni_13284">@formgroup.widget;noquote@</formgroup>UNI EN 13284-1;</td></tr>
    <tr><td><formgroup id="flag_uni_14792">@formgroup.widget;noquote@</formgroup>UNI EN 14792:2017;</td></tr>
    <tr><td><formgroup id="flag_uni_15058">@formgroup.widget;noquote@</formgroup>UNI EN 15058:2017;</td></tr>
    <tr><td><formgroup id="flag_uni_10393">@formgroup.widget;noquote@</formgroup>UNI 10393;</td></tr>
    <tr><td><formgroup id="flag_uni_12619">@formgroup.widget;noquote@</formgroup>UNI EN 12619;</td></tr>
    <tr><td><formgroup id="flag_uni_1911">@formgroup.widget;noquote@</formgroup>UNI EN 1911-1,2,3.</td></tr>

    <tr><td colspan=2>&nbsp;</td></tr>
    <tr><td colspan=2>Per la determinazione delle concentrazioni di ossidi di azoto, monossido di carbonio, ossidi di zolfo e carbonio organico totale, sono stati utilizzati strumenti di misura di tipo elettrochimico. <formgroup id="flag_elettrochimico">@formgroup.widget;noquote@</formgroup> </td></tr>
    <tr><td colspan=2>&nbsp;</td></tr>
    <tr><td colspan=2>Per gli impianti a biomassa o a biogas, in quanto già esercizio alla data di entrata in vigore del D. Lsg. 152/2006, sono stati utilizzati i metodi in uso ai sensi della normativa previgente. <formgroup id="flag_normativa_previgente">@formgroup.widget;noquote@</formgroup></td></tr>

       <tr><td colspan=2>&nbsp;</td></tr>
    <tr><td align=left colspan=2>Il presente documento viene allegato al Libretto d'impianto</td></tr>

<tr><td colspan=2>&nbsp;</td></tr>
<if @funzione@ ne "V">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>
</table>
</table>
</formtemplate>
<p>
</center>

