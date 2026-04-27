<multiple name=elements>
	<if @elements.section@ not nil>
		<fieldset id="@elements.form_id@:@elements.section@" @elements.sec_fieldset;noquote@><!-- section fieldset -->
        <legend @elements.sec_legend;noquote@><span>@elements.sec_legendtext@</span></legend>
	</if>
	
	<group column="section">
      <if @elements.widget@ eq "hidden"> 
		<noparse><formwidget id=@elements.id@></noparse><!-- mat01 tolto <div></div> dentro noparse-->
	  </if>
  
	  <else>
		<if @elements.widget@ eq "submit"><!-- if form submit button wrap it in the form-button class -->
  	<!-- mat01	<div class="form-button"> -->
           <group column="widget">
             <noparse><formwidget id="@elements.id@">&nbsp;</noparse>
           </group>
  	<!-- </div> -->
       </if>
        
	   <else> <!-- wrap the form item in the form-item-wrapper class -->
	     <div class="form-item-wrapper">
           <noparse>
			 <formerror id="@elements.id@">
			   <span class="form-error">
				 \@formerror.@elements.id@;noquote\@
			   </span> <!-- /form-error -->
			 </formerror>
		   </noparse>
		   <br><!--mat01-->
		   <if @elements.widget@ in radio checkbox> 
             <if @elements.legendtext@ defined>
			   <fieldset @elements.fieldset;noquote@>
                 <!-- radio button groups and checkbox groups get their own fieldsets -->
				 <legend @elements.legend;noquote@><span>@elements.legendtext@</span></legend>
             </if>
		   </if>

             <if @elements.label@ not nil>
			   <noparse>
                 <if @form_properties.mode@ eq display or @elements.widget@ in radio checkbox date inform>
                   <!-- no label tag -->
                 </if>
                 <else>
				   <label for="@elements.id@">
                 </else>

                 <if \@formerror.@elements.id@\@ not nil>
                   <span class="form-label form-label-error">
                 </if>
                 <else>
                   <span class="form-label">
                 </else>
               </noparse>

               @elements.label;noquote@

               <if @form_properties.show_required_p@ true>
                 <if @elements.optional@ nil and @elements.mode@ ne "display" and @elements.widget@ ne "inform">
                   <strong class="form-required-mark">(#acs-templating.required#)</strong>
                 </if>
               </if>
              </span>
	      </if>
		     <else>
		     <label for="@elements.id@"><span class="form-label"></span></label><!--mat01-->
		     <if @form_properties.show_required_p@ true>
                           <if @elements.optional@ nil and @elements.mode@ ne "display" and @elements.widget@ ne "inform">
			     <span class="form-label form-required-mark">
			       #acs-templating.required#
			     </span>
		           </if>
		        </if>
		     </else>
              <if @form_properties.mode@ eq display or @elements.widget@ in radio checkbox date inform> <!--mat01 aggiunto if-else e contenuti-->
	      </if><else>
	      </label>
	      </else>
	      <div class="form-widget-wrapper"><!--mat01-->
		     <if @elements.widget@ in radio checkbox> 
			   <noparse>
	         <span class="form-widget">
                 <formgroup id="@elements.id@">			
				   <label for="@elements.form_id@:elements:@elements.id@:\@formgroup.option@">
				     \@formgroup.widget;noquote@
					 \@formgroup.label;noquote@
				   </label><br>
				 </formgroup>
                 </span>
			   </noparse>
             </if>
			 <else>
			   <noparse>
                 <span class="form-widget">
                   <formwidget autocomplete="off" id="@elements.id@"> <!--mat01 aggiunto autocomplete="off"-->
                 </span>
			   </noparse>
<!--mat01
               <if @form_properties.mode@ eq display or @elements.widget@ in radio checkbox date inform><!-- no label tag </if>
               <else>
                 <if @elements.label@ not nil></label></if>
               </else>
mat01-->
             </else>							
           <if @elements.help_text@ not nil>
	   <span class="form-help-text">
               <img src="/shared/images/info.gif" width="12" height="9" alt="Help" title="Help text" style="border:0">
                 <noparse><formhelp id="@elements.id@"></noparse>
             </span> <!-- /form-help-text -->
           </if>

		   <if @elements.widget@ in radio checkbox> 
             <if @elements.legendtext@ defined>
               <!-- radio button groups and checkbox groups get their own fieldsets -->
			   </fieldset>
             </if>
		   </if>
		   </div><!--mat01 form-widget-wrapper-->
		 </div> <!-- form-item-wrapper -->
       </else>
	</else>
  </group>

  <if @elements.section@ not nil>
    </fieldset> <!-- section fieldset -->
  </if>
</multiple>
