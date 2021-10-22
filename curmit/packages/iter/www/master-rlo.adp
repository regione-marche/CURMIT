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
<body text="black" >
<center>
<div class=cage>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" height="60" class=doppiobordo>  
    <tr>
        <td width="11%" rowspan=2  class=bordi-l>
            <img width=110 src="@logo_url;noquote@/logo_lombardia.jpg">
        </td>
        <td width="78%"  class=bordi>
            <table cellspacing ="0" cellpadding="1" border ="0" width="100%" height="100%">
                <tr><td class=titoli>@title;noquote@</td></tr>
            </table>
        </td>
        <td width="11%" rowspan=2  class=bordi-l>
            <table width="100%" height="100%">
                <tr><td align=center class=sottotitoli><b>CURIT</b></td></tr>
                <tr><td align=center><img src="@logo_url;noquote@/Cestec.gif" height=36></td></tr>

                <tr><td align=center class=sottotitoli>&nbsp;</td></tr>
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
        <td align=left><a href="mailto:infocurit@cestec.it"
			  class="footer_link">&laquo;
	    infocurit@cestec.it </a></td>
        <td align=center><a href="http://areaoperativa.curit.it"
			    class="footer_link">areaoperativa.curit.it</a></td>
        <td align=right><a href="http://www.vestasoft.com"
			   class="footer_link">Powered by Vestasoft
	    &raquo;</a></td>
      </tr>
    </table>
</div>
</center>
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-15936467-39");
pageTracker._setDomainName("none");
pageTracker._setAllowLinker(true);
pageTracker._setAllowHash("false");
pageTracker._link();
pageTracker._linkByPost();
pageTracker._initData();
pageTracker._trackPageview();
} catch(err) {}</script>

<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-15936467-39");
pageTracker._setDomainName("none");
pageTracker._setAllowLinker(true);
pageTracker._setAllowHash("false");
pageTracker._link();
pageTracker._linkByPost();
pageTracker._initData();
pageTracker._trackPageview();
} catch(err) {}</script>
</body>
</html>

