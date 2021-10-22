<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    gac01 13/07/2018 Aggiunto bottone in alto " Torna a Scheda 3: Nomina Terzo Responsabile"
    gac01            solo per la Regione Marche.

    rom01 12/07/2018 Aggiunto bottone in alto "Passa a Scheda 11: RCEE e moduli regionali"
    rom01            solo per la Regione Marche.

-->
<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

@js_function;noquote@
@link_tab;noquote@
@dett_tab;noquote@


<if @coimtgen.regione@ eq "MARCHE"><!--rom01 aggiunta if e suo contenuto-->
  <table width="50%">
    <tr>
      <td width="25%" class=func-menu>
        <a href="coim_as_resp-list?@link_scheda3;noquote@&nome_funz=asresp&nome_funz_caller=impianti">Torna a Scheda 3: Nomina Terzo Responsabile</a><!--gac01-->
      </td>
      <td width="25%" class=func-menu>
        <a href="coimaimp-warning?@link_scheda11;noquote@&caller=dimp&nome_funz_caller=impianti">Passa a Scheda 11: RCEE e moduli regionali</a>
      </td>
    </tr>
  </table>
</if><!--rom01-->    

<!-- barra con il cerca, link di aggiungi e righe per pagina -->
@list_head;noquote@

<center>
<!-- genero la tabella -->
@table_result;noquote@
</center>

