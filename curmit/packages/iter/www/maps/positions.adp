<master>
<property name="title">@page_title;noquote@</property>
<property name="context">@context;noquote@</property>
<property name="head">
  <style type="text/css">
    #container {
      width: 1024px ;
    }
    #gmap {
      float: right;
      vertical-align: top;
      width: 600px;  
    }
    #context {
      float: left;
      width: 400px;
    }
  </style>
</property>

<div id="container">
  <div id="context">
    <blockquote>
      <b>Soggetto:  </b>@party_name;noquote@<br>
    </blockquote>
  </div>
  <div id="gmap">
     <include src="/packages/maps/lib/positions" 
       subquery="@subquery;noquote@" 
     />
  </div>
</div>





