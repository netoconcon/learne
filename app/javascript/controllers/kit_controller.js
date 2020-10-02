import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "product", "quantity", "sumvalue", "valor", "plan" ]

  pricefill() {
  	const hash = gon.products;
  	
  	const aux = this.productTarget.value;
  	const sum = [];
		hash.forEach((e) => {
			if(e['id'] == aux) {
				const x = e['price_cents'];
				sum.push(x);
				return console.log(x);
			}
		});
		console.log(sum)
	}

	quantity() {
		console.log(this.quantityTarget.value);
	}

	plans (e) {
		const type = e.target.value
		console.log(type)
		if (type == "subscription") {
			this.planTarget.style.display = "block"
		} else if (type == "single") {
			this.planTarget.style.display = "none"
		}

	}
}
