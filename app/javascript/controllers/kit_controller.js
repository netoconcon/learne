import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "product", "quantity", "sumprice", "valor", "plan", "price" ]

  pricefill() {
  	const hash = gon.products;
  	let price = 0;
  	const aux = this.productTarget.value;
  	hash.forEach((e) => {
			if(e['id'] == aux) {
				price = e['price_cents'];
				return price
			}
		console.log(price);
		console.log(this.quantityTarget.value);
		console.log(price * this.quantityTarget.value);
		});
		fetch(`/admin/kits/1/edit`, { headers: { accept: "application/json" } })
			.then(response => response.json())
			.then((data) => {
				this.sumpriceTarget.value = (price * this.quantityTarget.value);
				console.log(this.sumpriceTarget.value)
			})
	}


 //  pricefill() {
 //  	const hash = gon.products;
  	
 //  	const aux = this.productTarget.value;
 //  	const sum = [];
	// 	hash.forEach((e) => {
	// 		if(e['id'] == aux) {
	// 			const x = e['price_cents'];
	// 			sum.push(x);
	// 			return console.log(x);
	// 		}
	// 	});
	// 	console.log(sum)
	// }

	// quantity() {
	// 	console.log(this.quantityTarget.value);

	// }

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
