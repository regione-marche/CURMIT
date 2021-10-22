function conferma_copia_impianto() {

	 var confirmation = confirm( "Vuoi copiare anche l'appuntamento?" );

	 if( confirmation )
	     document.getElementById( 'conferma_inco' ).value = "T";
	 else
	     document.getElementById( 'conferma_inco' ).value = "F";

	 return true;
}
