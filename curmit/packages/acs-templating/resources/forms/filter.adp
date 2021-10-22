<table cellspacing="0" cellpadding="0" border="0">
  <multiple name=elements>

    <group column="section">
      <if @elements.widget@ eq "hidden"> 
        <noparse><formwidget id=@elements.id@></noparse>
      </if>
  
      <else>

        <if @elements.widget@ eq "submit">
          <tr>
            <td align="left">
              <group column="widget">
                <noparse><formwidget id="@elements.id@" class="btn btn-primary"></noparse>
              </group>
            </td>
          </tr>
        </if>
        <else>

            <tr>
              <noparse>
                <if \@formerror.@elements.id@\@ not nil>
                  <td class="filter-label-error">
                </if>
                <else>
                  <td class="filter-label">
                </else>
              </noparse>
              @elements.label;noquote@
               </td>
            </tr>  

            <tr>
              <noparse>
                <if \@formerror.@elements.id@\@ not nil>
                  <td class="form-widget-error">
                </if>
                <else>
                  <td class="form-widget">
                </else>
              </noparse>

              <if @elements.widget@ eq radio or @elements.widget@ eq checkbox>
                <noparse>
                  <table class="formgroup">
                    <formgroup id="@elements.id@">
                      <tr>
                        <td>\@formgroup.widget;noquote@</td>
                        <td class="form-widget">
                          <label for="@elements.form_id@:elements:@elements.id@:\@formgroup.option@">
                            \@formgroup.label;noquote@
                          </label>
                        </td>
                      </tr>
                    </formgroup>
                  </table>
                </noparse>
              </if>

              <else>
                <noparse>
                  <formwidget id="@elements.id@">
                </noparse>
              </else>

              <noparse>
                <formerror id="@elements.id@">
                  <div class="form-error">
                    \@formerror.@elements.id@;noquote\@
                  </div>
                </formerror>
              </noparse>

            </td>
          </tr>

        </else>
      </else>
    </group>
  </multiple>

</table>
<p> </p>

