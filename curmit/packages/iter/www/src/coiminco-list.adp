<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<script language="Javascript">
// Set Netscape up to run the "captureMousePosition" function whenever
// the mouse is moved. For Internet Explorer and Netscape 6, you can capture
// the movement a little easier.
 if (document.layers) { // Netscape
    document.captureEvents(Event.CLICK);
    document.onclick = captureMousePosition;
    mouse = document.onclick;
} else if (document.all) { // Internet Explorer
    document.onclick = captureMousePosition;
    mouse = document.onclick;
} else if (document.getElementById) { // Netcsape 6
    document.onclick = captureMousePosition;
    mouse = document.onclick;
}

// Global variables
xMousePos = 800; // Horizontal position of the mouse on the screen
yMousePos = 200; // Vertical position of the mouse on the screen
xMousePosMax = 0; // Width of the page
yMousePosMax = 0; // Height of the page

function captureMousePosition(e) {
    if (document.layers) {
        // When the page scrolls in Netscape, the event's mouse position
        // reflects the absolute position on the screen. innerHight/Width
        // is the position from the top/left of the screen that the user is
        // looking at. pageX/YOffset is the amount that the user has
        // scrolled into the page. So the values will be in relation to
        // each other as the total offsets into the page, no matter if
        // the user has scrolled or not.
        xMousePos = e.pageX;
        yMousePos = e.pageY;
        xMousePosMax = window.innerWidth+window.pageXOffset;
        yMousePosMax = window.innerHeight+window.pageYOffset;
    } else if (document.all) {
        // When the page scrolls in IE, the event's mouse position
        // reflects the position from the top/left of the screen the
        // user is looking at. scrollLeft/Top is the amount the user
        // has scrolled into the page. clientWidth/Height is the height/
        // width of the current page the user is looking at. So, to be
        // consistent with Netscape (above), add the scroll offsets to
        // both so we end up with an absolute value on the page, no
        // matter if the user has scrolled or not.
        xMousePos = window.event.x+document.body.scrollLeft;
        yMousePos = window.event.y+document.body.scrollTop;
    } else if (document.getElementById) {
        // Netscape 6 behaves the same as Netscape 4 in this regard
        xMousePos = e.pageX;
        yMousePos = e.pageY;
        xMousePosMax = window.innerWidth+window.pageXOffset;
        yMousePosMax = window.innerHeight+window.pageYOffset;
    }
window.status = "xMousePos=" + xMousePos + ", yMousePos=" + yMousePos + ", xMousePosMax=" + xMousePosMax + ", yMousePosMax=" + yMousePosMax;
}
</script>

<if @flag_aimp@ ne "S">
<if @caller@ eq "index">
<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <if @flag_scar@ eq "A">
         <a href="coiminco-asse-filter?@link_asse;noquote@" class=func-menu>Ritorna</a>
       </if>
       <else>
         <a href="coiminco-filter?@link_filter;noquote@" class=func-menu>Ritorna</a>
       </else>
   </td>
   <td width="50%" class=func-menu>Campagna: <b>@desc_camp;noquote@</b></td>
   <td width="25%" class=func-menu>&nbsp;</td>
</tr>
</table>
</if>
</if>
<else>
    @link_tab;noquote@
    @dett_tab;noquote@
</else>

@js_function;noquote@

<!-- barra con il cerca, link di aggiungi e righe per pagina -->
@list_head;noquote@

<center>
<!-- genero la tabella -->
@table_result;noquote@

</center>

