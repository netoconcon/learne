import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "product" ]

  pricefill() {
  	const aux = this.productTarget.value;
  	console.log(aux);
	}
}
