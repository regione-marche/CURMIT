<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="17%" nowrap class=func-menu>
   <!-- l'inserimento torna alla funzione di pre-inserimento -->
   <if @funzione@ ne "I">
       <a href="coimrelg-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </if>
   <else>
       <a href="coimrelg-gest?funzione=P&@link_gest;noquote@" class=func-menu>Ritorna</a>
   </else>
   </td>
   <if @funzione@ eq "P"
    or @funzione@ eq "I">
      <td width="83%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="16.6%" nowrap class=@func_v;noquote@>
         <a href="coimrelg-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="16.6%" nowrap class=@func_m;noquote@>
         <a href="coimrelg-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="16.6%" nowrap class=func-menu>
         <a href="coimrelt-list?@link_gest;noquote@" class=func-menu>Mod. scheda tecnica</a>
      </td>
      <td width="16.6%" nowrap class=@func_d;noquote@>
         <a href="coimrelg-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
      <td width="16.6%" nowrap class=func-menu>
         <a href="coimrelg-layout?@link_gest;noquote@" target=stampa class=func-menu>Stampa</a>
      </td>
   </else>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="cod_relg">
<formwidget   id="last_data_rel">
<formwidget   id="last_ente_istat">
<formwidget   id="rel_cod_comune">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right nowrap class=form_title>Data inizio relazione</td>
    <td valign=top colspan=2><formwidget id="data_rel">
        <formerror  id="data_rel"><br>
        <span class="errori">@formerror.data_rel;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right colspan=2 nowrap class=form_title>Codice istat dell'ente</td>
    <td valign=top><formwidget id="ente_istat">
        <formerror  id="ente_istat"><br>
        <span class="errori">@formerror.ente_istat;noquote@</span>
        </formerror>
    </td>
</tr>

<!-- faccio vedere questi campi ad eccetto della funzione di P (pre-insert) -->
<if @funzione@ ne "P">

<!-- ad eccezione della vis. permetto di digitare il nome dei file -->
<if @funzione@ ne "V">
<tr><td valign=top align=right class=form_title>Nome file scheda generale</td>
    <td valign=top colspan=3><formwidget id="nome_file_gen">
        <formerror  id="nome_file_gen"><br>
        <span class="errori">@formerror.nome_file_gen;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right nowrap class=form_title>scheda tecnica</td>
    <td valign=top colspan=3><formwidget id="nome_file_tec">
        <formerror  id="nome_file_tec"><br>
        <span class="errori">@formerror.nome_file_tec;noquote@</span>
        </formerror>
    </td>
</tr>
</if>
<else>
<!-- solo in visualizzazione permetto di scaricare i file -->
<tr><td valign=top align=right class=form_title>Scarica file scheda generale</td>
    <td valign=top colspan=3 class=form_title><a href="coimrelg-scar?nome_funz=@nome_funz;noquote@&cod_relg=@cod_relg;noquote@" target="@nome_file_gen;noquote@">@nome_file_gen;noquote@</a>
    </td>

    <td valign=top align=right nowrap class=form_title>scheda tecnica</td>
    <td valign=top colspan=3 class=form_title><a href="coimrelt-scar?nome_funz=@nome_funz;noquote@&cod_relg=@cod_relg;noquote@" target="@nome_file_tec;noquote@">@nome_file_tec;noquote@</a>
    </td>
</tr>
</else>
<!-- fine if funzione diversa dalla visualizzazione -->

<tr><td colspan=8>&nbsp;</td></tr>
<tr><td valign=top align=center colspan=8 class=func-menu>
        <big><b>GENERALITA'</b></big>
    </td>
</tr>

<tr>
    <td valign=top align=right nowrap class=form_title>Responsabile del procedimento</td>
    <td valign=top colspan=7><formwidget id="resp_proc">
        <formerror  id="resp_proc"><br>
        <span class="errori">@formerror.resp_proc;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>N. Impianti stimati</td>
    <td valign=top><formwidget id="nimp_tot_stim_ente">
        <formerror  id="nimp_tot_stim_ente"><br>
        <span class="errori">@formerror.nimp_tot_stim_ente;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=left class=form_title>Autonomi</td>
    <td valign=top><formwidget id="nimp_tot_aut_ente">
        <formerror  id="nimp_tot_aut_ente"><br>
        <span class="errori">@formerror.nimp_tot_aut_ente;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Centralizzati</td>
    <td valign=top><formwidget id="nimp_tot_centr_ente">
        <formerror  id="nimp_tot_centr_ente"><br>
        <span class="errori">@formerror.nimp_tot_centr_ente;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Teleriscaldamento</td>
    <td valign=top><formwidget id="nimp_tot_telerisc_ente">
        <formerror  id="nimp_tot_telerisc_ente"><br>
        <span class="errori">@formerror.nimp_tot_telerisc_ente;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=8>&nbsp;</td></tr>
<tr><td valign=top align=center colspan=8 class=func-menu>
        <big><b>CONVENZIONE CON ASSOCIAZIONI DI CATEGORIA</b></big>
    </td>
</tr>
<tr><td valign=top align=right nowrap class=form_title>Data sottoscrizione (in vigore)</td>
    <td valign=top><formwidget id="conv_ass_categ">
        <formerror  id="conv_ass_categ"><br>
        <span class="errori">@formerror.conv_ass_categ;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=left colspan=3 class=form_title>E' Conforme alla D.G.R. 7/7568 del 21 dicembre 2001?</td>
    <td valign=top colspan=3><formwidget id="conf_dgr7_7568">
        <formerror  id="conf_dgr7_7568"><br>
        <span class="errori">@formerror.conf_dgr7_7568;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title title="inteso come numero di societ&agrave; individuali">Numero delle P. Iva aderenti alla convenzione</td>
    <td valign=top><formwidget id="npiva_ader_conv">
        <formerror  id="npiva_ader_conv"><br>
        <span class="errori">@formerror.npiva_ader_conv;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=left colspan=3 class=form_title title="inteso come numero di societ&agrave; individuali">Numero delle P. Iva iscritte alle associazioni di categoria firmatarie dell'Accordo Regionale</td>
    <td valign=top colspan=3><formwidget id="npiva_ass_acc_reg">
        <formerror  id="npiva_ass_acc_reg"><br>
        <span class="errori">@formerror.npiva_ass_acc_reg;noquote@</span>
        </formerror>
    </td>
</tr>


<tr><td colspan=8>&nbsp;</td></tr>
<tr><td valign=top align=center colspan=8 class=func-menu>
        <big><b>AUTODICHIARAZIONE</b></big>
        <b>(RIFERITA A IMPIANTI TERMICI < 35KW)</b
    </td>
</tr>
<tr><td valign=top align=right class=form_title>E' stata deliberata e attuata?</td>
    <td valign=top><formwidget id="delib_autodic">
        <formerror  id="delib_autodic"><br>
        <span class="errori">@formerror.delib_autodic;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=left colspan=6 class=form_title>
        Sono stati posti termini per la presentazione?
        (se diversi da quanto indicato nella D.G.R. 7/7568 del 21 dicembre 2001 indicare i termini e l'efficacia)
    </td>
</tr>

<tr><td valign=top align=right colspan=2 class=form_title>Periodo di riferimento:</td>
    <td valign=top align=left nowrap class=form_title>data inizio</td>
    <td valign=top><formwidget id="rifer_datai">
        <formerror  id="rifer_datai"><br>
        <span class="errori">@formerror.rifer_datai;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>data fine</td>
    <td valign=top colspan=3><formwidget id="rifer_dataf">
        <formerror  id="rifer_dataf"><br>
        <span class="errori">@formerror.rifer_dataf;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right colspan=2 class=form_title>Periodo di validit&agrave;:</td>
    <td valign=top align=left class=form_title>data inizio</td>
    <td valign=top><formwidget id="valid_datai">
        <formerror  id="valid_datai"><br>
        <span class="errori">@formerror.valid_datai;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>data fine</td>
    <td valign=top colspan=3><formwidget id="valid_dataf">
        <formerror  id="valid_dataf"><br>
        <span class="errori">@formerror.valid_dataf;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>N. autodichiarazioni</td>
    <td valign=top><formwidget id="ntot_autodic_perv">
        <formerror  id="ntot_autodic_perv"><br>
        <span class="errori">@formerror.ntot_autodic_perv;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=left colspan=3 class=form_title>N. autodichiarazioni con prescrizioni</td>
    <td valign=top colspan=3><formwidget id="ntot_prescrizioni">
        <formerror  id="ntot_prescrizioni"><br>
        <span class="errori">@formerror.ntot_prescrizioni;noquote@</span>
        </formerror>
    </td>
</tr>


<tr><td colspan=8>&nbsp;</td></tr>
<tr><td valign=top align=center colspan=8 class=func-menu>
        <big><b>GLI ISPETTORI</b></big>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>A chi sono affidati i controlli?</td>
    <td valign=top align=right colspan=2 class=form_title>N. ispettori interni</td>
    <td valign=top><formwidget id="n_ver_interni">
        <formerror  id="n_ver_interni"><br>
        <span class="errori">@formerror.n_ver_interni;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>esterni</td>
    <td valign=top colspan=3><formwidget id="n_ver_esterni">
        <formerror  id="n_ver_esterni"><br>
        <span class="errori">@formerror.n_ver_esterni;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Chi ha accertato l'idoneit&agrave; tecnica degli ispettori?</td>
    <td valign=top align=right colspan=2 class=form_title>N. accertamenti Enea</td>
    <td valign=top><formwidget id="n_accert_enea">
        <formerror  id="n_accert_enea"><br>
        <span class="errori">@formerror.n_accert_enea;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>altri soggetti</td>
    <td valign=top colspan=3><formwidget id="n_accert_altri">
        <formerror  id="n_accert_altri"><br>
        <span class="errori">@formerror.n_accert_altri;noquote@</span>
        </formerror>
    </td>
</tr>
<!-- solo in visualizzazione faccio apparire alcuni totali della scheda tec.-->
<if @funzione@ eq "V">
<tr><td colspan=8>&nbsp;</td></tr>
<tr><td valign=top align=center colspan=8 class=func-menu>
        <big><b>LE VERIFICHE</b></big>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>N. impianti verificati</td>
    <td valign=top><formwidget id="nimp_verificati">
        <formerror  id="nimp_verificati"><br>
        <span class="errori">@formerror.nimp_verificati;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=left colspan=3 class=form_title>N. impianti verificati non conformi</td>
    <td valign=top colspan=3><formwidget id="nimp_verificati_nc">
        <formerror  id="nimp_verificati_nc"><br>
        <span class="errori">@formerror.nimp_verificati_nc;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>N. generatori verificati</td>
    <td valign=top><formwidget id="ngen_verificati">
        <formerror  id="ngen_verificati"><br>
        <span class="errori">@formerror.ngen_verificati;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=left colspan=3 class=form_title>N. generatori verificati non conformi</td>
    <td valign=top colspan=3><formwidget id="ngen_verificati_nc">
        <formerror  id="ngen_verificati_nc"><br>
        <span class="errori">@formerror.ngen_verificati_nc;noquote@</span>
        </formerror>
    </td>
</tr>
</if>
<!-- fine if funzione e' uguale a V -->
</if>
<!-- fine if funzione e' diversa da P -->

<tr><td colspan=8>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=8 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

