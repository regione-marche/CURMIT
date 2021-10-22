<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom05 15/04/2019 Aggiunta frase sull'obbligatorieta' del Cod.Fisc. in fondo alla pagina 
    rom05            per la Regione Marche

    rom04 07/03/2019 Modificate alcune diciture su richiesta di Regione Marche

    gac01 19/02/2018 Gestiti nuovi campi patentino e patentino_fgas

    rom03 01/02/2019 Su richiesta di Sandro metto il link "Impianti" non cliccabile se sono
    rom03            loggato come manutentore.

    rom02 18/11/2018 Se il caller è impianto allora l'unica azione possibile è il visualizza.

    rom01 11/10/2018 Messo il campo cod_piva.

    gab01 13/02/2017 Gestisco il nuovo campo pec della coimcitt.

    nic01 13/10/2014 Per Ucit, la Paravan vuole che questo programma non possa essere usato
    nic01            per modificare i soggetti dell'impianto se richiamato dal link dei dati
    nic01            di testata dell'impianto dagli utenti con id_ruolo manutentore o
    nic01            verificatore.
-->

<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<if @flag_ins_manu@ ne S>
<if @flag_mod@ ne t>
    <if @flag_java@ ne t>
        <table width=100% cellspacing=0 class=func-menu>
        <tr>

         <if @caller@ eq "impianto">
           <td width="25%" nowrap class=func-menu>
              <a href=coimaimp-gest?cod_impianto=@cod_impianto;noquote@&nome_funz=impianti&funzione=V class=func-menu>Ritorna</a>
           </td>
        </if>
        <else>
           <td width="25%" nowrap class=func-menu>
               <a href=coimcitt-list?@link_list;noquote@ class=func-menu>Ritorna</a>
           </td>
        </else>

           <if @funzione@ eq "I">
               <td width="75%" nowrap class=func-menu>&nbsp;</td>
           </if>
           <else>
               <td width="25%" nowrap class=@func_v;noquote@>
                 <a href="coimcitt-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
               </td>
               <if @prime_2@ eq "AM" or @caller@ eq "impianto">
               <td width="25%" nowrap class=@func_m;noquote@>Modifica</td>
               <td width="25%" nowrap class=@func_d;noquote@>Cancella</td>
               </if>
               <else>
               <td width="25%" nowrap class=@func_m;noquote@>
                 <a href="coimcitt-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
               </td>
               <td width="25%" nowrap class=@func_d;noquote@>
                 <a href="coimcitt-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
               </td>
               </else>
               </tr>
               <tr>
		 <if @link_impianti@ eq "f"><!--rom03 aggiunta if e suo contenuto, aggiunta else ma non contenuto-->
		   <td width="25%" nowrap class=func-menu>Impianti</td>
		 </if> <else>
		   <td width="25%" nowrap class=func-menu>
                     <a href="@link_aimp;noquote@" class=func-menu>Impianti</a>
		   </td>
		     </else><!--rom03-->
              <td width="25%" nowrap class=func-menu>
                 <a href="/iter/maps/positions?cod_cittadino=@cod_cittadino;noquote@" class=func-menu>Mappa</a>
              </td>
           </else>
        </tr>
        </table>
    </if>
</if>
</if>
<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="url_citt">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="last_concat_key">
<formwidget   id="dummy">
<!--rom01<formwidget   id="cod_piva">-->
<formwidget   id="flag_mod">
<formwidget   id="flag_ins_manu">
<formwidget   id="cod_cittadino">
<formwidget   id="cod_stato">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title>Cognome o Ragione Sociale<font color=red>*</font></td><!--rom04 rinominato campo-->
    <td valign=top><formwidget id="cognome">
        <formerror  id="cognome"><br>
        <span class="errori">@formerror.cognome;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Nome<font color=red>*</font></td>
    <td valign=top><formwidget id="nome">
        <formerror  id="nome"><br>
        <span class="errori">@formerror.nome;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Indirizzo<font color=red>*</font></td>
    <td valign=top colspan=3><formwidget id="indirizzo">
        <formerror  id="indirizzo"><br>
        <span class="errori">@formerror.indirizzo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Comune<font color=red>*</font></td>
    <td valign=top nowrap><formwidget id="comune">@link_comune;noquote@
        <formerror  id="comune"><br>
        <span class="errori">@formerror.comune;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Localit&agrave;</td>
    <td valign=top><formwidget id="localita">
        <formerror  id="localita"><br>
        <span class="errori">@formerror.localita;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Provincia<font color=red>*</font></td>
    <td valign=top><formwidget id="provincia">
        <formerror  id="provincia"><br>
        <span class="errori">@formerror.provincia;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>C.A.P.<font color=red>*</font></td>
    <td valign=top><formwidget id="cap">@link_cap;noquote@
        <formerror  id="cap"><br>
        <span class="errori">@formerror.cap;noquote@</span>
        </formerror>
    </td>
   <td valign=top align=right class=form_title>P.IVA</td><!--rom01-->
   <td valign=top><formwidget id="cod_piva">
       <formerror  id="cod_piva"><br>
       <span class="errori">@formerror.cod_piva;noquote@</span>
       </formerror>
   </td>
</tr>

<tr>
   <td valign=top align=right class=form_title>Natura giuridica<font color=red>*</font></td>
   <td valign=top><formwidget id="natura_giuridica">
       <formerror  id="natura_giuridica"><br>
       <span class="errori">@formerror.natura_giuridica;noquote@</span>
       </formerror>
   </td>
     <td valign=top align=right class=form_title>Sesso</td>
   <td valign=top><formwidget id="sesso">
       <formerror  id="sesso"><br>
       <span class="errori">@formerror.sesso;noquote@</span>
       </formerror>
   </td>
   <td valign=top align=right class=form_title>Cod.Fisc.</td>
   <td valign=top><formwidget id="cod_fiscale">
       <formerror  id="cod_fiscale"><br>
       <span class="errori">@formerror.cod_fiscale;noquote@</span>
       </formerror>
   </td>
  </tr>

<tr><td valign=top align=right class=form_title>Telefono</td>
    <td valign=top><formwidget id="telefono">
        <formerror  id="telefono"><br>
        <span class="errori">@formerror.telefono;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Cellulare</td>
    <td valign=top><formwidget id="cellulare">
        <formerror  id="cellulare"><br>
        <span class="errori">@formerror.cellulare;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>E-mail</td>
    <td valign=top><formwidget id="email">
        <formerror  id="email"><br>
        <span class="errori">@formerror.email;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Fax</td>
    <td valign=top><formwidget id="fax">
        <formerror  id="fax"><br>
        <span class="errori">@formerror.fax;noquote@</span>
        </formerror>
    </td>
    <!-- gab01 -->
    <td valign=top align=right class=form_title>Pec</td>
    <td valign=top><formwidget id="pec">
        <formerror  id="pec"><br>
        <span class="errori">@formerror.pec;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Comune di nascita</td>
    <td valign=top><formwidget id="comune_nas">@link_comune_nas;noquote@
        <formerror  id="comune_nas"><br>
        <span class="errori">@formerror.comune_nas;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data</td>
    <td valign=top><formwidget id="data_nas">
        <formerror  id="data_nas"><br>
        <span class="errori">@formerror.data_nas;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Stato rilascio Codice Fiscale</td>
    <td valign=top><formwidget id="denominazione">@link_stato_nas;noquote@
        <formerror  id="stato_nas"><br>
        <span class="errori">@formerror.denominazione;noquote@</span>
        </formerror>
    </td>
    <td colspan=2> &nbsp;</td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Stato Soggetto</td>
    <td valign=top colspan=3><formwidget id="stato_citt">
        <formerror  id="stato_citt"><br>
        <span class="errori">@formerror.stato_citt;noquote@</span>
        </formerror>
    </td>
</tr>

<if @coimtgen.regione@ eq "MARCHE" and @flg_visualizza_patentino@  eq "t">
<tr><td valign=top align=right class=form_title>Patentino</td>
    <td valign=top><formwidget id="patentino">
        <formerror  id="patentino"><br>
        <span class="errori">@formerror.patentino;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Patentino Fgas</td>
    <td valign=top><formwidget id="patentino_fgas">
        <formerror  id="patentino_fgas"><br>
        <span class="errori">@formerror.patentino_fgas;noquote@</span>
        </formerror>
    </td>
</tr>
</if>

<tr>
    <td valign=top align=right class=form_title>Note</td>
    <td valign=top colspan=3><formwidget id="note">
        <formerror  id="note"><br>
        <span class="errori">@formerror.note;noquote@</span>
        </formerror>
    </td>
</tr>

<if @coimtgen.regione@ eq "MARCHE">
<tr><td valign=top colspan=5 align=right class=form_title>Se il soggetto &egrave; un responsabile ricordarsi di compilare il <b>Codice Fiscale</b> e almeno uno dei  seguenti campi:
    <b>Telefono, Cellulare, Fax, Email, Pec</b></td>
</tr>
</if>
<if @funzione@ ne "V">
   <if @sw_esponi_tasto_submit@ eq "t">
      <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
   </if>
</if>



<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

