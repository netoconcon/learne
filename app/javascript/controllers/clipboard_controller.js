import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "copy", "url", "hidden" ]
	
	copy(e) {
		this.hiddenTarget.hidden = false
		this.urlTarget.focus()
		this.urlTarget.select()
		try {
			const url = document.execCommand('copy');
			var msg = url ? 'Copiado para a área de transferência!' : 'Não foi possível copiar para a área de transferência';
			alert(msg);
			this.hiddenTarget.hidden = true
  	} catch (err) {
			alert('Não foi possível copiar para a área de transferência');
			this.hiddenTarget.hidden = true
		}
	}
}