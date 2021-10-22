<html>
<head>
<link rel="stylesheet" href="/iter//header.css" type="text/css">
<script language="Javascript">
// Temporary variables to hold mouse x-y pos.s
var tempX = 0
var tempY = 0

// Main function to retrieve mouse x-y pos.s

function getMouseX(e) {
// Detect if the browser is IE or not.
// If it is not IE, we assume that the browser is NS.
var IE = document.all?true:false

// If NS -- that is, !IE -- then set up for mouse capture
if (!IE) document.captureEvents(Event.MOUSECLICK)

  if (IE) { // grab the x-y pos.s if browser is IE
    tempX = event.clientX + document.body.scrollLeft
  } else {  // grab the x-y pos.s if browser is NS
    tempX = e.pageX
  }  
  // catch possible negative values in NS4
  if (tempX < 0){tempX = 0}
  // show the position values in the form named Show
  // in the text fields named MouseX and MouseY

  return tempX
}

function getMouseY(e) {
// Detect if the browser is IE or not.
// If it is not IE, we assume that the browser is NS.
var IE = document.all?true:false

// If NS -- that is, !IE -- then set up for mouse capture
if (!IE) document.captureEvents(Event.MOUSEMOVE)

  if (IE) { // grab the x-y pos.s if browser is IE
    tempY = event.clientY + document.body.scrollTop
  } else {  // grab the x-y pos.s if browser is NS
    tempY = e.pageY
  }  
  // catch possible negative values in NS4
  if (tempY < 0){tempY = 0}  
  // show the position values in the form named Show
  // in the text fields named MouseX and MouseY

  return tempX
}

//-->
</script>
</head>
<body bgcolor="#E8E8E8" onUnload="window.opener.location.reload(); window.close()">
<formtemplate id="@form_name;noquote@">
<formwidget id="cod_inco">

<table border="1" cellpadding="0" cellspacing="0" width="100%">
<tr>
   <td align="center" widht="50%">Data verifica:<br> 
        <formwidget id="data_verifica">
   </td>
   <td align="center" width="50%">Ora verifica:<br>
        <formwidget id="ora_verifica">
   </td>
</tr>
<tr>
   <td align="center">
        <formerror  id="data_verifica"><br>
        <span class="errori">@formerror.data_verifica;noquote@</span>
        </formerror>
   </td>
   <td align="center">
        <formerror  id="ora_verifica"><br>
        <span class="errori">@formerror.ora_verifica;noquote@</span>
        </formerror>
   </td>
</tr>
<tr><td colspan="2" align=center><formwidget id="submit"></td></tr>
</table>

</formtemplate>
</body>
</html>

