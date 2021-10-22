<html>
<head>
<title>@title;noquote@</title>

    <link rel="stylesheet" href="@css_url;noquote@/header.css" type="text/css">
    <link rel="stylesheet" href="/resources/acs-templating/forms-2.css" type="text/css" media="all">
    <link rel="stylesheet" href="/resources/acs-templating/forms.css" type="text/css" media="all">
    <link rel="stylesheet" href="/resources/acs-templating/lists.css" type="text/css" media="all">
    <link rel="stylesheet" href="/resources/tosap/header.css" type="text/css" media="all">
    <link rel="stylesheet" href="/resources/acs-subsite/site-master.css" type="text/css" media="all">
    <link rel="stylesheet" href="/resources/acs-subsite/default-master.css" type="text/css" media="all">

   <script type="text/javascript" src="/resources/acs-subsite/core.js"></script>

<if @htmlarea@ eq "t">
    <script type="text/javascript" src="/htmlarea/htmlarea.js"></script>
    <script type="text/javascript" src="/htmlarea/lang/en.js"></script>
    <script type="text/javascript" src="/htmlarea/dialog.js"></script>

    <style type="text/css">
    @import url(htmlarea.css);
    </style>
</if>

        <!-- Standard reset, fonts and grids -->
        <link rel="stylesheet" type="text/css" href="/resources/iter/yui/reset-fonts-grids/reset-fonts-grids.css">

        <!-- CSS for Menu -->
        <link rel="stylesheet" type="text/css" href="/resources/iter/yui/menu/assets/skins/sam/menu.css">
 
 
        <!-- Page-specific styles -->
        <style type="text/css">
            div.yui-b p {
                margin: 0 0 .5em 0;
                color: #999;
            }
            div.yui-b p strong {
                font-weight: bold;
                color: #000;
            }
            div.yui-b p em {
                color: #000;
            }            
            h1 {
                font-weight: bold;
                font-size: 120%;
                margin: 0 0 1em 0;
                padding: .25em .5em;
            }
            #productsandservices {
                margin: 0 0 10px 0;
            }
        </style>

        <!-- Dependency source files -->
        <script type="text/javascript" src="/resources/iter/yui/yahoo-dom-event/yahoo-dom-event.js"></script>
        <script type="text/javascript" src="/resources/iter/yui/animation/animation.js"></script>
        <script type="text/javascript" src="/resources/iter/yui/container/container_core.js"></script>

        <!-- Menu source file -->
        <script type="text/javascript" src="/resources/iter/yui/menu/menu.js"></script>

        <!-- Page-specific script -->
        <script type="text/javascript" src="/resources/iter/iter.js"></script>

    <!-- end menu stuff -->   


</head>
<!-- powderblue -->
<!-- lavender -->
<!-- lightcyan -->
<!-- gainsboro -->
<!-- lightblue -->
<body text="black" class="yui-skin-sam" id="yahoo-com">
<center>
<div class=cage>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" height="20" class=doppiobordo>  
    <tr>
        <td width="11%" rowspan=3  class=bordi-r>
            <table width="70%" height="100%">
                <tr><td align=center class=sottotitoli><b>Catasto impianti</b></td></tr>
                <tr><td align=center><img src="@logo_url;noquote@/oasi.gif" height=20></td></tr>
                <tr><td align=center class=sottotitoli><b>Ente _______</b></td></tr>
            </table> 
        </td>
        <td width="78%"  class=bordi>
            <table cellspacing ="0" cellpadding="1" border ="0" width="100%" height="100%">
                <tr><td class=titoli>@title;noquote@</td></tr>
            </table>
        </td>
        <td width="11%" rowspan=3  class=bordi-l>
            <table width="100%" height="100%">
                <tr><td align=center class=sottotitoli><b>Gestito</b></td></tr>
                <tr><td align=center><img src="@logo_url;noquote@/oasi.gif" height=20></td></tr>

                <tr><td align=center class=sottotitoli>@link_regione;noquote@</td></tr>
            </table> 
        </td>
    </tr>
    <tr>
        <td>
        <table  cellspacing ="0" cellpadding="1" border ="0" width="100%" height="100%">
        <tr>
          <td width="100%" align="center">
            <include src="/packages/iter/www/dynamic-menu">
          </td>
        </tr>
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
    <table width="100%" border="0" cellspacing="0" cellpadding="0" height="15" class=doppiobordo>   
    <tr>
      <td width="33%" align=left class=footer1><a href=@css_url;noquote@logout?nome_funz=@funz_log_out;noquote@>&laquo;Chiudi sessione</a></td>
      <td width="34%" class=footer1>&nbsp;</td> 
      <td width="33%" align=right class=footer1><a href=@css_url;noquote@utenti/coimcpwd-gest?funzione=M&nome_funz=@funz_pwd;noquote@>Cambia password&raquo;</a></td>

    </tr>
    </table>
    <table  width="100%" border="0" cellspacing="0" cellpadding="0" height="15"
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

