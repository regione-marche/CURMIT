<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
  <head>
    <title>Fullscreen HTMLArea</title>
    <script type="text/javascript">
      // the _editor_url is REQUIRED!  don't forget to set it.
     	 _editor_url = "/resources/acs-templating/xinha-nightly/";
      // implicit language will be "en", but let's set it for brevity
      _editor_lang = "de";
    </script>
   <script type="text/javascript" src="../../htmlarea.js"></script>
   <script type="text/javascript" src="../../lang/@htmlarea_lang_file@.js"></script>
  <script type="text/javascript">
		HTMLArea.loadPlugin("TableOperations");
		HTMLArea.loadPlugin("ContextMenu");
		HTMLArea.loadPlugin("LearnAtWU");
   </script>
    <!-- browser takes a coffee break here -->
    <script type="text/javascript">
		var parent_object  = null;
		var editor	   = null;	// to be initialized later [ function init() ]

	/* ---------------------------------------------------------------------- *\
	   Function    : 
	   Description : 
	\* ---------------------------------------------------------------------- */
	
	function _CloseOnEsc(ev) {
	// 	ev || (ev = window.event);
	  if (document.all) {
	    // IE
	    ev = window.event;
	    alert("IE!!!" + window.event);
	  }
	  alert("EV:" + ev);
		if (ev.keyCode == 27) {
			// update_parent();
			window.close();
			return;
		}
	}

	/* ---------------------------------------------------------------------- *\
	   Function    : resize_editor
	   Description : resize the editor when the user resizes the popup
	\* ---------------------------------------------------------------------- */
	
	function resize_editor() {  // resize editor to fix window
		var newHeight;
		if (document.all) {
			// IE
			newHeight = document.body.offsetHeight - editor._toolbar.offsetHeight;
			if (newHeight < 0) { newHeight = 0; }
		} else {
			// Gecko
			newHeight = window.innerHeight - editor._toolbar.offsetHeight;
		}
		if (editor.config.statusBar) {
			newHeight -= editor._statusBar.offsetHeight;
		}
		editor._textArea.style.height = editor._iframe.style.height = newHeight + "px";
	}

		/* ---------------------------------------------------------------------- *\
		   Function    : init
		   Description : run this code on page load
		\* ---------------------------------------------------------------------- */
		
		function init() {
			parent_object = opener.document.getElementById("@textarea_id@");
				
			// generate editor and resize it
			editor = new HTMLArea("editor", config);
		
			// register the plugins
			  editor.registerPlugin("TableOperations");
			  editor.registerPlugin("ContextMenu");
			  editor.registerPlugin("LearnAtWU", @community_id@, "fullscreen");
			// and restore the original toolbar
			var config = editor.config;
			// remove fullsize-button
			config.hideSomeButtons(" popupeditor ");

			editor.generate();
			editor._iframe.style.width = "100%";
			editor._textArea.style.width = "100%";
			resize_editor();
		
			editor.doctype = parent_object.doctype;
		
			// set child window contents and event handlers, after a small delay
			setTimeout(function() {
					   editor.setHTML(parent_object.value);
		
					   // continuously update parent editor window
					   setInterval(update_parent, 500);
		
					   // setup event handlers
		// 			   document.body.onkeypress = _CloseOnEsc;
		// 			   editor._doc.body.onkeypress = _CloseOnEsc;
		// 			   editor._textArea.onkeypress = _CloseOnEsc;
					   window.onresize = resize_editor;
				   }, 333);			 // give it some time to meet the new frame
		}
		
		/* ---------------------------------------------------------------------- *\
		   Function    : update_parent
		   Description : update parent window editor field with contents from child window
		   \* ---------------------------------------------------------------------- */
		
		function update_parent() {
			// use the fast version
			parent_object.value = editor.getInnerHTML();
		}
    </script>
    <style type="text/css"> html, body { height: 100%; margin: 0px; border: 0px; background-color: buttonface; } </style>
  </head>
  <body scroll="no" onload="setTimeout(function(){init();}, 500)" onunload="update_parent()">
    <form style="margin: 0px; border: 1px solid; border-color: threedshadow threedhighlight threedhighlight threedshadow;">
      <textarea name="editor" id="editor" style="width:100%; height:300px">&nbsp;</textarea>
    </form>
  </body>
</html>
