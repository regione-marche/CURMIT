/*
 * Ext JS Library 2.0
 * Copyright(c) 2006-2007, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */

/**
 * @class Ext.data.Connection
 * @extends Ext.util.Observable
 * The class encapsulates a connection to the page's originating domain, allowing requests to be made
 * either to a configured URL, or to a URL specified at request time.<br><br>
 * <p>
 * Requests made by this class are asynchronous, and will return immediately. No data from
 * the server will be available to the statement immediately following the {@link #request} call.
 * To process returned data, use a callback in the request options object, or an event listener.</p><br>
 * <p>
 * Note: If you are doing a file upload, you will not get a normal response object sent back to
 * your callback or event handler.  Since the upload is handled via in IFRAME, there is no XMLHttpRequest.
 * The response object is created using the innerHTML of the IFRAME's document as the responseText
 * property and, if present, the IFRAME's XML document as the responseXML property.</p><br>
 * This means that a valid XML or HTML document must be returned. If JSON data is required, it is suggested
 * that it be placed either inside a &lt;textarea> in an HTML document and retrieved from the responseText
 * using a regex, or inside a CDATA section in an XML document and retrieved from the responseXML using
 * standard DOM methods.
 * @constructor
 * @param {Object} config a configuration object.
 */
Ext.data.Connection = function(config){
    Ext.apply(this, config);
    this.addEvents(
        /**
         * @event beforerequest
         * Fires before a network request is made to retrieve a data object.
         * @param {Connection} conn This Connection object.
         * @param {Object} options The options config object passed to the {@link #request} method.
         */
        "beforerequest",
        /**
         * @event requestcomplete
         * Fires if the request was successfully completed.
         * @param {Connection} conn This Connection object.
         * @param {Object} response The XHR object containing the response data.
         * See <a href="http://www.w3.org/TR/XMLHttpRequest/">The XMLHttpRequest Object</a>
         * for details.
         * @param {Object} options The options config object passed to the {@link #request} method.
         */
        "requestcomplete",
        /**
         * @event requestexception
         * Fires if an error HTTP status was returned from the server.
         * See <a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html">HTTP Status Code Definitions</a>
         * for details of HTTP status codes.
         * @param {Connection} conn This Connection object.
         * @param {Object} response The XHR object containing the response data.
         * See <a href="http://www.w3.org/TR/XMLHttpRequest/">The XMLHttpRequest Object</a>
         * for details.
         * @param {Object} options The options config object passed to the {@link #request} method.
         */
        "requestexception"
    );
    Ext.data.Connection.superclass.constructor.call(this);
};

Ext.extend(Ext.data.Connection, Ext.util.Observable, {
    /**
     * @cfg {String} url (Optional) The default URL to be used for requests to the server. (defaults to undefined)
     */
    /**
     * @cfg {Object} extraParams (Optional) An object containing properties which are used as
     * extra parameters to each request made by this object. (defaults to undefined)
     */
    /**
     * @cfg {Object} defaultHeaders (Optional) An object containing request headers which are added
     *  to each request made by this object. (defaults to undefined)
     */
    /**
     * @cfg {String} method (Optional) The default HTTP method to be used for requests. (defaults to undefined; if not set but parms are present will use POST, otherwise GET)
     */
    /**
     * @cfg {Number} timeout (Optional) The timeout in milliseconds to be used for requests. (defaults to 30000)
     */
    timeout : 30000,
    /**
     * @cfg {Boolean} autoAbort (Optional) Whether this request should abort any pending requests. (defaults to false)
     * @type Boolean
     */
    autoAbort:false,

    /**
     * @cfg {Boolean} disableCaching (Optional) True to add a unique cache-buster param to GET requests. (defaults to true)
     * @type Boolean
     */
    disableCaching: true,

    /**
     * <p>Sends an HTTP request to a remote server.</p>
     * <p><b>Important:</b> Ajax server requests are asynchronous, and this call will
     * return before the response has been recieved. Process any returned data
     * in a callback function.
     * @param {Object} options An object which may contain the following properties:<ul>
     * <li><b>url</b> : String (Optional)<p style="margin-left:1em">The URL to
     * which to send the request. Defaults to configured URL</p></li>
     * <li><b>params</b> : Object/String/Function (Optional)<p style="margin-left:1em">
     * An object containing properties which are used as parameters to the
     * request, a url encoded string or a function to call to get either.</p></li>
     * <li><b>method</b> : String (Optional)<p style="margin-left:1em">The HTTP method to use
     * for the request. Defaults to the configured method, or if no method was configured,
     * "GET" if no parameters are being sent, and "POST" if parameters are being sent.</p></li>
     * <li><b>callback</b> : Function (Optional)<p style="margin-left:1em">The
     * function to be called upon receipt of the HTTP response. The callback is
     * called regardless of success or failure and is passed the following
     * parameters:<ul>
     * <li><b>options</b> : Object<p style="margin-left:1em">The parameter to the request call.</p></li>
     * <li><b>success</b> : Boolean<p style="margin-left:1em">True if the request succeeded.</p></li>
     * <li><b>response</b> : Object<p style="margin-left:1em">The XMLHttpRequest object containing the response data. See http://www.w3.org/TR/XMLHttpRequest/ for details about accessing elements of the response.</p></li>
     * </ul></p></li>
     * <li><b>success</b> : Function (Optional)<p style="margin-left:1em">The function
     * to be called upon success of the request. The callback is passed the following
     * parameters:<ul>
     * <li><b>response</b> : Object<p style="margin-left:1em">The XMLHttpRequest object containing the response data.</p></li>
     * <li><b>options</b> : Object<p style="margin-left:1em">The parameter to the request call.</p></li>
     * </ul></p></li>
     * <li><b>failure</b> : Function (Optional)<p style="margin-left:1em">The function
     * to be called upon failure of the request. The callback is passed the
     * following parameters:<ul>
     * <li><b>response</b> : Object<p style="margin-left:1em">The XMLHttpRequest object containing the response data.</p></li>
     * <li><b>options</b> : Object<p style="margin-left:1em">The parameter to the request call.</p></li>
     * </ul></p></li>
     * <li><b>scope</b> : Object (Optional)<p style="margin-left:1em">The scope in
     * which to execute the callbacks: The "this" object for the callback function.
     * Defaults to the browser window.</p></li>
     * <li><b>form</b> : Object/String (Optional)<p style="margin-left:1em">A form
     * object or id to pull parameters from.</p></li>
     * <li><b>isUpload</b> : Boolean (Optional)<p style="margin-left:1em">True if
     * the form object is a file upload (will usually be automatically detected).</p></li>
     * <li><b>headers</b> : Object (Optional)<p style="margin-left:1em">Request
     * headers to set for the request.</p></li>
     * <li><b>xmlData</b> : Object (Optional)<p style="margin-left:1em">XML document
     * to use for the post. Note: This will be used instead of params for the post
     * data. Any params will be appended to the URL.</p></li>
     * <li><b>jsonData</b> : Object/String (Optional)<p style="margin-left:1em">JSON
     * data to use as the post. Note: This will be used instead of params for the post
     * data. Any params will be appended to the URL.</p></li>
     * <li><b>disableCaching</b> : Boolean (Optional)<p style="margin-left:1em">True
     * to add a unique cache-buster param to GET requests.</p></li>
     * </ul></p>
     * <p>The options object may also contain any other property which might be needed to perform
     * postprocessing in a callback because it is passed to callback functions.</p>
     * @return {Number} transactionId The id of the server transaction. This may be used
     * to cancel the request.
     */
    request : function(o){
        if(this.fireEvent("beforerequest", this, o) !== false){
            var p = o.params;

            if(typeof p == "function"){
                p = p.call(o.scope||window, o);
            }
            if(typeof p == "object"){
                p = Ext.urlEncode(p);
            }
            if(this.extraParams){
                var extras = Ext.urlEncode(this.extraParams);
                p = p ? (p + '&' + extras) : extras;
            }

            var url = o.url || this.url;
            if(typeof url == 'function'){
                url = url.call(o.scope||window, o);
            }

            if(o.form){
                var form = Ext.getDom(o.form);
                url = url || form.action;

                var enctype = form.getAttribute("enctype");
                if(o.isUpload || (enctype && enctype.toLowerCase() == 'multipart/form-data')){
                    return this.doFormUpload(o, p, url);
                }
                var f = Ext.lib.Ajax.serializeForm(form);
                p = p ? (p + '&' + f) : f;
            }

            var hs = o.headers;
            if(this.defaultHeaders){
                hs = Ext.apply(hs || {}, this.defaultHeaders);
                if(!o.headers){
                    o.headers = hs;
                }
            }

            var cb = {
                success: this.handleResponse,
                failure: this.handleFailure,
                scope: this,
                argument: {options: o},
                timeout : this.timeout
            };

            var method = o.method||this.method||(p ? "POST" : "GET");

            if(method == 'GET' && (this.disableCaching && o.disableCaching !== false) || o.disableCaching === true){
                url += (url.indexOf('?') != -1 ? '&' : '?') + '_dc=' + (new Date().getTime());
            }

            if(typeof o.autoAbort == 'boolean'){ // options gets top priority
                if(o.autoAbort){
                    this.abort();
                }
            }else if(this.autoAbort !== false){
                this.abort();
            }
            if((method == 'GET' && p) || o.xmlData || o.jsonData){
                url += (url.indexOf('?') != -1 ? '&' : '?') + p;
                p = '';
            }
            this.transId = Ext.lib.Ajax.request(method, url, cb, p, o);
            return this.transId;
        }else{
            Ext.callback(o.callback, o.scope, [o, null, null]);
            return null;
        }
    },

    /**
     * Determine whether this object has a request outstanding.
     * @param {Number} transactionId (Optional) defaults to the last transaction
     * @return {Boolean} True if there is an outstanding request.
     */
    isLoading : function(transId){
        if(transId){
            return Ext.lib.Ajax.isCallInProgress(transId);
        }else{
            return this.transId ? true : false;
        }
    },

    /**
     * Aborts any outstanding request.
     * @param {Number} transactionId (Optional) defaults to the last transaction
     */
    abort : function(transId){
        if(transId || this.isLoading()){
            Ext.lib.Ajax.abort(transId || this.transId);
        }
    },

    // private
    handleResponse : function(response){
        this.transId = false;
        var options = response.argument.options;
        response.argument = options ? options.argument : null;
        this.fireEvent("requestcomplete", this, response, options);
        Ext.callback(options.success, options.scope, [response, options]);
        Ext.callback(options.callback, options.scope, [options, true, response]);
    },

    // private
    handleFailure : function(response, e){
        this.transId = false;
        var options = response.argument.options;
        response.argument = options ? options.argument : null;
        this.fireEvent("requestexception", this, response, options, e);
        Ext.callback(options.failure, options.scope, [response, options]);
        Ext.callback(options.callback, options.scope, [options, false, response]);
    },

    // private
    doFormUpload : function(o, ps, url){
        var id = Ext.id();
        var frame = document.createElement('iframe');
        frame.id = id;
        frame.name = id;
        frame.className = 'x-hidden';
        if(Ext.isIE){
            frame.src = Ext.SSL_SECURE_URL;
        }
        document.body.appendChild(frame);

        if(Ext.isIE){
           document.frames[id].name = id;
        }

        var form = Ext.getDom(o.form);
        form.target = id;
        form.method = 'POST';
        form.enctype = form.encoding = 'multipart/form-data';
        if(url){
            form.action = url;
        }

        var hiddens, hd;
        if(ps){ // add dynamic params
            hiddens = [];
            ps = Ext.urlDecode(ps, false);
            for(var k in ps){
                if(ps.hasOwnProperty(k)){
                    hd = document.createElement('input');
                    hd.type = 'hidden';
                    hd.name = k;
                    hd.value = ps[k];
                    form.appendChild(hd);
                    hiddens.push(hd);
                }
            }
        }

        function cb(){
            var r = {  // bogus response object
                responseText : '',
                responseXML : null
            };

            r.argument = o ? o.argument : null;

            try { //
                var doc;
                if(Ext.isIE){
                    doc = frame.contentWindow.document;
                }else {
                    doc = (frame.contentDocument || window.frames[id].document);
                }
                if(doc && doc.body){
                    r.responseText = doc.body.innerHTML;
                }
                if(doc && doc.XMLDocument){
                    r.responseXML = doc.XMLDocument;
                }else {
                    r.responseXML = doc;
                }
            }
            catch(e) {
                // ignore
            }

            Ext.EventManager.removeListener(frame, 'load', cb, this);

            this.fireEvent("requestcomplete", this, r, o);

            Ext.callback(o.success, o.scope, [r, o]);
            Ext.callback(o.callback, o.scope, [o, true, r]);

            setTimeout(function(){Ext.removeNode(frame);}, 100);
        }

        Ext.EventManager.on(frame, 'load', cb, this);
        form.submit();

        if(hiddens){ // remove dynamic params
            for(var i = 0, len = hiddens.length; i < len; i++){
                Ext.removeNode(hiddens[i]);
            }
        }
    }
});

/**
 * @class Ext.Ajax
 * @extends Ext.data.Connection
 * Global Ajax request class.  Provides a simple way to make Ajax requests with maximum flexibility.  Example usage:
 * <pre><code>
// Basic request
Ext.Ajax.request({
   url: 'foo.php',
   success: someFn,
   failure: otherFn,
   headers: {
       'my-header': 'foo'
   },
   params: { foo: 'bar' }
});

// Simple ajax form submission
Ext.Ajax.request({
    form: 'some-form',
    params: 'foo=bar'
});

// Default headers to pass in every request
Ext.Ajax.defaultHeaders = {
    'Powered-By': 'Ext'
};

// Global Ajax events can be handled on every request!
Ext.Ajax.on('beforerequest', this.showSpinner, this);
</code></pre>
 * @singleton
 */
Ext.Ajax = new Ext.data.Connection({
    /**
     * @cfg {String} url @hide
     */
    /**
     * @cfg {Object} extraParams @hide
     */
    /**
     * @cfg {Object} defaultHeaders @hide
     */
    /**
     * @cfg {String} method (Optional) @hide
     */
    /**
     * @cfg {Number} timeout (Optional) @hide
     */
    /**
     * @cfg {Boolean} autoAbort (Optional) @hide
     */

    /**
     * @cfg {Boolean} disableCaching (Optional) @hide
     */

    /**
     * @property  disableCaching
     * True to add a unique cache-buster param to GET requests. (defaults to true)
     * @type Boolean
     */
    /**
     * @property  url
     * The default URL to be used for requests to the server. (defaults to undefined)
     * @type String
     */
    /**
     * @property  extraParams
     * An object containing properties which are used as
     * extra parameters to each request made by this object. (defaults to undefined)
     * @type Object
     */
    /**
     * @property  defaultHeaders
     * An object containing request headers which are added to each request made by this object. (defaults to undefined)
     * @type Object
     */
    /**
     * @property  method
     * The default HTTP method to be used for requests. (defaults to undefined; if not set but parms are present will use POST, otherwise GET)
     * @type String
     */
    /**
     * @property  timeout
     * The timeout in milliseconds to be used for requests. (defaults to 30000)
     * @type Number
     */

    /**
     * @property  autoAbort
     * Whether a new request should abort any pending requests. (defaults to false)
     * @type Boolean
     */
    autoAbort : false,

    /**
     * Serialize the passed form into a url encoded string
     * @param {String/HTMLElement} form
     * @return {String}
     */
    serializeForm : function(form){
        return Ext.lib.Ajax.serializeForm(form);
    }
});