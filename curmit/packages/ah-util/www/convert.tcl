set url      "http://localhost:8080/converter/service"
set formvars ""
set timeout  "30"

# preparo gli headers per jodconverter
set set_id [ns_set create headers]
ns_set put $set_id Content-Type text/html
ns_set put $set_id Accept       application/vnd.oasis.opendocument.text

set response [util_http_file_upload \
		  -file /tmp/aolserver4.html \
		  -name file_name \
		  -rqset $set_id \
		  $url \
		  $formvars \
		  $timeout]

set   fd [open /tmp/aolserver4.odt w]
puts  $fd $response 
close $fd

ns_return 200 text/html OK
