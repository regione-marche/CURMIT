<master   src="master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<!--
    USER    DATA       MODIFICHE
    ======= ========== =======================================================================
    sim01   18/03/2016 Visualizzo il saldo del portafoglio

    nic02   02/04/2014 Aggiunto link al documento delle FAQ 

    nic01   27/03/2014 Aggiunto avviso presenza di messaggi non letti
-->

<center>
<if @yui_menu_p@ true>
  <big>
  <h2>Benvenuto, @nome@ @cognome@</h2>
  <p> </p>
  <p>Per iniziare a lavorare scegli una funzione cliccando su una qualsiasi voce del menu.</p>
  <p>Se preferisci, puoi usare la normale pagina di menu <a class=main href="toggle-menu">HTML</a>.
  <p>Puoi anche cambiare la tua <a class=main href=utenti/coimcpwd-gest?funzione=M&nome_funz=@funz_pwd;noquote@>password</a> o <a class=main href="logout?nome_funz=@funz_log_out;noquote@">uscire</a> dal programma.</p>
  <p>Se preferisci, puoi usare uno stile grafico <a class=main href="toggle-contrasto">
     <if @flag_alto_contrasto@ eq "f">
         ad Alto Contrasto.
     </if>
     <else>
         Standard.
     </else>
     </a>
  </p>

  <p> </p>
  <p>Leggi le <a class=main href="doc/FAQ.pdf">F.A.Q.</a></p>
  <p> </p>

  <if @ctr_msg_non_letti@ gt 0><!-- nic01 (ho aggiunto questa if ed il suo contenuto -->
      <p><b><font color=red>Attenzione, hai @ctr_msg_non_letti@ messaggi non letti. Per consultarli, clicca <a class=main href="src/coimdmsg-list?nome_funz=dmsg">qui</a></font></b></p>
  </if>

  @riga_portafoglio;noquote@<!-- sim01 -->
  </big>
</if>

<else>
    Benvenuto, @nome@ @cognome@.

    &nbsp;

    Se preferisci, puoi usare <a class=main href="toggle-menu">l'interfaccia grafica per i menù</a>.

    &nbsp;

    Se preferisci, puoi usare uno stile grafico <a class=main href="toggle-contrasto">
    <if @flag_alto_contrasto@ eq "f">
        ad Alto Contrasto.
    </if>
    <else>
        Standard.
    </else>
    </a>

    &nbsp;

    Leggi le <a class=main href="doc/FAQ.pdf">F.A.Q.</a>

    <if @ctr_msg_non_letti@ gt 0><!-- nic01 (ho aggiunto questa if ed il suo contenuto -->
        <p><b><font color=red>Attenzione, hai @ctr_msg_non_letti@ messaggi non letti. Per consultarli, clicca <a class=main href="src/coimdmsg-list?nome_funz=dmsg">qui</a></font></b></p>
    </if>

    @riga_portafoglio;noquote@<!-- sim01 -->

    <include src="dynamic-menu">
</else>


</center>
