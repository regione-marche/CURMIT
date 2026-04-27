<master src="/www/blank-master">
<if @doc@ defined><property name="&doc">doc</property></if>
<if @body@ defined><property name="&body">body</property></if>
<if @head@ not nil><property name="head">@head;noquote@</property></if>
<if @focus@ not nil><property name="focus">@focus;noquote@</property></if>
<property name="skip_link">@skip_link;noquote@</property>

<script>
function Onload(id) {
  nome_selectedolditem = "selectedolditem" + id
  var selectedolditem = sessionStorage.getItem(nome_selectedolditem);
  if (selectedolditem == id) {

      document.getElementById(id).classList.toggle("show");    

  }

}

</script>
<script>
function Onload_li(id) {
  nome_li_selectedolditem = "selectedolditem_li" + id
  var selectedolditem = sessionStorage.getItem(nome_li_selectedolditem);
  if (selectedolditem == id) {
      document.getElementById(id).classList.toggle("selected");

  }

}

</script>


<div id="wrapper">
  <div id="header" align=center>
    <!--<div class="block-marker">Begin header</div>-->
    &nbsp;<img src="/resources/img/logo_curmit.png" alt="testata" height=86px align=center>
    &nbsp;<img src="/resources/img/Logo_RegioneMarche.png" alt="testata" height=86px align=center>
<br><br>
<div id="breadcrumbs">
    <table width=100%>
      <tr>			
        <td align=left width=40%>
	<div id="header-navigation-left"><big><big> <!--mat01-->
	<if @context_bar@ not nil>
        @context_bar;noquote@
      </if>
      <else>
        <if @context:rowcount@ not nil>
	<multiple name="context">
          <if @context.url@ not nil>
            <a href="@context.url@">@context.label@</a> @separator@
          </if>
          <else>
            @context.label@
          </else>
         </multiple>
        </if>
	</big></big></div> <!-- mat01 -->
	 </td>
       <td align=center width=20%><big><big>BENVENUTI IN CURMIT</big></big></td>
       <td align=right width=40%>
          <div id="header-navigation"><big><big>
<!--          <if @untrusted_user_id@ ne 0>#acs-subsite.Welcome_user#</if> -->
          <if @pvt_home_url@ not nil>
          <a href="/user/password-update" title="Cambia password">Cambia password</a> |
        </if>
        <if @login_url@ not nil>
          <a href="@login_url@" title="#acs-subsite.Log_in_to_system#">Entra</a>
        </if>
        <if @logout_url@ not nil>
          <a href="@logout_url@" title="#acs-subsite.Logout_from_system#">#acs-subsite.Logout#</a>
        </if>
        </else>   
        </big></big>
        </div>
       </td>
   </tr>
</table>
</div>
  <if @navigation:rowcount@ not nil>
    <list name="navigation_groups">
      <div id="@navigation_groups:item@-navigation">
        <div class="block-marker">Begin @navigation_groups:item@ navigation</div>
        <ul>
          <multiple name="navigation">
          <if @navigation.group@ eq @navigation_groups:item@>
            <li<if @navigation.id@ not nil> id="@navigation.id@"</if>><a href="@navigation.href@"<if @navigation.target@ not nil> target="@navigation.target;noquote@"</if><if @navigation.class@ not nil> class="@navigation.class;noquote@"</if><if @navigation.title@ not nil> title="@navigation.title;noquote@"</if><if @navigation.lang@ not nil> lang="@navigation.lang;noquote@"</if><if @navigation.accesskey@ not nil> accesskey="@navigation.accesskey;noquote@"</if><if @navigation.tabindex@ not nil> tabindex="@navigation.tabindex;noquote@"</if>>@navigation.label@</a></li>
          </if>
          </multiple>
        </ul>
      </div>
    </list>
  </if>

  <div id="content-wrapper">
    <div class="block-marker">Begin main content</div>
    <div id="inner-wrapper">
        
    <if @user_messages:rowcount@ gt 0>
      <div id="alert-message">
        <multiple name="user_messages">
          <div class="alert">
            <strong>@user_messages.message;noquote@</strong>
          </div>
         </multiple>
       </div>
     </if>

     <table width="100%" border="0" cellpadding="0" cellspacing="0">
       <tr>

<!--sim         <td valign="top" style="background-image:url(/resources/img/ombra_colonna_left.png); background-position: right;" width="60">
                 <img src="/resources/img/angolo.png" width="60" height="60" alt="angolo">
         </td> -->

         <td valign="top" id="left" >
	   <br>
	   <br>

		<div class="menu">
<h1 class="h1_like_h4"><!--mat01 cambiato h4 con h1 perchè a mauve++ non piaceva che non fossero progressivi. non cambio il css di h1 per non rompere tutto--> 
PORTALE SERVIZI
</h1><!--mat01-->

<!-- mis01: aggiunto menu -->
<if @user_id@ eq 0 and @token_cohesion;noquote@ eq "">
                <h2>
		   <button onclick="OpenMenu('menu1')" class="dropbtn">Sei già registrato? Accedi ai servizi</button>
                </h2>
	
               <ul id="menu1"class="dropdown-content">
<!-- gac		 <br>-->
                <if @login_cohesion_marche_p@ eq "1"> <!-- nic02 aggiunta if -->
                     <li id="li_2" class="li_class"><a onclick="return Clicklink('li_2');"  href="/iter-portal/citizen-services"<if @page_url@ eq /iter-portal/plants-filter> id="active"</if>><span>
                           Accedi ai servizi come cittadino</span> </a></li>
                </if>
                <if @login_cittadino_p@ eq "1"> <!-- rom01 aggiunta if -->
                     <li id="li_2" class="li_class"><a onclick="return Clicklink('li_2');"  href="/iter-portal/login-cittadino"<if @page_url@ eq /iter-portal/plants-filter> id="active"</if>><span>
                           Accedi ai servizi come cittadino</span> </a></li>
                </if>
                     <li id="li_1" class="li_class"><a onclick="return Clicklink('li_1');" href="/services"<if @page_url@ eq /iter-portal/plants-filter> id="active"</if>><span>
                           Accedi ai servizi come altro operatore</span></a></li>
<!--gac                   <br>-->
                   </ul>
		   <script>Onload('menu1');
                   </script>
                   <script>Onload_li('li_1');
                   </script>
                   <script>Onload_li('li_2');
                   </script>

<!--rom03 Aggiunta sezione-->
               <h2>
                   <button onclick="location.href = '/iter-portal/companies"
			   <if @page_url@ eq /iter-portal/companies> id="active"</if>
			   id="menu23"
			   class="dropbtn">Cerca Manutentore/Installatore</button>
                </h2>
                  <script type="text/javascript">
		    document.getElementById("menu23").onclick = function () {
                    location.href = "/iter-portal/companies";
		    };
		    </script>
<!--rom03 fine -->      

                <h2>
		   <button onclick="OpenMenu('menu5')" class="dropbtn">Non sei registrato? Registrati come:</button>
                </h2>
	
               <ul id="menu5"class="dropdown-content">
<!--gac		 <br>-->
                           <li id="li_3" class="li_class"><a onclick="return Clicklink('li_3');"  href=/iter-portal/user-new><span>Manutentore/Installatore/Terzo Responsabile</span></a></li>
                           <li id="li_4" class="li_class"><a onclick="return Clicklink('li_4');"  href=/iter-portal/distr/new><span>Distributore di combustibile</span></a></li>
                           <!-- <li><a href=/iter-portal/office/new>Studio associato</a></li> -->
                           <li id="li_5" class="li_class"><a onclick="return Clicklink('li_5');"  href=/iter-portal/jbuild/trustee-new><span>Amministatore di condominio</span></a></li>
                <if @login_cohesion_marche_p@ eq "1"> <!-- nic02 aggiunta if -->
                           <li id="li_6" class="li_class"><a onclick="return Clicklink('li_6');"  href=@url_registrati_come_cittadino;noquote@><span>Cittadino</span></a></li>
                </if>
                <if @login_cittadino_p@ eq "1"> <!-- rom01 aggiunta if -->
                           <li id="li_6" class="li_class"><a onclick="return Clicklink('li_6');"  href=/iter-portal/citizen-new><span>Cittadino</span></a></li>
                </if>
                           <li id="li_7" class="li_class"><a onclick="return Clicklink('li_7');"  href=/cait/><span>CAIT</span></a></li>
		   <li id="li_29" class="li_class">
		     <a onclick="return Clicklink('li_29');" href=/iter-portal/software-house/software-house-new>
		       <span>Software-House</span>
		     </a>
		   </li><!--rom04-->
<!-- gac              <br>-->
                   </ul>
		   <script>Onload('menu5');
                   </script>
		   <script>Onload_li('li_3');
                   </script>
		   <script>Onload_li('li_4');
                   </script>
		   <script>Onload_li('li_5');
                   </script>
		   <script>Onload_li('li_6');
                   </script>
		   <script>Onload_li('li_7');
                   </script>
		   <script>Onload_li('li_29');
                   </script>

		   
</if>
<!-- mis01: fine nuovo menu -->
<!-- mis01: sostituito Menu con Normativa...
                   <h2>Menu</h2> -->

<!--mat01 inizio mat01 rendo questi pulsanti come gli altri -->

	  

             <if @sw_admin_p@ eq 1>

                <!--mat01
		    <ul class="dropdown-content show">
                     <li id="li_8" class="li_class"><a onclick="return Clicklink('li_8');  href="/iter-portal/admin"<if @page_url@ eq /iter-portal/admin> id="active"</if>><span>Amministrazione portale</span></a></li>
                    </ul>
                 -->

		<h2>
                  <button onclick="location.href = '/iter-portal/admin'"
                      <if @page_url@ eq /iter-portal/admin> id="active"</if>
                      class="dropbtn">Amministrazione portale
        	      </button>
		</h2>

		<script type="text/javascript">
        	    document.getElementById("active").onclick = function () {
        	    location.href = "/iter-portal/admin";
        	};
		</script>

	     </if>
	     <if @user_id@ ne 0 and @sw_admin_p@ ne 1>
               <!--mat01
		     <ul class="dropdown-content show">
		     <li id="li_8" class="li_class"><a onclick="return Clicklink('li_8');"  href="/iter-portal/services"<if @page_url@ eq /iter-portal/admin> id="active"</if>><span>Accedi ai servizi</span></a></li>
		                         </ul>
               -->
	     
		<h2>
                  <button onclick="location.href = '/iter-portal/services'"
                      <if @page_url@ eq /iter-portal/admin> id="active"</if>
                      class="dropbtn">Accedi ai servizi
                      </button>
                </h2>

                <script type="text/javascript">
                    document.getElementById("active").onclick = function () {
                    location.href = "/iter-portal/services";
                };
                </script>

	     </if>
             <if @sw_cait_p@ eq 1>
              <!--mat01
                       <ul class="dropdown-content show">
                       <li id="li_8" class="li_class"><a onclick="return Clicklink('li_8');" href="/iter-portal/cait/servcait"<if @page_url@ eq /iter-portal/cait/servcait> id="active"</if>><span>Amministrazione Cait</span></a></li>
                       </ul>
              -->

		<h2>
                  <button onclick="location.href = '/iter-portal/cait/servcait'"
                      <if @page_url@ eq /iter-portal/cait/servcait> id="active"</if>
                      class="dropbtn">Amministrazione Cait
                      </button>
                </h2>

                <script type="text/javascript">
                    document.getElementById("active").onclick = function () {
                    location.href = "/iter-portal/cait/servcait";
                };
                </script>

             </if>
	     <if @sw_distr_p@ eq 1><!-- rom02 aggiunta if e contenuto per sezione dei distributori -->
              <!--mat01
		       <ul class="dropdown-content show">
                       <li id="li_8" class="li_class"><a onclick="return Clicklink('li_8');" href="/iter-portal/distr/services"<if @page_url@ eq /iter-portal/distr/services> id="active"</if>><span>Amministrazione Distributori</span></a></li>
                       </ul>
             -->

		<h2>
                  <button onclick="location.href = '/iter-portal/distr/services'"
                      <if @page_url@ eq /iter-portal/distr/services> id="active"</if>
                      class="dropbtn">Amministrazione Distributori
                      </button>
                </h2>

                <script type="text/javascript">
                    document.getElementById("active").onclick = function () {
                    location.href = "/iter-portal/distr/services";
                };
                </script>

            </if>
	    <if @sw_soft_house_p@ eq 1><!-- rom04 aggiunta if e contenuto per sezione softwarehouse -->
             <!--mat01
		       <ul class="dropdown-content show">
		         <li id="li_8" class="li_class">
			   <a onclick="return Clicklink('li_8');" href="/iter-portal/software-house/servsoft"
			     <if @page_url@ eq /iter-portal/software-house/servsoft> id="active"</if>>
			     <span>Servizi Software-House</span>
			   </a>
			 </li>
		       </ul>
              -->

		<h2>
                  <button onclick="location.href = '/iter-portal/software-house/servsoft'"
                      <if @page_url@ eq /iter-portal/software-house/servsoft> id="active"</if>
                      class="dropbtn">Servizi Software-House
                      </button>
                </h2>

                <script type="text/javascript">
                    document.getElementById("active").onclick = function () {
                    location.href = "/iter-portal/software-house/servsoft";
                };
                </script>
	      
	    </if>
            <if @sw_ammi_cond_p@ eq 1><!-- rom05 aggiunta if e contenuto per sezione Amministratori di Condominio -->
              <!--mat01
		       <ul class="dropdown-content show">
		         <li id="li_8" class="li_class">
			   <a onclick="return Clicklink('li_8');" href="/iter-portal/jbuild/servtrust"
			     <if @page_url@ eq /iter-portal/jbuild/servtrust> id="active"</if>>
			     <span>Servizi Amministratori di Condominio</span>
			   </a>
			 </li>
		       </ul>
               -->

		<h2>
                  <button onclick="location.href = '/iter-portal/jbuild/servtrust'"
                      <if @page_url@ eq /iter-portal/jbuild/servtrust> id="active"</if>
                      class="dropbtn">Servizi Amministratori di Condominio
                      </button>
                </h2>

                <script type="text/javascript">
                    document.getElementById("active").onclick = function () {
                    location.href = "/iter-portal/jbuild/servtrust";
                };
                </script>


	</if>
<!-- fine mat01-->
      
<!--rom03 cambiati i link, faccio i redirect al sito della Regione -->
                   <button onclick="OpenMenu('menu2')" class="dropbtn">Da Sapere</button>
                   </h2>
                   <ul id="menu2"class="dropdown-content">
<!--		     <br>-->
		    <li id="li_9" class="li_class"><a onclick="return Clicklink('li_9');" href="https://www.regione.marche.it/Regione-Utile/Energia/Impianti-termici#Normativa"<if @page_url@ eq /rules> id="active"</if>><span>Normative</span></a></li>
                     <if @page_url@ in /rules /sanctions /differences>
                         <li id="li_10" class="li_class"><a onclick="return Clicklink('li_10');"  href="/differences"<if @page_url@ eq /differences> id="active"</if>><span>&nbsp;&nbsp;&nbsp;* Difformità</span></a></li>
                     </if>
                     <li id="li_11" class="li_class"><a onclick="return Clicklink('li_11');" href="https://www.regione.marche.it/Regione-Utile/Energia/Impianti-termici#303_Definizioni"<if @page_url@ eq /definitions> id="active"</if>><span>Definizioni</span></a></li>
                     <if @page_url@ in /definitions /in_charge /booklet>
                         <li id="li_12" class="li_class"><a onclick="return Clicklink('li_12');"  href="/in_charge"<if @page_url@ eq /in_charge> id="active"</if>><span>&nbsp;&nbsp;&nbsp;* Il Responsabile</span></a></li>
                         <li id="li_13" class="li_class"><a onclick="return Clicklink('li_13');"  href="/booklet"<if @page_url@ eq /booklet> id="active"</if>><span>&nbsp;&nbsp;&nbsp;* Il libretto</span></a></li>
		     </if>
<!-- rom01: inizio modifiche -->		     
     	    	   <li id="li_14" class="li_class"><a onclick="return Clicklink('li_14');"  href="https://www.regione.marche.it/Regione-Utile/Energia/Impianti-termici#item304"<if @page_url@ eq /subjects> id="active"</if>><span>Soggetti coinvolti e loro compiti</span></a></li>
     		   <li id="li_15" class="li_class"><a onclick="return Clicklink('li_15');"  href="/authorities_contact"<if @page_url@ eq /authorities_contact> id="active"</if>><span>Elenco e recapiti Autorit&agrave; competenti</span></a></li>
    		   <li id="li_16" class="li_class"><a onclick="return Clicklink('li_16');"  href="https://www.regione.marche.it/Regione-Utile/Energia/Impianti-termici#item305"<if @page_url@ eq /ignition_period> id="active"</if>><span>Periodo di accensione e temperature</span></a></li>
 		   <li id="li_17" class="li_class"><a onclick="return Clicklink('li_17');"  href="https://www.regione.marche.it/Regione-Utile/Energia/Impianti-termici#306_Le-operazioni-di-manutenzione"<if @page_url@ eq /maintenance_operations> id="active"</if>><span>Le operazioni di manutenzione</span></a></li>
 		   <li id="li_18" class="li_class"><a onclick="return Clicklink('li_18');"  href="https://www.regione.marche.it/Regione-Utile/Energia/Impianti-termici#307_Il-controllo-dell%E2%80%99efficienza-energetica"<if @page_url@ eq /control_energy_efficiency> id="active"</if>><span>Il controllo dell'efficienza energetica</span></a></li>
 		   <li id="li_19" class="li_class"><a onclick="return Clicklink('li_19');"  href="/good_energy_efficiency"<if @page_url@ eq /good_energy_efficiency> id="active"</if>><span>Buone pratiche per l'efficienza energetica</span></a></li>
		    <li id="li_20" class="li_class"><a onclick="return Clicklink('li_20');"  href="/safety"<if @page_url@ eq /safety> id="active"</if>><span>Sicurezza degli impianti</span></a></li>
 		    <li id="li_21" class="li_class"><a onclick="return Clicklink('li_21');"  href="https://www.regione.marche.it/Regione-Utile/Energia/Impianti-termici#310_Impianti-disattivati"<if @page_url@ eq /requirements> id="active"</if>><span>Adempimenti per gli impianti disattivi</span></a></li>
 		    <li id="li_22" class="li_class"><a onclick="return Clicklink('li_22');"  href="https://www.regione.marche.it/Regione-Utile/Energia/Impianti-termici#309_Le-ispezioni"<if @page_url@ eq /documentary_checks> id="active"</if>><span>Controlli documentali e ispezioni</span></a></li>
 		    <li id="li_23" class="li_class"><a onclick="return Clicklink('li_23');"  href="https://www.regione.marche.it/Regione-Utile/Energia/Impianti-termici#311_Sanzioni"<if @page_url@ eq /sanctions> id="active"</if>><span>Sanzioni</span></a></li>





<!-- rom01: fine modifiche -->
<!--             <br>-->
	   </ul> 
                   <script>Onload('menu2');
                   </script>
		   <script>Onload_li('li_8');
                   </script>
		   <script>Onload_li('li_9');
                   </script>
		   <script>Onload_li('li_10');
                   </script>
		   <script>Onload_li('li_11');
                   </script>
		   <script>Onload_li('li_12');
                   </script>
		   <script>Onload_li('li_13');
                   </script>
		   <script>Onload_li('li_14');
                   </script>
		   <script>Onload_li('li_15');
                   </script>
		   <script>Onload_li('li_16');
                   </script>
		   <script>Onload_li('li_17');
                   </script>
		   <script>Onload_li('li_18');
                   </script>
		   <script>Onload_li('li_19');
                   </script>
		   <script>Onload_li('li_20');
                   </script>
		   <script>Onload_li('li_21');
                   </script>
		   <script>Onload_li('li_22');
                   </script>
		   <script>Onload_li('li_23');
                   </script>
<!--
		   <h2>
                   <button onclick="OpenMenu('menu3')" class="dropbtn">Links</button>
                   </h2>
		   <ul id="menu3"class="dropdown-content">
                     <br>
               	     <li><a href="https://www.regione.marche.it">Regione Marche</a></li>
		     <br>
		   </ul>
		   <script>Onload('menu3');
                   </script>
-->
		   <h2>
                   <!-- gac01 Modificate label solo per regione marche -->
                   <if @db_name@ eq "iter-portal-marche">
                     <button onclick="OpenMenu('menu4')" class="dropbtn">Servizi per il cittadino</button>
		   </if>
                   <else>
                     <button onclick="OpenMenu('menu4')" class="dropbtn">Consulta gli impianti e le<br>ditte di manutenzione</button>
		   </else>
                   </h2>
		   <ul id="menu4"class="dropdown-content">
<!--gac		     <br>-->
		     <li id="li_24" class="li_class"><a onclick="return Clicklink('li_24');"  href="/iter-portal/plants-filter"<if @page_url@ eq /iter-portal/plants-filter> id="active"</if>><span>Visualizzazione impianti cittadino</span></a></li>
<!-- spostato da sopra -->
                     <li id="li_25" class="li_class"><a onclick="return Clicklink('li_25');"  href="/iter-portal/companies"<if @page_url@ eq /iter-portal/companies> id="active"</if>><span>Cerca Manutentore/Installatore</span></a></li>
		     <li id="li_27" class="li_class"><a onclick="return Clicklink('li_27');"  href="https://www.regione.marche.it/Regione-Utile/Energia/Impianti-termici#298_per-il-Responsabile-d'impianto"><span>
			   Modulistica per il cittadino</span></a></li><!--rom04-->
		     <if @is_cittadino;noquote@ eq "1">
		     <li id="li_26" class="li_class"><a onclick="return Clicklink('li_26');"  href="/iter-portal/citizen-edit"><span>
                           Modifica Dati Personali</span></a></li>
                     </if>
<!--gac		     <br>-->
		   </ul> 
		   <script>Onload('menu4');
                   </script>
		   <script>Onload_li('li_24');
                   </script>
		   <script>Onload_li('li_25');
		   </script>
		   <script>Onload_li('li_26');
		   </script>
		   <script>Onload_li('li_27');
		   </script><!--rom04-->
		   

<!--rom03		   <h2>
                       <button onclick="OpenMenu('menu6')" class="dropbtn">Modulistica</button>
                   </h2>
                   <ul id="menu6"class="dropdown-content">
<!--gac                     <br>->
		     <li id="li_27" class="li_class"><a onclick="return Clicklink('li_27');"  href="https://www.regione.marche.it/Regione-Utile/Energia/Impianti-termici#Modulistica"<if @page_url@ eq /opdocs> id="active"</if>><span>Modulistica</span></a></li>
<!--gac                     <br>->
                   </ul>
                   <script>Onload('menu6');
                   </script>
		   <script>Onload_li('li_27');
                   </script>
rom03-->
                <h2>
                   <button onclick="location.href = 'https://www.regione.marche.it/Regione-Utile/Energia/Impianti-termici#Modulistica"
			   <if @page_url@ eq /opdocs> id="active"</if>
			   id="menu6"
			   class="dropbtn">Modulistica</button>
                   </h2>
                <script type="text/javascript">
                  document.getElementById("menu6").onclick = function () {
                  location.href = "https://www.regione.marche.it/Regione-Utile/Energia/Impianti-termici#Modulistica";
		  };
		</script>

	       
<!--rom03		   <h2>
                   <button onclick="OpenMenu('menu7')" class="dropbtn">Quesiti-FAQ-Esempi</button>
                   </h2>
               <ul id="menu7" class="dropdown-content">
		 <!--gac                     <br>->
                     <li id="li_28" class="li_class"><a onclick="return Clicklink('li_28');"  href="https://www.regione.marche.it/Regione-Utile/Energia/Impianti-termici#item300"<if @page_url@ eq /questions> id="active"</if>><span>Quesiti-FAQ-Esempi</span></a></li>
		     <!--gac                     <br>->
			 </ul>
               <script>Onload('menu7');
               </script>
               <script>Onload_li('li_28');
               </script>
rom03-->
                <h2>
                   <button onclick="location.href = 'https://www.regione.marche.it/Regione-Utile/Energia/Impianti-termici#item300" 
			   <if @page_url@ eq /questions> id="active"</if>
			   id="menu7"
			   class="dropbtn">Quesiti-FAQ-Esempi</button>
                   </h2>
		<script type="text/javascript">
		  document.getElementById("menu7").onclick = function () {
		  location.href = "https://www.regione.marche.it/Regione-Utile/Energia/Impianti-termici#item300";
		  };
		</script>

<!--rom 07/04/2021     <h2>
                   <button onclick="location.href = 'https://www.regione.marche.it/Portals/0/Energia/ImpiantiTermici/2019_autorita_competenti_per_le_verifiche.pdf?ver=2019-08-21-120219-757" 
			   <if @page_url@ eq /questions> id="active"</if>
			   id="menu8"
			   class="dropbtn">Assistenza</button>
                   </h2>
		<script type="text/javascript">
		  document.getElementById("menu8").onclick = function () {
		  location.href = "https://www.regione.marche.it/Portals/0/Energia/ImpiantiTermici/2019_autorita_competenti_per_le_verifiche.pdf?ver=2019-08-21-120219-757";
		  };
		</script>-->
                <h2><!--rom 07/04/2021 modificato link al documento-->
                   <button onclick="location.href = 'https://www.regione.marche.it/portals/0/Energia/ImpiantiTermici/autorita_competenti_per_le_verifiche.pdf" 
			   <if @page_url@ eq /questions> id="active"</if>
			   id="menu8"
			   class="dropbtn">Assistenza</button>
                   </h2>
		<script type="text/javascript">
		  document.getElementById("menu8").onclick = function () {
		  location.href = "https://www.regione.marche.it/portals/0/Energia/ImpiantiTermici/autorita_competenti_per_le_verifiche.pdf";
		  };
		</script>

            </div>

          </td>

<!--sim aggiunto barre laterali -->

         <td valign="top" style="padding: 0 15px 0 15px;">

           <slave />

         </td>


        </tr>
      </table>
 
    <div id="footer" style="display: flex; flex-wrap: wrap;justify-content: center; " ><!--mat01 aggiunto style-->
<!--      <ul class="compact">
        <li>U.C.I.T. s.r.l. - Società controllata e coordinata dalla Provincia di Udine
            Servizio controllo impianti termici Viale Tricesimo, 246 – 33100 UDINE tel. 0432/421769 – fax 0432/45766
            e-mail: ucit@ucit.udine.it - pec: info@pec.ucit.udine.it Registro Imprese di Udine e C.F. 02431160304 - Capitale Sociale 30.000 € i.v.
	    <br><a href="/nota_informativa">Nota informativa</a>&nbsp;&nbsp;&nbsp;<a href="/privacy">Privacy</a>
	</li>
      </ul>-->
      <ul class="compact">
        <li>Regione Marche Giunta Regionale (CF 80008630420) via Gentile da Fabriano, 9 - 60125 Ancona - tel. 071.8061</li>
	<br>
	<li>casella p.e.c. istituzionale : <a href="regione.marche.protocollogiunta@emarche.it">regione.marche.protocollogiunta@emarche.it</a></li>
      <br>
      <li><a href="/nota_informativa">Nota informativa</a>&nbsp;&nbsp;<a href="/privacy">Privacy</a></li><!--mat01 aggiunto tag li a privacy e nota informativa-->
</ul>
    </div>


    </div>  <!-- /inner-wrapper -->
  </div> <!-- /content-wrapper -->

</div> <!-- /wrapper -->

<script>
function OpenMenu(id) {
    document.getElementById(id).classList.toggle("show");
    nome_selectedolditem = "selectedolditem" + id
    sessionStorage.setItem(nome_selectedolditem, id);
    var a = document.getElementById(id).classList[1]
    if (document.getElementById(id).classList[1] != "show") {
       sessionStorage.removeItem(nome_selectedolditem);
    }

}
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js">
</script>
<script>

jQuery(document).ready(function($){
$("#slideshow > div:gt(0)").hide();
setInterval(function() {
$('#slideshow > div:first')
.fadeOut(1000)
.hide()
.next()
.fadeIn(1000)
.end()
.appendTo('#slideshow');
}, 10000);
}); 
    </script>

<script>
function Clicklink(id) {

    var lista_td = document.getElementsByTagName("li");

    for(i=0; i < lista_td.length; i++) {

        if (lista_td.item(i).getAttribute("id") != null) {
           nome_li_selectedolditem = "selectedolditem_li" + lista_td.item(i).getAttribute("id")
           sessionStorage.removeItem(nome_li_selectedolditem)
        }
    }

    document.getElementById(id).classList.toggle("selected");
    nome_li_selectedolditem = "selectedolditem_li" + id
    sessionStorage.setItem(nome_li_selectedolditem, id);
//    if (document.getElementById(id).classList[1] != "selected") {
//       sessionStorage.removeItem(nome_li_selectedolditem);
//    }

}
</script>
