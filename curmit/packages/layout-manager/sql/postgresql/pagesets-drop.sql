-- drop layout pagesets datamodel
--
-- @author Don Baccus (dhogaza@pacifier)
-- @creation-date 2008-07-05
-- @version $Id: pagesets-drop.sql,v 1.1.1.1 2008/07/22 07:31:03 donb Exp $
--

select drop_package('layout_pageset');
drop table layout_pagesets;
select acs_object_type__drop_type('layout_pageset', 't');
