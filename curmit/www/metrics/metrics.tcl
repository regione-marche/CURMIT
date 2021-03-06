ad_page_contract {

    Date due distinte origini del pacchetto, ne analizza le differenze
    evidenziando anche le are di sovrapposizione.

    @author Claudio Pasolini
} {
    origin1
    origin2
    {dirpath ""}
    {present_only_p "0"}
    {absent_only_p  "0"}
    {diff_size_p    "0"}
    {compare_all_p  "0"}
    {ftype ""}
}

if {$dirpath eq ""} {
    set where ""
    set compare_type "riepilogo iniziale"
} else {
    set where " and dirpath ~ '.+$dirpath/\[^/]+$'"
    set compare_type "limitato a $dirpath"
}

if {$present_only_p} {
    db_multirow presents query "
       select s1.fname from iter_scripts s1 where s1.package_key = :origin1 and s1.ftype = :ftype $where
       except
       select s2.fname from iter_scripts s2 where s2.package_key = :origin2 and s2.ftype = :ftype $where
       order by 1
    "
}

if {$absent_only_p} {
    db_multirow absents query "
       select s2.fname from iter_scripts s2 where s2.package_key = :origin2 and s2.ftype = :ftype $where
       except
       select s1.fname from iter_scripts s1 where s1.package_key = :origin1 and s1.ftype = :ftype $where
       order by 1
    "
}

if {$diff_size_p} {
    db_multirow diff_size_files query "
        select fname 
        from (
           select s1.fname from iter_scripts s1 where s1.package_key = :origin1 and s1.ftype = :ftype $where
           intersect all
           select s2.fname from iter_scripts s2 where s2.package_key = :origin2 and s2.ftype = :ftype $where
             ) a
        except
           select fname
           from (
           select s1.fname, s1.size from iter_scripts s1 where s1.package_key = :origin1 and s1.ftype = :ftype $where
           intersect all
           select s2.fname, s2.size from iter_scripts s2 where s2.package_key = :origin2 and s2.ftype = :ftype $where
             ) b
    "
}

if {$compare_all_p} {
    # trovo i file di tipo ftype con stesso nome e size
    set fnames [db_list intersect_by_name_size "
       select fname from (
           select s1.fname, s1.size from iter_scripts s1 where s1.package_key = :origin1 and s1.ftype = :ftype $where
           intersect
           select s2.fname, s2.size from iter_scripts s2 where s2.package_key = :origin2 and s2.ftype = :ftype $where
       ) sc2"]

    multirow create differents fn
    foreach fname $fnames {
	# confronto i file
        if {$origin2 eq "iter01" || $origin2 eq "iter02"} {
	    set path "/var/lib/aolserver/${origin2}$dirpath/$fname"
	} else {
	    set path "/var/lib/aolserver/$origin2/packages/iter$dirpath/$fname"
	}
	with_catch errmsg {
	    exec diff /var/lib/aolserver/${origin1}$dirpath/$fname $path
	} {
	    template::multirow append differents $fname
	}
    }
}

multirow create stat file_type tot1 tot2 inter_name inter_name_size inter_name_diff_size

foreach file_type [list tcl adp xql sql] {

    # totali 
    set tot1 [db_string t1 "select count(*) from iter_scripts where package_key = :origin1 and ftype = :file_type $where"]
    set tot2 [db_string t2 "select count(*) from iter_scripts where package_key = :origin2 and ftype = :file_type $where"]

    # intersezione su nome file
    set inter_name [db_string intersect_by_name "
       select count(*) from (
           select s1.fname from iter_scripts s1 where s1.package_key = :origin1 and s1.ftype = :file_type $where
           intersect all
           select s2.fname from iter_scripts s2 where s2.package_key = :origin2 and s2.ftype = :file_type $where
       ) sc1"]

    # intersezione su nome file e size
    set inter_name_size [db_string intersect_by_name_size "
       select count(*) from (
           select s1.fname, s1.size from iter_scripts s1 where s1.package_key = :origin1 and s1.ftype = :file_type $where
           intersect
           select s2.fname, s2.size from iter_scripts s2 where s2.package_key = :origin2 and s2.ftype = :file_type $where
       ) sc2"]

    set inter_name_diff_size [expr $inter_name - $inter_name_size]

    multirow append stat $file_type $tot1 $tot2 $inter_name $inter_name_size $inter_name_diff_size

}

