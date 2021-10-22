<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    nic01 21/05/2014 Aggiunto flush della cache in modo da rinfrescare il menù dinamico
    nic01            dopo aver inserito, modificato o cancellato un menù.
    nic01            Aggiungo anche il link "cancella cache del menù dinamico" in modo da
    nic01            permettere di farlo manualmente se si fanno insert o update a mano:
    nic01            aggiungo la funzione "C" di "Cancella cache del menù dinamico".
-->
<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="20%" nowrap class=func-menu>
       <a href="coimmenu-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="80%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="20%" nowrap class=@func_v;noquote@>
         <a href="coimmenu-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="20%" nowrap class=@func_m;noquote@>
         <a href="coimmenu-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="20%" nowrap class=@func_d;noquote@>
         <a href="coimmenu-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
      <td width="20%" nowrap class=@func_m;noquote@><!-- nic01 -->
         <a href="coimmenu-gest?funzione=C&@link_gest;noquote@" title="Questa operazione viene fatta automaticamente tutte le volte che si inserisce, modifica o cancella un menù. Può tornare utile dopo aver modificato dei menù direttamente sul db." class=@func_d;noquote@>Cancella cache del menù dinamico</a><!-- nic01 -->
      </td><!-- nic01 -->
   </else>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="last_nome_menu">
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<b>@messaggio@</b><!--nic01-->

<tr><td valign=top align=right class=form_title>Nome men&ugrave;</td>
    <td valign=top><formwidget id="nome_menu">
        <formerror  id="nome_menu"><br>
        <span class="errori">@formerror.nome_menu;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
   <td colspan=2><table  border=1 cellspacing=0 >
                 <tr>
                    <td align=left>Descrizione</td>
                    <td align=left>selez</td>
                    <td align=left>livello</td>
                    <td align=center>ordine</td>
                 </tr>

                 <multiple name=multiple_indici>
                     <tr valign=top  class=form_title>
                         <td align=left><%= $descrizione(@multiple_indici.indice;noquote@) %></td>
                         <td align=center><formwidget id="check.@multiple_indici.indice;noquote@">
                             <formerror  id="check.@multiple_indici.indice;noquote@"><br>
                                 <span class="errori"><%= $formerror(check.@multiple_indici.indice;noquote@) %></span>
                             </formerror>
                         </td>
                         <td align=center><formwidget id="lev.@multiple_indici.indice;noquote@">
                             <formerror  id="lev.@multiple_indici.indice;noquote@"><br>
                                 <span class="errori"><%= $formerror(lev.@multiple_indici.indice;noquote@) %></span>
                             </formerror>
                         </td>
                         <td align=lleft><%= $spazzi(@multiple_indici.indice;noquote@) %>
                                          <formwidget id="seq.@multiple_indici.indice;noquote@">
                             <formerror  id="seq.@multiple_indici.indice;noquote@"><br>
                                 <span class="errori"><%= $formerror(seq.@multiple_indici.indice;noquote@) %></span>
                             </formerror>

                         </td>
                     </tr>
                 </multiple>
             </table>
     </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

