ad_page_contract {

    Render a layout page.

    This is intended to be included, not called directly, with the following parameters
    defined:

    @param pageset The array describing the current portal (passed by reference)

    @author Don Baccus (dhogaza@pacifier.com)
    @creation-date 2004/01/24
    @cvs_id $Id: render-page.tcl,v 1.1.1.1 2008/07/22 07:31:02 donb Exp $

}

array set page [layout::page::get_render_data -page_id $pageset(page_id)]
set elements_exist_p [expr {[llength $page(element_list)] > 0}]
