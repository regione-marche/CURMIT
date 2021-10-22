<master   src="../../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="htmlarea">t</property>

<center>
@link_inco;noquote@
@dett_tab;noquote@

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <if @flag_inco@ ne "S">
       <td width="25%" class=func-menu>
           <a href="@pack_dir;noquote@/coimstev-filter?@link_filter;noquote@" class=func-menu>Ritorna</a>
       </td>
   </if>
   <else>
       <td width="25%" class=func-menu>&nbsp;</td>
   </else>
   <td width="50%" class=func-menu align=center>Campagna: <b>@desc_camp;noquote@</b></td>
   <td width="25%" class=func-menu>&nbsp;</td>
</tr>
</table>


   <if @ctr@ eq 0>
      <p>
      <b>Nessun appuntamento in stato effettuato corrisponde ai criteri
         impostati
     <br>oppure si tratta di appuntamenti con documento di esito gi&agrave;
         stampato
     </b>
   </if> 
   <else> 
       Documenti di esito creati: <b>@ctr;noquote@</b>
      <p>
      Stampa in formato
      <a href="#" onclick="javascript:window.open('@file_pdf_url2;noquote@', 'stampa', 'scrollbars=yes, resizable=yes')"><img border=0 src=@logo_dir_url;noquote@/pdf.gif>Pdf</a>
      o
      <a href="#" onclick="javascript:window.open('@file_doc_url2;noquote@', 'stampa', 'scrollbars=yes, resizable=yes')"><img border=0 src=@logo_dir_url;noquote@/doc.gif>Doc</a>
      <p>
      @stampa3;noquote@
   </else> 

</center>



