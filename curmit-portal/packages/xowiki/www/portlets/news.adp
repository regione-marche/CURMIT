<div class='Page'>
  <div class='portlet-wrapper'>
    <div class='portlet-header'>
      <div class='portlet-title-no-controls'>@name@</div>
    </div>
    <div class="portlet">
      <multiple name=news_items>
        <if @news_items.rownum@ le @n_news_items@>
          <br><b>@news_items.pretty_publish_date@ <a href="/news/item?item_id=@news_items.item_id@" onClick="toggleLinkContentFold('news_@news_items.item_id@');return false;">@news_items.publish_title@</a></b><br>
              <div id="news_@news_items.item_id@" style="display:none;">
                  @news_items.publish_body;noquote@
              </div>
        </if>
      </multiple>

      <if @news_items:rowcount@ eq 0>
        <p>  Attualmente non ci sono <em>news</em>. </p>
        <p>  <a href="/news/?view=archive">Consulta</a> l'archivio delle <em>news</em>.</p>
      </if>

      <if @news_items:rowcount@ gt @n_news_items@>
        <a href="/news/">altre <em>news</em></a>...
      </if>
    </div>
  </div>
</div>
