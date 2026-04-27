ad_library {
    Took these defs out of the /www/doc/schema-browser/index.tcl file.
}

ad_proc sb_get_tables_list {} {
   Get all tables that belong to the current user.
} {

    set tables ""

    db_foreach schema_browser_index_get_tables "
        select
          pg_class.relname as table_name
        from pg_class, pg_user
        where pg_user.usename = session_user and
          pg_user.usesysid = pg_class.relowner and
          pg_class.relkind = 'r'
        order by relname
    " {
        lappend tables $table_name
    }

    db_release_unused_handles
    return $tables

}

ad_proc sb_get_tables { selected_table_name } {
   Build an HTML table of all PG tables belonging to the current user.  Each PG table
   name is returned as a hyperlink to a page which displays the table's structure.
} {

    set n_columns 4
    set return_string ""

    set tables [sb_get_tables_list]
    if {[llength $tables] == 0} {
	return {No tables found. Make sure the owner of the tables in the
		database matches the user-id used by the web server to connect
		to the database.}
    }

    set n_rows [expr ([llength $tables] - 1) / $n_columns + 1]

    append return_string "<table>"
    for { set row 0 } { $row < $n_rows } { incr row } {
         append return_string "<tr>"
         for {set column 0} {$column < $n_columns} {incr column} {
             set i_element [expr $n_rows * $column + $row]
             if { $i_element < [llength $tables] } {
                 set table_name [lindex $tables $i_element]
                 if { $table_name == $selected_table_name } {
                     append return_string "<td><b>[string tolower $table_name]</b></td>"
	         } else {
                     append return_string "<td><a href=\"index?[export_vars -url {table_name}]\">[string tolower $table_name]</a></td>"
                 }
	     }
          
         }   
     append return_string "</tr>"
    }

    append return_string "</table>"

    return $return_string

}

ad_proc sb_get_triggers { table_name } {
   Get all non-RI triggers on the table.
} {
    set return_string "\n"
    db_foreach sb_get_triggers_select_1 "
        select
          tgname as trigger_name,
          trigger_type(tgtype) as trigger_type,
          case tgenabled when 't' then '' else '(disabled)' end as status,
          proname,
          tgfoid
        from
          pg_trigger t join (select oid from pg_class where relname = lower(:table_name)) c
            on (c.oid = t.tgrelid)
          join pg_proc p on (p.oid = t.tgfoid)
        where true
    " {
        append return_string "\nCREATE TRIGGER $trigger_name</a> $trigger_type EXECUTE PROCEDURE <a href=\"function-body?oid=$tgfoid\">$proname</a> $status"
    } if_no_rows {
        set return_string ""
    }
    return $return_string
}

ad_proc sb_get_child_tables { table_name {html_anchor_p "f"} } {
    Build an HTML snippet listing all tables which have at least one foreign key
    referring to table_name.
} {
    
    set return_string "\n\n-- Tables with foreign keys that refer to $table_name:"
    db_foreach schema_browser_get_referencess "
         select distinct r1.relname as child_table,
             conname as constraint_name
         from
             pg_trigger t,
             pg_class r,
             pg_class r1,
             pg_proc p,
             pg_constraint c
         where
             lower(r.relname) = lower(:table_name) and
             r.oid = t.tgconstrrelid and
             r1.oid = t.tgrelid and
             t.tgfoid = p.oid and
             c.conrelid  = r.oid and
             p.proname = 'RI_FKey_check_ins'
    " {
        if { $html_anchor_p == "t" } {
            append return_string "\n--<a href=\"index?table_name=$child_table\">[string tolower $child_table]</a>"
        } else {
            append return_string "\n--[string tolower $child_table]"
	} 
        if { ![string equal $constraint_name "<unnamed>"] } {
            append return_string "($constraint_name)"
        }
    } if_no_rows {
        set return_string ""
    }
    return $return_string
}

ad_proc sb_get_indexes { table_name { html_anchors_p "f" } {pki {}}} {
    Create statements for indexes on table_name.
} {

    
    set return_string "\n"
    set prev_index ""

    set indexes [db_list_of_lists sb_get_indexes_select_1 "
        select
          relname as index_name, 
          case when indisunique then ' UNIQUE' else NULL end as uniqueness,
          amname as index_type,
          indkey
        from
          pg_index i join (select oid from pg_class where relname = lower(:table_name)) c
            on (i.indrelid = c.oid)
          join pg_class index_class on (index_class.oid = i.indexrelid and not i.indisprimary)
          join pg_am a on (index_class.relam = a.oid)
        order by index_name"]

    if {![empty_string_p $pki]} { 
        lappend indexes [list {PRIMARY KEY} { UNIQUE} {} $pki]
    }

    foreach index $indexes {
        foreach {index_name uniqueness index_type indkey} $index {}

        set index_clause "([join [split $indkey " "] ","])"

        append return_string "\nCREATE$uniqueness INDEX [string tolower $index_name] ON [string tolower $table_name] ("
        set sep ""

        # JCD: need to preserve the order of the index columns 
        # since it matters a lot.

        db_foreach sb_get_indexes_select_2 "
            select
              a.attname as column_name, a.attnum
            from
              (select oid from pg_class where relname = lower(:table_name)) c
              join pg_attribute a on (c.oid = a.attrelid)
            where a.attnum in $index_clause
        " {
            set cname($attnum) $column_name
        }
        

        foreach indid [split $indkey " "] { 
            if {[info exists cname($indid)]} { 
                append return_string $sep$cname($indid)
                set sep ", "
            }
        }
        append return_string ");"
        unset -nocomplain cname
    }

    return $return_string
}

ad_proc sb_get_foreign_keys { table_name } {
    Build a list describing all foreign keys on table_name and their actions.
    We ignore MATCH conditions because Oracle doesn't support them, therefore
    OpenACS doesn't use them.  Same is true of SET NULL and SET DEFAULT actions
    hung on ON DELETE/ON UPDATE subclauses, but since Oracle *does* support 
    CASCADE as an action I had figure out how to grab this info from the system
    catalog anyway.

    This code is *horribly* convoluted, mostly a result of the non-obvious way
    that the needed information is organized in the PG system catalogs. 
g
    Feel free to clean this up if you want! 

    @author Don Baccus, though he hates to admit to writing such ugly code (dhogaza@pacifier.com) 

} {
    set complex_foreign_keys [list]
    db_foreach schema_browser_get_referencess "
         select t.tgargs as constraint_args,
             conname as constraint_name,
             'NOACTION' as action,
             'CHECK' as trigger_kind,
             r1.relname as refer_table,
             t.oid as oid,
             0 as sort_key
         from
             pg_trigger t,
             pg_class r,
             pg_class r1,
             pg_constraint c,
             pg_proc p
         where
             lower(r.relname) = lower(:table_name) and
             r.oid = t.tgrelid and
             r1.oid = t.tgconstrrelid and
             t.tgfoid = p.oid and
             c.conrelid  = r.oid and
             p.proname = 'RI_FKey_check_ins'
         union all
         select t.tgargs as constraint_args,
             conname as constraint_name,
             case 
               when p.proname like '%noaction%' then 'NOACTION'
               when p.proname like '%cascade%' then 'CASCADE'
               when p.proname like '%setnull%' then 'SET NULL'
               when p.proname like '%setdefault%' then 'SET DEFAULT'
             end as action,
             case
               when p.proname like '%upd' then 'ON UPDATE'
               when p.proname like '%del' then 'ON DELETE'
             end as trigger_kind,
             r1.relname as refer_table,
             t.oid as oid,
             1 as sort_key
         from
             pg_trigger t,
             pg_class r,
             pg_class r1,
             pg_constraint c,
             pg_proc p
         where
             lower(r.relname) = lower(:table_name) and
             r.oid = t.tgconstrrelid and
             r1.oid = t.tgrelid and
             t.tgfoid = p.oid and
             c.conrelid  = r.oid and
             not p.proname like 'RI%_check_%'
         order by oid, sort_key
       " {             
        set one_ri_datum [list]
        set arg_start 0
        while { ![empty_string_p $constraint_args] } {
            set arg_end [expr [string first "\\000" $constraint_args] - 1]
            lappend one_ri_datum [string range $constraint_args $arg_start $arg_end]
            set constraint_args [string range $constraint_args [expr $arg_end+5] end]
        }
        switch $trigger_kind {
            CHECK {
                 if { [info exists foreign_key_sql] } {
                     if { [info exists arg_count] && $arg_count == 1 } {
                         set references($on_var) $foreign_key_sql
                     } else {
                         lappend complex_foreign_keys $foreign_key_sql
                     }
                 }
                 if { [string equal $constraint_name "<unnamed>"] } {
                     set foreign_key_sql ""
                 } else {
                     set foreign_key_sql "CONSTRAINT $constraint_name "
                 }
                 set on_var_part ""
                 set refer_var_part ""
                 set sep ""
                 set arg_count 0
                 foreach { on_var refer_var } [lrange $one_ri_datum 4 end] {
                     append refer_var_part "$sep$refer_var"
                     append on_var_part "$sep$on_var"
                     set sep ", "
                     incr arg_count
                 }
                 if { $arg_count > 1 } {
                     append foreign_key_sql "FOREIGN KEY ($on_var_part) "
                 }
                 append foreign_key_sql "REFERENCES <a href=\"index?table_name=$refer_table\">$refer_table</a> ($refer_var_part)"
            }
            default {
                if { ![string equal $action "NOACTION"] } {
                    append foreign_key_sql " $trigger_kind $action"
                }
            }
        }
    }
    if { [info exists foreign_key_sql] } {
        if { $arg_count == 1 } {
            set references($on_var) $foreign_key_sql
        } else {
            lappend complex_foreign_keys $foreign_key_sql
        }
    }
    return [list [array get references] $complex_foreign_keys]
}


ad_proc -public sb_get_table_size {
	{-table_name:required}
	{-namespace {public}}
	{-block_size {8192}}
} {
	Returns the size of the table on disk. This information is only updated
	by the commands VACUUM, ANALYZE, and CREATE INDEX. Thus, if you have
	been changing your table, run ANALYZE on the table before running this
	proc.

	@param table_name The table name
	@param namespace The database namespace that contains the table
	@param block_size Size of BLCKSZ (in bytes) used by the database

	@return This procedure returns a list with 2 items:
		<ol>
		<li> Size of the table on disk (in bytes), or -1 if the table was not found
		<li> Number of rows in the table, or -1 if the table was not found
		</ol>

	@author Gabriel Burca (gburca-openacs@ebixio.com)
	@creation-date 2004-06-27
} {
	set res [db_0or1row sb_get_table_size "
		select relpages * :block_size as size_in_bytes, reltuples as table_rows
		from pg_class
		where relnamespace = (select oid from pg_namespace where nspname = :namespace)
		and relname = :table_name
	"]
	if {$res} {
		return [list $size_in_bytes $table_rows]
	} else {
		# No such table in the namespace?
		return [list -1 -1]
	}
}


ad_proc sb_get_table_description { table_name } {} {

    set foreign_keys [sb_get_foreign_keys $table_name]
    array set references [lindex $foreign_keys 0]
    set complex_foreign_keys [lindex $foreign_keys 1]

    set html "<pre>"

    # get table comments
    # JCD: pg_description changed from 7.1 to 7.2 so do the correct query... 
    if { [string match {7.[01]*} [db_version]]} {
        if { [db_0or1row sb_get_table_comment "
            select d.description 
              from pg_class c, pg_description d
             where c.relname = lower(:table_name) 
               and d.objoid = c.relfilenode"] } {
            append html "\n--[join [split $description "\n"] "\n-- "]"
        }
    } else { 
        if { [db_0or1row sb_get_table_comment "
            select d.description 
              from pg_class c, pg_description d
             where c.relname = lower(:table_name) 
               and d.objoid = c.oid and objsubid = 0"] } {
                append html "\n--[join [split $description "\n"] "\n-- "]"
        }
    }
                   
    append html "\nCREATE TABLE [string tolower $table_name] ("

    if { [db_0or1row sb_get_primary_key "
            select
              indkey as primary_key_array
            from
              pg_index i join (select oid from pg_class where relname = lower(:table_name)) c
                on (i.indrelid = c.oid)
              join pg_class index_class on (index_class.oid = i.indexrelid and i.indisprimary)
              join pg_am a on (index_class.relam = a.oid)"] } {
        set primary_key_columns [split $primary_key_array " "]
    } else {
        set primary_key_columns [list]
    }

    set column_list [list]
    set column_info_set [ns_set create]

    # DRB: This changes some PG internal types into SQL92 standard types for readability's
    # sake.

    # JCD: pg_description changed from 7.1 to 7.2 so do the correct query... 
    if { [string match {7.[01]*} [db_version]]} {
        set pg_description_join "left join pg_description d on (a.oid = d.objoid)"
    } else { 
        set pg_description_join "left join pg_description d on (c.oid = d.objoid and a.attnum = d.objsubid)"
    }

    db_foreach schema_browser_index_get_user_table_data "
        select
            a.attname as column_name,
            case when t.typlen = -1 and t.typname <> 'numeric'
              then a.atttypmod - 4
              else NULL
            end as data_length,
            case when t.typname = 'numeric'
              then a.atttypmod::int4 & 65535 - 4
              else NULL
            end as scale,
            case
              when t.typname = 'numeric'
              then (a.atttypmod::int4 >> 16) & 65535
              else NULL
            end as precision,
            case t.typname
              when 'int4' then 'integer'
              when 'bpchar' then 'char'
              else t.typname 
            end as data_type,
            d.description as column_comments,
            ad.adsrc as data_default,
            substr(lower(:table_name),1,15) || '_' || substr(lower(a.attname),1,15) as column_constraint_key,
            case a.attnotnull when true then 'NOT NULL' else '' end as nullable,
            a.attnum as column_number
        from (select oid from pg_class where relname=lower(:table_name)) c
             join pg_attribute a on (c.oid = a.attrelid and a.attnum > 0)
             join pg_type t on (a.atttypid = t.oid)
             left join pg_attrdef ad on (a.attrelid = ad.adrelid and a.attnum = ad.adnum)
             $pg_description_join
        order by a.attnum" -column_set column_info_set {

        lappend column_list [ns_set copy $column_info_set]
    }
    ns_set free $column_info_set

    # current_contraint_info -- a constraint_info_set for the constraint being processed in the loop below
    set check_constraint_set [ns_set create]
    if {![string match {7.[12]*} [db_version]]} {
	db_foreach schema_browser_index_get_subselect "
            select
              conname as constraint_name,
              consrc as constraint_source
            from
              pg_constraint r join (select oid from pg_class where relname = lower(:table_name)) c
              on (c.oid = r.conrelid)
            order by constraint_name " {
		ns_set put $check_constraint_set $constraint_name $constraint_source
	    }
    } else {
	db_foreach schema_browser_index_get_subselect "
        select
          rcname as constraint_name,
          rcsrc as constraint_source
        from
         pg_relcheck r join (select oid from pg_class where relname = lower(:table_name)) c
           on (c.oid = r.rcrelid)
        order by constraint_name " {
	    ns_set put $check_constraint_set $constraint_name $constraint_source
	}
    }
    #
    # write out the columns with associated constraints
    #
    
    set n_column 0

    foreach column $column_list {
	if { $n_column > 0 } {
	    append html ","
	}
	set column_comments [ns_set get $column "column_comments"]
	if {$column_comments != ""} {
            set comment_list [split $column_comments "\n"]
            append html "\n\t--[join $comment_list "\n\t-- "]"
	}
	append html "\n"
	append html "\t[string tolower [ns_set get $column column_name]]\t [ns_set get $column data_type]"
        if { ![empty_string_p [ns_set get $column data_length]] } {
            append html "([ns_set get $column data_length])"
        }
        if { ![empty_string_p [ns_set get $column precision]] } {
            append html "([ns_set get $column precision], [ns_set get $column scale])"
        }
        if { [llength $primary_key_columns] == 1 && [lindex $primary_key_columns 0] == [ns_set get $column column_number] } {
            append html " PRIMARY KEY"
        }
	if { [ns_set get $column "data_default"] != "" } {
	    append html " DEFAULT [ad_text_to_html [ns_set get $column "data_default"]]"
	}
        if { [ns_set get $column "nullable"] != "" } {
	    append html " [ns_set get $column "nullable"]"
	}

        if { [info exists references([ns_set get $column column_name])] } {
            append html " $references([ns_set get $column column_name])"
        }

        if { ![empty_string_p [ns_set get $check_constraint_set [ns_set get $column column_constraint_key]]] } {
            append html "\n\t\t\tCHECK [ns_set get $check_constraint_set [ns_set get $column column_constraint_key]]"
            ns_set delkey $check_constraint_set [ns_set get $column column_constraint_key]
        }

        incr n_column
    }

    #
    # write out the table-level constraints in the table_constraint_list
    #
    
    for { set i 0 } { $i < [ns_set size $check_constraint_set] } { incr i } {
        if { ![empty_string_p [ns_set value $check_constraint_set $i]] } {
            append html ",\n	"
            if { [string first "\$" [ns_set key $check_constraint_set $i]] == -1 } {
                append html "CONSTRAINT [ns_set key $check_constraint_set $i]\n	"
            }
            append html "CHECK [ns_set value $check_constraint_set $i]"
        }
    }
    
    if { [llength $primary_key_columns] > 1 } {
        append html ",\n\tPRIMARY KEY ("
        set sep ""
    
        db_foreach sb_get_primary_key_select_2 "
            select
              a.attname as column_name 
            from
              (select oid from pg_class where relname = lower(:table_name)) c
              join pg_attribute a on (c.oid = a.attrelid)
              where a.attnum in ([join $primary_key_columns ","])
        " {
            append html $sep$column_name
            set sep ", "
        }
        append html ")"
    }

    foreach complex_foreign_key $complex_foreign_keys {
        append html ",\n\t$complex_foreign_key"
    }

    append html "\n);"
    append html [sb_get_indexes $table_name]
    append html [sb_get_triggers $table_name]
    append html [sb_get_child_tables $table_name "t"]

    if {[string match "pg_*" $table_name]} {
    	set table_size [sb_get_table_size -table_name $table_name -namespace "pg_catalog"]
    } else {
    	set table_size [sb_get_table_size -table_name $table_name]
    }
    append html "\n\n-- Table size: [util_commify_number [lindex $table_size 0]] bytes\n"
    append html "-- Table rows: [util_commify_number [lindex $table_size 1]]\n"

    append html "</pre>"
    
    return $html
    
}
