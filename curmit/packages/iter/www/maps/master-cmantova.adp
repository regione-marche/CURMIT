<html>
<head>
<title>@title;noquote@</title>
<link rel="stylesheet" href="@css_url;noquote@/header.css" type="text/css">

<if @htmlarea@ eq "t">
    <script type="text/javascript" src="/htmlarea/htmlarea.js"></script>
    <script type="text/javascript" src="/htmlarea/lang/en.js"></script>
    <script type="text/javascript" src="/htmlarea/dialog.js"></script>

    <style type="text/css">
    @import url(htmlarea.css);
    </style>
</if>
</head>
<!-- powderblue -->
<!-- lavender -->
<!-- lightcyan -->
<!-- gainsboro -->
<!-- lightblue -->
<body text="black">
<center>
<div class=cage>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" height="60" class=doppiobordo>  
    <tr>
        <td width="11%" rowspan=2  class=bordi-r>
            <table width="100%" height="100%">
                <tr><td align=center class=sottotitoli><b>Comune di</b></td></tr>
                <tr><td align=center><img src="@logo_url;noquote@/oasi.gif" height=36></td></tr>
                <tr><td align=center class=sottotitoli><b>Demo</b></td></tr>
            </table> 
        </td>
        <td width="78%"  class=bordi>
            <table cellspacing ="0" cellpadding="1" border ="0" width="100%" height="100%">
                <tr><td class=titoli>@title;noquote@</td></tr>
            </table>
        </td>
        <td width="11%" rowspan=2  class=bordi-l>
            <table width="100%" height="100%">
                <tr><td align=center class=sottotitoli><b>Oasisoftware</b></td></tr>
                <tr><td align=center><img src="@logo_url;noquote@/oasi.gif" height=36></td></tr>

                <tr><td align=center class=sottotitoli>@link_regione;noquote@</td></tr>
            </table> 
        </td>
    </tr>
    <tr>
        <td>
        <table  cellspacing ="0" cellpadding="1" border ="0" width="100%" height="100%">
        <tr>
            <td colspan=1 class=context>@context_bar;noquote@</td>
        </tr>
        </table>
        </td>
    </tr>
    </table>
</div>
<div align=right class=cage >
    <table width="100%" height="350" border="0" cellspacing="0" cellpadding="0" class=doppiobordo>
    <tr>
        <td valign=top>
            <slave>
        </td>
    </tr>
    <tr height=10><td>&nbsp</td></tr>
    </table>
</div>
<!-- <br clear="all"> -->
<div class=cage>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" height="30" class=doppiobordo>   
    <tr>
      <td width="33%" align=left class=footer1><a href=@css_url;noquote@logout?nome_funz=@funz_log_out;noquote@>&laquo;Chiudi sessione</a></td>
      <td width="34%" class=footer1>&nbsp;</td> 
      <td width="33%" align=right class=footer1><a href=@css_url;noquote@utenti/coimcpwd-gest?funzione=M&nome_funz=@funz_pwd;noquote@>Cambia password&raquo;</a></td>

    </tr>
    </table>
    <table  width="100%" border="0" cellspacing="0" cellpadding="0" height="30"
	    class=doppiobordo>
      <tr class=footer2>
        <td align=left><a href="mailto:assistenza@oasisoftware.it"
			  class="footer_link">&laquo;
	    assistenza@oasisoftware.it </a></td>
        <td align=center><a href="http://www.oasisoftware.com"
			    class="footer_link">www.oasisoftware.com</a></td>
        <td align=right><a href="http://www.oasisoftware.it"
			   class="footer_link">Powered by Oasi Software
	    &raquo;</a></td>
      </tr>
    </table>
</div>
</center>
</body>
</html>

