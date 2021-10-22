<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
-->

<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>


<if @flag_mod@ ne t>
    <if @flag_java@ ne t>
        <table width=100% cellspacing=0 class=func-menu>
        <tr>
           <td width="25%" nowrap class=func-menu>
               <a href=coimcondu-list?@link_list;noquote@ class=func-menu>Ritorna</a>
           </td>

           <if @funzione@ eq "I">
               <td width="75%" nowrap class=func-menu>&nbsp;</td>
           </if>
           <else>
               <td width="25%" nowrap class=@func_v;noquote@>
                 <a href="coimcondu-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
               </td>
               <td width="25%" nowrap class=@func_m;noquote@>
                 <a href="coimcondu-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
               </td>
               <td width="25%" nowrap class=@func_d;noquote@>
                 <a href="coimcondu-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
               </td>
               </tr>
           </else>
        </tr>
        </table>
    </if>
</if>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="url_condu">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="last_concat_key">
<formwidget   id="dummy">
<formwidget   id="flag_mod">
<formwidget   id="cod_conduttore">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title>Cognome</td>
    <td valign=top><formwidget id="cognome">
        <formerror  id="cognome"><br>
        <span class="errori">@formerror.cognome;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Nome</td>
    <td valign=top><formwidget id="nome">
        <formerror  id="nome"><br>
        <span class="errori">@formerror.nome;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
   <td valign=top align=right class=form_title>Cod.Fisc.</td>
   <td valign=top><formwidget id="cod_fiscale">
       <formerror  id="cod_fiscale"><br>
       <span class="errori">@formerror.cod_fiscale;noquote@</span>
       </formerror>
   </td>
</tr>	  

<tr>
   <td valign=top align=right class=form_title>Data Patentino</td>
   <td valign=top><formwidget id="data_patentino">
       <formerror  id="data_patentino"><br>
       <span class="errori">@formerror.data_patentino;noquote@</span>
       </formerror>
   </td>
</tr>
<tr><td valign=top align=right class=form_title>Ente che ha rilasciato il patentino</td>
   <td valign=top nowrap><formwidget id="ente_rilascio_patentino">
       <formerror  id="ente_rilascio_patentino"><br>
       <span class="errori">@formerror.ente_rilascio_patentino;noquote@</span>
       </formerror>
   </td>
</tr>

<tr><td valign=top align=right class=form_title>Indirizzo</td>
    <td valign=top><formwidget id="indirizzo">
        <formerror  id="indirizzo"><br>
        <span class="errori">@formerror.indirizzo;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=left class=form_title>Comune</td>
    <td valign=top><formwidget id="comune">@link_comune;noquote@
        <formerror  id="comune"><br>
        <span class="errori">@formerror.comune;noquote@</span>
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

<if @funzione@ ne "V">
      <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>



<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

