<!-- Generated by ::xowiki::ADP_Generator on Wed Oct 13 04:00:17 CEST 2021 -->
<!-- The following DIV is needed for overlib to function! -->
  <div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>	
<div class='xowiki-content'>

@top_includelets;noquote@
 <if @page_context@ not nil><h1>@title@ (@page_context@)</h1></if>
 <else><h1>@title@</h1></else>
 <if @folderhtml@ not nil> 
 <div class='folders' style=''>@folderhtml;noquote@</div> 
 <div class='content-with-folders'>@content;noquote@</div> 
 </if>
    <else>@content;noquote@</else>

</div> <!-- class='xowiki-content' -->
