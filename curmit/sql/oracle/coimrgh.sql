create table coimrgh
     ( rgh_cde      number(03)    not null
     ) tablespace &ts_dat;

create unique index coimrgh_00
    on coimrgh 
     ( rgh_cde
     ) tablespace &ts_idx;

