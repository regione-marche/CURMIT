// AdHoc Javascript Utilities

//#######################################################################################################################
//                                            Funzionalità generali
//#######################################################################################################################

//=======================================================================================================================
//                                Posizionare un elemento in un punto arbitrario della pagina
//=======================================================================================================================

function ahPlaceElement(eid, x, y) {
    try {
	var element = document.getElementById(eid);
	
	element.style.position = 'absolute';
	element.style.zIndex   = '' + (element.style.zIndex + 1) + '';
	element.style.top      = y + 'px';
	element.style.left     = x + 'px';
    } catch (err) {
	//Molto probabilmente l'elemento fornito non esiste... fallisco silenziosamente.
    }
}

//=======================================================================================================================


//=======================================================================================================================
//                                               Fade di un elemento
//=======================================================================================================================

const TimeToFade  = 1000.0;

function ahFade (eid, timeToFade) {
    if (timeToFade == null) {
	timeToFade = 1000.0;
    }
    
    //Definita estendendo l'oggetto window, la funzione ha visibilità globale.
    //Faccio così invece di definirla esternamente perchè questa funzione ha significato
    //solo contestualmente alla chiamata di ahFade.
    window.ahAnimateFade = function (lastTick, eid) {
	var curTick = new Date().getTime();
	var elapsedTicks = curTick - lastTick;
	var element = document.getElementById(eid);

	if(element.FadeTimeLeft <= elapsedTicks) {
	    element.style.opacity = element.FadeState == 1 ? '1' : '0';
	    element.style.filter = 'alpha(opacity = ' + (element.FadeState == 1 ? '100' : '0') + ')';
	    element.FadeState = element.FadeState == 1 ? 2 : -2;
	    return;
	}

	element.FadeTimeLeft -= elapsedTicks;
	var newOpVal = element.FadeTimeLeft/timeToFade;
	if(element.FadeState == 1) {
	    newOpVal = 1 - newOpVal;
	}

	element.style.opacity = newOpVal;
	element.style.filter = 'alpha(opacity = ' + (newOpVal*100) + ')';
	
	setTimeout("ahAnimateFade(" + curTick + ",'" + eid + "')", 33);
    }

    var element = document.getElementById(eid);
    if(element == null) {
	return;
    }
    
    if (element.FadeState == null) {
	if(element.style.opacity == null || element.style.opacity == '' || element.style.opacity == '1') {
	    element.FadeState = 2;
	}
	else {
	    element.FadeState = -2;
	}
    }
      
    if (element.FadeState == 1 || element.FadeState == -1) {
	element.FadeState = element.FadeState == 1 ? -1 : 1;
	element.FadeTimeLeft = timeToFade - element.FadeTimeLeft;
    }
    else {
	element.FadeState = element.FadeState == 2 ? -1 : 1;
	element.FadeTimeLeft = timeToFade;
	setTimeout("ahAnimateFade(" + new Date().getTime() + ",'" + eid + "')", 33);
    }
}

//=======================================================================================================================


//=======================================================================================================================
//                                   Apre un popup all'url specificato
//=======================================================================================================================

function ahOpenZoom (url, size) {
    var width;
    var height;
    if (size == null) {
	size = medium;
    }
    switch (size)
    {
	case "small":
	  width = 640;
	  height = 240;
	  break;
	case "medium":
	  width = 800;
	  height = 480;
	  break;
	case "large":
	  width = 1024;
	  height = 600;
	  break;
	default:
	  width = 800;
	  height = 480;
	  break;
    }
    
    window.open(url, 'ah_zoom', 'scrollbars=yes,resizable=yes,width=' + width + ',height=' + height);
}

//=======================================================================================================================


//=======================================================================================================================
//                    Autocompleta un campo di form utilizzando un webservice. Utilizza ExtJs 4
//=======================================================================================================================

// fields è un array di array. Ciascu array è nella forma ('id_campo_da_modificare', '/percorso/del/ws')

function ahAutocomplete (fields) {
    
    // Modello dati comune a tutti i webservice di autocompletamento
    // - id: chiave primaria della tabella interrogata
    // - name: nome univoco del record, usualmente nella forma "$codice - $descrizione"
    Ext.define("WSModel", {
        extend: 'Ext.data.Model',
        fields: [
            {name: 'id'},
            {name: 'name'},
        ]
    });
    
    // Ottengo l'elemento che ha il focus attualmente.
    var activeElement = document.activeElement;
    
    // Verrà generato un ComboBox per ogni campo specificato.
    for (var i = 0; i < fields.length; i++) {
	
	var comboField = fields[i];
	
	var fieldId = comboField[0];
	var wsUrl   = comboField[1];
	
	var replacedElement = document.getElementById(fieldId);
    
	var extCombo = Ext.create('Ext.form.ComboBox', {
	    id: fieldId,
	    renderTo: 'extjs_' + fieldId,
	    store: Ext.create('Ext.data.Store', {
		model: 'WSModel',
		proxy: {
		    type: 'ajax',
		    url : wsUrl,
		    reader: {
			type: 'xml',
			record: 'data'
		    }
		}
	    }),
	    displayField: 'name',
	    valueField: 'id',
	    typeAhead: false,
	    hideTrigger:true,
	    width:450,
	    listConfig: {
		loadingText: 'Ricerca...',
		emptyText: 'Nessuna elemento trovato.'
	    },
	    listeners: {
		// Operazione eseguita quando si modifica il testo nel combo
		change: {
		    fn: function() {
			var replacedElement = document.getElementById(this.id);
			// Se il combo è stato svuotato annullo il valore del campo rimpiazzato.
			if (this.getValue() == null || this.getValue() == '') {
			    replacedElement.value = '';
			    try { replacedElement.onchange(); } catch (err) {}
			} else { //sim
                             replacedElement.value = this.getValue()  
                        }
		    }
		},
		// Operazione eseguita quando si seleziona una scelta dalla tendina
		select: {
		    fn: function() {
			var replacedElement = document.getElementById(this.id);
			var oldValue = replacedElement.value;
			replacedElement.value = this.getValue();
			// Se il campo originale prevedeva delle azioni, al suo cambiamento le eseguo.
			if (replacedElement.value != oldValue) {
			    try { replacedElement.onchange(); } catch (err) {}
			}
		    }
		},
		// Operazione eseguita prima che la combobox venga generata
		beforerender: {
		    fn: function() {
			var replacedElement = document.getElementById(this.id);
			// Recupero il campo della form che contiene il l'id e lo nascondo.
			replacedElement.style.display = 'none';
			
			// Creo il div che conterrà il combo.
			var y = document.createElement('div');
			y.id = this.renderTo;
			
			// Rimpiazzo il tag input del campo con il div.
			// Il tag rimpiazzato lo metto all'interno del div in modo che possa continuare
			// a ricevere l'id alla selezione.
			replacedElement.parentNode.replaceChild(y,replacedElement);
			y.appendChild(replacedElement);
			
			// Carico nello store il testo corrispondente all'id attualmente impostato.
			var idValue = replacedElement.value;
			if (idValue != '') {
			  this.store.load({
			      scope: this,
			      params:{id:idValue},
			      callback: function(records, options, success){
				this.setRawValue(records[0].get('name'));
			      }
			  });
			}
		  }
		}
	    }
	});
	
	if (replacedElement == activeElement) {
	    extCombo.focus();
	}
    }
}


//#######################################################################################################################
//                                            Funzionalità OpenACS
//#######################################################################################################################

//=======================================================================================================================
//                             Evidenzia il primo campo di una form OpenACS che presenta un errore
//=======================================================================================================================

function ahFocusError () {
    try {
	var errorLabel = document.getElementsByClassName('form-error')[0];
    
	var errorField = errorLabel.parentNode.getElementsByTagName('input')[0];
    
	//Se non riesco a ottenere il campo della form corrispondente all'errore
	//userò direttamente l'etichetta dell'errore come riferimento
	if (errorField == undefined) {
	    var errorField = errorLabel;
	    //Se uso l'etichetta dovrò scorrere più in basso la pagina
	    var y = errorField.offsetTop + (errorField.offsetHeight * 3) - window.innerHeight;
	} else {
	    var y = errorField.offsetTop + (errorField.offsetHeight * 2) - window.innerHeight;
	}
	
	errorField.focus();
	window.scrollTo(0,y);
    } catch (err) {
	//Molto probabilmente non esiste un tag di errore... fallisco silenziosamente.
    }
}

//=======================================================================================================================


//=======================================================================================================================
//               Fare si che il messaggio informativo in OpenACS sia sempre mostrato in cima allo schermo
//=======================================================================================================================

function ahPlaceAlertOnTop () {
    try {      
	//Recupero l'elemento che contiene i messaggi di allerta
	var alertElement = document.getElementById('alert-message');
	  
	if (alertElement.offsetTop <= window.pageYOffset) {
	    ahPlaceElement('alert-message', 0, window.pageYOffset);
	    setTimeout("ahFade('alert-message',2000)", 3000);
	    alertElement.style.width = '100%';
	}
    } catch (err) {
	//Molto probabilmente non esiste un messaggio d'allerta... fallisco silenziosamente.
    }
}

//=======================================================================================================================


//=======================================================================================================================
//                             Aggiungere funzionalità javascript per OpenAcs ad una form
//=======================================================================================================================

function ahEnhanceForms () {
    var forms = document.forms;
    
    for (var i = 0; i < forms.length; i++) {
	var form = forms[i];
    
	//Aggiunge a tutte le form un metodo 'refresh'
	form.refresh = function () {
	    this.__refreshing_p.value='1';
	    this.submit();
	}
    }
}

//=======================================================================================================================


//=======================================================================================================================
//                             Applica tutte le migliorie per OpenACS alla pagina
//=======================================================================================================================

function ahEnhancePage () {
    ahFocusError();
    ahPlaceAlertOnTop();
    ahEnhanceForms();
}

//=======================================================================================================================
