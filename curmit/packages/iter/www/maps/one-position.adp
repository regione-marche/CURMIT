<master>
<property name="title">@page_title;noquote@</property>
<property name="context"></property>
<h3>Usa il tasto 'Indietro' del browser per ritornare.</h3>
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
      <b>Soggetto:  </b>@name;noquote@<br>
      <b>Indirizzo: </b>@address;noquote@
    </blockquote>
  </div>
  <div id="gmap">
     <include src="/packages/maps/lib/one-position" 
       position_id="@cod_impianto;noquote@" 
     />
  </div>
</div>





