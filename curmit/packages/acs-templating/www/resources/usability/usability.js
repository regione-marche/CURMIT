// Questo set di funzioni javascript serve ad introdurre funzionalità per una maggiore usabilità


//=======================================================================================================================
//                                               Fade di un elemento
//=======================================================================================================================

//Setta la durata del fade in millisecondi
var TimeToFade  = 1000.0;

//eid è l'id dell'elemento che verrà sfumato
function fade(eid, timeToFade)
{
  var element = document.getElementById(eid);
  if(element == null)
    return;
  
  if(element.FadeState == null)
  {
    if(element.style.opacity == null 
	|| element.style.opacity == '' 
	|| element.style.opacity == '1')
    {
      element.FadeState = 2;
    }
    else
    {
      element.FadeState = -2;
    }
  }
    
  if(element.FadeState == 1 || element.FadeState == -1)
  {
    element.FadeState = element.FadeState == 1 ? -1 : 1;
    element.FadeTimeLeft = timeToFade - element.FadeTimeLeft;
  }
  else
  {
    element.FadeState = element.FadeState == 2 ? -1 : 1;
    element.FadeTimeLeft = timeToFade;
    setTimeout("animateFade(" + new Date().getTime() + ",'" + eid + "')", 33);
  }  
}

function animateFade(lastTick, eid)
{  
  var curTick = new Date().getTime();
  var elapsedTicks = curTick - lastTick;
  
  var element = document.getElementById(eid);

  if(element.FadeTimeLeft <= elapsedTicks)
  {
    element.style.opacity = element.FadeState == 1 ? '1' : '0';
    element.style.filter = 'alpha(opacity = ' 
	+ (element.FadeState == 1 ? '100' : '0') + ')';
    element.FadeState = element.FadeState == 1 ? 2 : -2;
    return;
  }

  element.FadeTimeLeft -= elapsedTicks;
  var newOpVal = element.FadeTimeLeft/TimeToFade;
  if(element.FadeState == 1)
    newOpVal = 1 - newOpVal;

  element.style.opacity = newOpVal;
  element.style.filter = 'alpha(opacity = ' + (newOpVal*100) + ')';
  
  setTimeout("animateFade(" + curTick + ",'" + eid + "')", 33);
}

//=======================================================================================================================


//=======================================================================================================================
//                                Posizionare un elemento in un punto arbitrario della pagina
//=======================================================================================================================

function placeElement(eid, x, y) {
  var element = document.getElementById(eid);
  
  element.style.position = 'absolute';
  element.style.zIndex   = '' + (element.style.zIndex + 1) + '';
  element.style.top      = y + 'px';
  element.style.left     = x + 'px';
}

//=======================================================================================================================


//=======================================================================================================================
//                                Evidenziare il primo campo della form che presenta un errore
//=======================================================================================================================

function focusError () {
  var errorLabel = document.getElementsByClassName('form-error')[0];
  
  if (errorLabel != null) {
    var errorField = errorLabel.parentNode.getElementsByTagName('input')[0];
  }
  
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
}

//=======================================================================================================================


//=======================================================================================================================
//                     Fare si che il messaggio informativo sia sempre mostrato in cima allo schermo
//=======================================================================================================================

function placeAlertMessage () {
  //Recupero l'elemento che contiene i messaggi di allerta
  var alertElement = document.getElementById('alert-message');
    
  if (alertElement != null && alertElement.offsetTop <= window.pageYOffset) {
    placeElement('alert-message', 0, window.pageYOffset);
    setTimeout("fade('alert-message',2000)", 3000);
    alertElement.style.width = '100%';
  }
}

//=======================================================================================================================