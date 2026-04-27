ad_page_contract {

    Carica gli item di un menu.

    
    @author Claudio Pasolini

} {

}

# lo script dynamic-menu deve essere inserito a mano e quindi il suo id può essere differente nelle varie istanze
# tutti i menu saranno visualizzati da questo script
set dynamic_menu_id [db_string dyn "select script_id from mis_fast_scripts where title = 'iter/dynamic-menu'"]

# preparo la lista di nomi menu iter in funzione dei 'groups' creati
db_foreach group "
    select group_id
         , group_name
    from groups
    where group_id    > 0
" {
    set group($group_name) $group_id
    lappend group_names    '${group_name}'
}

set item_id 1              ; # primary key

# creo una tabella temporanea per girare sui vari menu
db_dml temp "
    create table mis_tt_menus (
        menu_id  integer primary key
      , livello  varchar(2)
      , scelta_1 varchar(2)
)"

# popolo la tabella con il primo livello
db_dml ins  "insert into mis_tt_menus values (1, '1', '0')"

set html ""               ; # eventuali errori
set there_are_rows 1

while {$there_are_rows} {

    db_foreach temp "select menu_id, livello, scelta_1 from mis_tt_menus" {

	switch $livello {
	    "1" {set where_scelte_a ""}
	    "2" {set where_scelte_a "and a.scelta_1 = :scelta_1"}
	}

        set old_nome_menu  ""
	# leggo le voci del vecchio menu 
	db_foreach item "
            select distinct
                   a.nome_menu
                 , a.seq
                 , a.scelta_1 as uno
                 , (a.livello::integer + 1)::text as liv
                 , b.descrizione
                 , b.tipo
                 , b.nome_funz     
            from coimmenu a 
                , coimogge b     
            where a.livello = :livello
              $where_scelte_a
              and a.nome_menu in ([join $group_names ,])
              and b.livello   = a.livello
              and b.scelta_1  = a.scelta_1
              and b.scelta_2  = a.scelta_2
              and b.scelta_3  = a.scelta_3
              and b.scelta_4  = a.scelta_4
            order by a.nome_menu, a.seq, a.scelta_1
        " {

	    if {$nome_menu ne $old_nome_menu} {
		set group_id      [db_string group "select group_id from groups where group_name = :nome_menu"]
                set script_seq    1           ; # sequenza item nel menu
		set old_nome_menu $nome_menu
	    }

	    if {$tipo eq "menu"} {

		# devo trovare la voce di mis_menus corrispondente in base alla descrizione
		set submenu_id [db_string get_id "select menu_id from mis_menus where substr(menu_name, 1, 18) = substr(:descrizione, 1, 18)" -default ""]
		if {$submenu_id eq ""} {
		    append html "<br>Menu $descrizione non trovato in mis_menus"
		    continue
		}
		set script_id $dynamic_menu_id
		set params    "menu_id=$submenu_id"

		# aggiungo questo menu alla tabella temporanea
		with_catch errmsg {
		    db_dml ins  "insert into mis_tt_menus values (:submenu_id, :liv, :uno)"
		} {
		    # ignoro duplicati
		}

	    } else {

		# è una funzione: devo trovare il path dello script
		if {[db_0or1row get_by_funz "
                    select azione || dett_funz as path
                         , parametri as params
                    from coimfunz
                    where nome_funz = :nome_funz
                      and tipo_funz = 'primario'
                "]} {
		    # devo trovare script_id attraverso il suo path
		    set script_id [db_string get_by_name "select script_id from mis_fast_scripts where title = 'iter/$path'" -default ""]
		    if {$script_id eq ""} {
			append html "<br>$path non trovato in mis_scripts"
			continue
		    }
		} else {
		    append html "<br>script $path non trovato"
		    continue
		}
	    }

	    db_dml new_item "
                insert into mis_menu_items (
                    item_id
                  , item_name
                  , script_id
                  , menu_id
                  , group_id
                  , script_seq
                  , params
                ) values (
                    :item_id
                  , :descrizione
                  , :script_id
                  , :menu_id
                  , :group_id
                  , :script_seq
                  , :params
                )"

	    incr item_id
	    incr script_seq

	}

	# elimino dalla tabella temporanea il menu appena elaborato
	db_dml del "delete from mis_tt_menus where menu_id = :menu_id"

    } if_no_rows {
	set there_are_rows 0
    }

}

# elimino la tabella temporanea
db_dml drop "drop table mis_tt_menus"

ns_return 200 text/html "Caricamento terminato. <p>$html"
