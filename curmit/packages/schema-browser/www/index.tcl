ad_page_contract {    
    data structures used

    column_info: a type of ns_set expected to containt the following values
    column_name
    data_type
    data_length
    column_comments
    constraint_list -- list of ids of constraint_info ns_sets
    data_default
    nullable
    

    constraint_info: a type of ns_set expected to containt the following values:
    constraint_name 
    constraint_type 
    constraint_columns -- list of column names
    search_condition -- optional -- not null and check constraint types only
    foreign_columns -- list of foreign column names -- optional -- foreign constraints only
    foreign_table -- optional -- foreign constraints only
    foreign_constraint  -- optional -- foreign constraints only
    r_constraint_name -- optional -- foreign constraints only

    @param table_name
    
    @author mark@ciccarello.com
    @creation-date ?
    @cvs-id $Id: index.tcl,v 1.5 2004/06/28 05:30:03 gabrielb Exp $
} {
    table_name:optional
}

# -----------------------------------------------------------------------------


if { [exists_and_not_null table_name] } {
    set context [list "Table: $table_name"]
    set page_title "Table: $table_name"
    set table_description [sb_get_table_description $table_name]
} else {
    set context ""
    set page_title "Schema Browser"
    set table_name ""
}


set table_list [sb_get_tables $table_name]

