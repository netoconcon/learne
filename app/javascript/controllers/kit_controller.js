import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "product", "quantity", "sumprice", "valor", "plan", "price", "installments" ]

  pricefill() {
  	const hash = gon.products;
  	let price = 0;
  	const aux = this.productTarget.value;
  	hash.forEach((e) => {
			if(e['id'] == aux) {
				price = e['price_cents'];
				return price
			}
		});
			console.log(price);
			console.log(this.quantityTarget.value);
			console.log(price * this.quantityTarget.value);
			fetch(`/admin/kits/11/edit`, { headers: { accept: "application/json" } })
				.then(response => response.json())
				.then((data) => {
					this.sumpriceTarget.value = (price * this.quantityTarget.value);
					console.log(this.sumpriceTarget.value);
			});
	}

	plans (e) {
		const type = e.target.value
		if (type == "subscription") {
			this.planTarget.style.display = "block"
			this.installmentsTarget.style.display = "none"
		} else if (type == "single") {
			this.planTarget.style.display = "none"
			this.installmentsTarget.style.display = "flex"
		}

	}
}
