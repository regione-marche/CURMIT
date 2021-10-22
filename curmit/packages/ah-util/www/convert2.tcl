set error_msg ""
with_catch error_msg {
    exec [ah::service_root]/packages/ah-util/bin/convert.sh /tmp/aolserver4.html application/vnd.oasis.opendocument.text text/html /tmp/aolserver4.odt

} {
}

ns_return 200 text/html "Fatto!<p>$error_msg"
