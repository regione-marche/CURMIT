ad_page_contract {@author dob}      

set cf "DBLDVD55C28C502O"

if {[iter::verifyfc -xcodfis $cf] == 0} {
    set corretto "errato"
} else {
    set corretto "corretto"
}
ns_return 200 text/html "$cf $corretto"
return

