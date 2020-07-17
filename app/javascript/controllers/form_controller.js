import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "price", "product" ]

  connect() {
    console.log(this.productTarget);
  }

  pricefill() {
  	var name = this.productTarget.value;
  	console.log(this.productTarget.dataset.isa)
  }
}
