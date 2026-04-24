-- menu dinamici
create table mis_menus (
    menu_id  	       integer primary key
    -- nome del menu nella UI (univoco nel contesto del padre)
  , menu_name          varchar(50) not null
    -- parent menu: può essere nullo nel caso di menu di primo livello
  , parent_id          integer references mis_menus (menu_id)
    -- se impostato a 't' NON espande questo menu (significativo solo per YUI menu)
  , collapse_p         boolean not null default 'f'
);

create unique index mis_menus_un  on mis_menus(parent_id, menu_name, menu_seq);
create unique index mis_menus_un2 on mis_menus(parent_id, menu_seq);

insert into mis_menus values (1, 'Menù principale', null, 'f');
insert into mis_menus values (2, 'Gestione amministrativa', 1, 'f');
insert into mis_menus values (3, 'Predisposizione controlli e registrazione esiti', 1, 'f');
insert into mis_menus values (4, 'Anagrafiche di riferimento', 1, 'f');
insert into mis_menus values (5, 'Stampe', 1, 'f');
insert into mis_menus values (6, 'Organizzazione del territorio', 1, 'f');
insert into mis_menus values (7, 'Tabelle tecniche', 1, 'f');
insert into mis_menus values (8, 'Tabelle definizione ambiente di lavoro', 1, 'f');
insert into mis_menus values (9, 'Funzioni di Utilità', 1, 'f');
insert into mis_menus values (10, 'Assunzioni di responsabilità', 1, 'f');
insert into mis_menus values (11, 'Allegati E3/E4', 1, 'f');
insert into mis_menus values (12, 'Voci fuori menu', 1, 'f');

create table mis_menu_items (
    item_id             integer primary key
  , item_name           varchar
  , script_id    	integer not null references mis_scripts (script_id)
    -- menu di riferimento 
  , menu_id             integer references mis_menus (menu_id)
    -- gruppo di riferimento
  , group_id            integer references groups (group_id)
    -- sequenza dello script nel menu
  , script_seq          integer
  , params              varchar
);

create unique index mis_menu_items_un  on mis_menu_items(menu_id, group_id, script_seq);

