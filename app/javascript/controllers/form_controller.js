import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "price", "product" ]

  pricefill() {
  	console.log(this.productTarget.dataset)
  }
}
