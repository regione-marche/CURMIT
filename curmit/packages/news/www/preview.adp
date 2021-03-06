<master>
<property name="context">@context;noquote@</property>
<property name="doc(title)">@title;noquote@</property>

<div style="position: relative;">
<h1>@title;noquote@</h1>

<p>#news.lt_Your_news_item_will_b#</p>
<p>
  <if @news_admin_p@ ne 0>
   #news.It_will_go_live_on# @publish_date_pretty@.   
    <if @permanent_p@ eq "t">
      #news.lt_And_be_live_until_rev#
    </if>
    <else>	
      #news.It_will_move_into_archive_on# @archive_date_pretty@.
    </else>
  </if>
  <else>
    #news.lt_It_will_go_live_after#
  </else>
</p>
<p>
  #news.lt_To_the_readers_it_wil#
</p>

<div class="news-item-preview">
   <include src=news publish_body = "@publish_body;noquote@"
                     publish_format = "@publish_format;noquote@"
                     publish_lead = "@publish_lead@"
                     publish_title = "@publish_title;noquote@"
                     creator_link = "@creator_link;noquote@">
</div>

<div>
    @form_action;noquote@
     <div>@hidden_vars;noquote@</div>
     <div class="form-button"><input type=submit value="#news.Confirm#"></div>
    </form>
<if @action@ eq "News Item">
  @edit_action;noquote@ 
  <div>@image_vars;noquote@</div>
  <div class="form-button"><input type="submit" value="#news.Return_to_edit#"></div>
    </form>
</if>
</div>

    <div style="position: absolute; top: 0.2em; right: 0.2em;">
      <a href="./" class="button">#acs-kernel.common_Cancel#</a>
    </div>

</div>
