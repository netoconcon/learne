import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "price", "product" ]

  pricefill() {
  	console.log(this.productTarget.dataset)
  	debugger
  	console.log(this.priceTarget.value)
  }

  makeRequest() {
  	Rails.ajax({
  		type: "POST",
			url: "/kits",

  	})
  }
}
