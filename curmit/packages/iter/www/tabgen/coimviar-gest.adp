<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

@link_tab;noquote@
@dett_tab;noquote@


<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimviar-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimviar-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimviar-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimviar-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
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
<formwidget   id="last_cod_via">
<formwidget   id="cod_area">
<formwidget   id="cod_via">
<formwidget   id="url_list_area">
<formwidget   id="url_area">
<formwidget   id="dummy">
<formwidget   id="f_cod_via">
<if @flag_ente@ eq C>
   <formwidget   id="cod_comune">
   <formwidget   id="descr_comu">
</if>
<if @flag_ente@ eq P>
   <if @funzione@ ne I>
       <formwidget   id="cod_comune">
   </if>
</if>

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<!-- TODO: Ricordare di posizionare gli eventuali link ai pgm di zoom -->

<tr>
    <if @flag_ente@ eq P>
        <if @funzione@ eq I>
           <td valign=top align=right class=form_title>Comune</td>
           <td valign=top width=190><formwidget id="cod_comune">
               <formerror id="cod_comune">
               <span class="errori">@formerror.cod_comune;noquote@</span>
               </formerror>
           </td>
        </if>

        <else>
           <td valign=top align=right class=form_title>Comune</td>
           <td valign=top width=190><formwidget id="descr_comu">
               <formerror id="descr_comu">
               <span class="errori">@formerror.descr_comu;noquote@</span>
               </formerror>
           </td>  
        </else> 
    </if>
</tr>

<tr><td valign=top align=right class=form_title>Indirizzo</td>
    <td valign=top><formwidget id="descr_topo">
        <formerror  id="descr_topo"><br>
        <span class="errori">@formerror.descr_topo;noquote@</span>
        </formerror>
        <if @funzione@ eq I>
           <formwidget id="descr_via">@cerca_viae;noquote@
        </if>
        <else>
           <formwidget id="descr_via">
        </else>
        <formerror  id="descr_via"><br>
        <span class="errori">@formerror.descr_via;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Da Civico</td>
    <td valign=top><formwidget id="civico_iniz">
        <formerror  id="civico_iniz"><br>
        <span class="errori">@formerror.civico_iniz;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>A Civico</td>
    <td valign=top><formwidget id="civico_fine">
        <formerror  id="civico_fine"><br>
        <span class="errori">@formerror.civico_fine;noquote@</span>
        </formerror>
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

