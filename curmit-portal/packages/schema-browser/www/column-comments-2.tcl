ad_page_contract {
    This is /www/doc/schema-browser/column-comments-2.tcl

    @param table_name
    @param column_name
    @param comments

    @author ?
    @creation-date ?
    @cvs-id $Id: column-comments-2.tcl,v 1.4 2013/09/09 17:34:17 gustafn Exp $
} {
    table_name:notnull
    column_name:notnull
    comments:notnull
} -validate {
    valid_table_name -requires {table_name} {
	if ![db_table_exists $table_name] {
	    ad_complain "Called with an invalid table name"
	}
    }

    valid_column_name -requires {column_name valid_table_name} {
	if ![db_column_exists $table_name $column_name] {
	    ad_complain "Called with an invalid column name"
	}
    }
}

db_dml comment_add "comment on column ${table_name}.$column_name is :comments"

ad_returnredirect "index?[export_vars -url {table_name}]"
