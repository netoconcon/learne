import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "product", "teste" ]

  pricefill() {
  	const aux = this.productTarget.value;
  	this.testeTarget = aux;
  	console.log(aux);
	}
}
