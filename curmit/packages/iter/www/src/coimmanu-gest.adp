<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom01 05/04/2019 Sviluppo per la BAT: aggiunto botone per la gestione delle tipologie 
    rom01            tipologie d'Impianti su cui l'impresa può operare.
-->
<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width=100% cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimmanu-list?@link_list;noquote@ class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimmanu-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <if @coimtgen.flag_portale@ eq "T">
         <td width="25%" nowrap class=@func_m;noquote@>Modifica</td>
         <td width="25%" nowrap class=@func_d;noquote@>Cancella</td>
      </if>
      <else>
         <td width="25%" nowrap class=@func_m;noquote@>
            <a href="coimmanu-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
         </td>
         <td width="25%" nowrap class=@func_d;noquote@>
            <a href="coimmanu-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
         </td>
      </else>
      <tr>
      <if @flag_convenzionato@ eq S>
          <td width="25%" nowrap class=func-menu>
             <a href="coimboll-list?funzione=V&@link_bollini;noquote@&@url_manu;noquote@" class=func-menu>Bollini</a>
          </td>
      </if>
      <else>
          <td width="25%" nowrap class=func-menu>Bollini</td>
      </else>
      <td width="25%" nowrap class=func-menu>
         <a href="@link_aimp;noquote@" class=func-menu>Impianti</a>
      </td>
      <td width="25%" nowrap class=func-menu>
         <a href=coimopma-list?@link_opma;noquote@  class=func-menu>Operatori</a>
      </td>
      <td width="25%" nowrap class=func-menu>
         <a href="#" onclick="javascript:window.open('@link_docu;noquote@', 'documenti', 'scrollbars=yes, resizable=yes, width=790, height=450').moveTo(50,140)">Documenti</a>
      </td>
      </tr>
   </else>
   <if @coimtgen.flag_portale@ ne "T"><!--rom01 aggiunta if e suo contenuto-->
     <tr>
       <td width="25%" nowrap class=func-menu><a href=coimtpin-list?@link_tpin;noquote@ class=func-menu>Tipologia impianti abilitati</a></td>
     </tr>
   </if>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="last_cognome">
<formwidget   id="cod_legale_rapp">
<formwidget   id="cod_legale_rapp_old">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<if @funzione@ ne I>
    <tr><td valign=top align=right class=form_title>Codice</td>
        <td valign=top colspan=3><formwidget id="cod_manutentore">
            <formerror  id="cod_manutentore"><br>
            <span class="errori">@formerror.cod_manutentore;noquote@</span>
            </formerror>
        </td>
    </tr>
</if>

<tr><td valign=top align=right class=form_title>Ragione sociale</td>
    <td valign=top><formwidget id="cognome">
        <formerror  id="cognome"><br>
        <span class="errori">@formerror.cognome;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title></td>
    <td valign=top><formwidget id="nome">
        <formerror  id="nome"><br>
        <span class="errori">@formerror.nome;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Convenzionato</td>
    <td valign=top colspan=1><formwidget id="flag_convenzionato">
        <formerror  id="flag_convenzionato"><br>
        <span class="errori">@formerror.flag_convenzionato;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Indirizzo</td>
    <td valign=top colspan=1><formwidget id="indirizzo">
        <formerror  id="indirizzo"><br>
        <span class="errori">@formerror.indirizzo;noquote@</span>
        </formerror>
    </td>

</tr>

<tr>
    <td valign=top align=right class=form_title>Protocollo convenzione</td>
    <td valign=top colspan=1><formwidget id="prot_convenzione">
        <formerror  id="prot_convenzione"><br>
        <span class="errori">@formerror.prot_convenzione;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data protocollo convenzione</td>
    <td valign=top colspan=1><formwidget id="prot_convenzione_dt">
        <formerror  id="prot_convenzione_dt"><br>
        <span class="errori">@formerror.prot_convenzione_dt;noquote@</span>
        </formerror>
    </td>

</tr>

<tr><td valign=top align=right class=form_title>Comune</td>
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

<tr><td valign=top align=right class=form_title>Provincia</td>
    <td valign=top><formwidget id="provincia">
        <formerror  id="provincia"><br>
        <span class="errori">@formerror.provincia;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>C.A.P.</td>
    <td valign=top><formwidget id="cap">@link_cap;noquote@
        <formerror  id="cap"><br>
        <span class="errori">@formerror.cap;noquote@</span>
        </formerror>
    </td>
</tr>


<tr><td valign=top align=right class=form_title>Cod. Fiscale</td>
    <td valign=top><formwidget id="cod_fiscale">
        <formerror  id="cod_fiscale"><br>
        <span class="errori">@formerror.cod_fiscale;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>P. IVA</td>
    <td valign=top><formwidget id="cod_piva">
        <formerror  id="cod_piva"><br>
        <span class="errori">@formerror.cod_piva;noquote@</span>
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
</tr>

<tr><td valign=top align=right class=form_title>Pec</td>
    <td valign=top><formwidget id="pec">
        <formerror  id="pec"><br>
        <span class="errori">@formerror.pec;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Localit&agrave;  reg imp.</td>
    <td valign=top><formwidget id="localita_reg">
        <formerror  id="localita_reg"><br>
        <span class="errori">@formerror.localita_reg;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Reg. Imprese</td>
    <td valign=top><formwidget id="reg_imprese">
        <formerror  id="reg_imprese"><br>
        <span class="errori">@formerror.reg_imprese;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Localit&agrave; Rea</td>
    <td valign=top><formwidget id="localita_rea">
        <formerror  id="localita_rea"><br>
        <span class="errori">@formerror.localita_rea;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Rea</td>
    <td valign=top><formwidget id="rea">
        <formerror  id="rea"><br>
        <span class="errori">@formerror.rea;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Capitale sociale</td>
    <td valign=top><formwidget id="capit_sociale">
        <formerror  id="capit_sociale"><br>
        <span class="errori">@formerror.capit_sociale;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Ruolo</td>
    <td valign=top><formwidget id="flag_ruolo"
        <formerror  id="flag_ruolo"><br>
        <span class="errori">@formerror.flag_ruolo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Data inizio attività</td>
    <td valign=top><formwidget id="data_inizio">
        <formerror  id="data_inizio"><br>
        <span class="errori">@formerror.data_inizio;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data fine attività</td>
    <td valign=top><formwidget id="data_fine">
        <formerror  id="data_fine"><br>
        <span class="errori">@formerror.data_fine;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Legale rappresentante</td>
    <td valign=top><formwidget id="cognome_rapp">
        <formerror  id="cognome_rapp"><br>
        <span class="errori">@formerror.cognome_rapp;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title></td>
    <td valign=top><formwidget id="nome_rapp">@cerca_citt;noquote@
        <formerror  id="nome_rapp"><br>
        <span class="errori">@formerror.nome_rapp;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Attivo</td>
    <td valign=top ><formwidget id="flag_attivo">
        <formerror  id="flag_attivo"><br>
        <span class="errori">@formerror.flag_attivo;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Patentino</td>
    <td valign=top><formwidget id="patentino">
        <formerror  id="patentino"><br>
        <span class="errori">@formerror.patentino;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Patentino Fgas</td>
    <td valign=top><formwidget id="patentino_fgas">
        <formerror  id="patentino_fgas"><br>
        <span class="errori">@formerror.patentino_fgas;noquote@</span>
        </formerror>
    </td>
    <td></td>
    <td></td>
</tr>

<tr><td valign=top align=right class=form_title>Note</td>
    <td valign=top colspan=3><formwidget id="note">
        <formerror  id="note"><br>
        <span class="errori">@formerror.note;noquote@</span>
        </formerror>
    </td>
</tr>


<if @funzione@ ne "V">
    <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

