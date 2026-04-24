<master>
<property name="title">@page_title@</property>
<property name="context">@context;noquote@</property>

<br>
<big><big>

</big></big>

<h1>@page_title@</h1>
<br>
Per far funzionare correttamente il servizio è importante che il Manutentore abbia inserito correttamente nel Catasto il Codice Fiscale e Ti abbia comunicato @dicitura_per_adp@.<br>
<br>
<br>
<%=
if {[string match "*salerno*" $db_name]} {
 set msg_attenzione "<b><big><font color=#FF0000>ATTENZIONE !! </font>In alcuni casi gli RCEE relativi ad annualità  pregresse sono in fase di aggiornamento e saranno visibili in un secondo momento. </big></b><br>
<br>"
} else {
  set msg_attenzione ""
}
%>
@msg_attenzione;noquote@
<formtemplate id="addedit" style="standard"></formtemplate>
