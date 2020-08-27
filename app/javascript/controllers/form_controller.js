import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "product" ]

  pricefill() {
  	const hash = gon.products;
  	const aux = this.productTarget.value;
		hash.forEach((e) => {
			if(e['id'] == aux) {
				const x = e['price_cents'];
				return console.log(x);
			}
		});
	}
}
