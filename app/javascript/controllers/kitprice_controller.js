import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "product", "quantity", "sumprice", "discount"]

  pricefill(e) {
  	const hash = gon.products;
  	const prod_num = parseInt(this.productTarget.value);
  	const quant_num = parseInt(this.quantityTarget.value);
  	let result = hash.find(obj => {
  		return obj.id === prod_num;
  	})
  	this.sumpriceTarget.value = result.price_cents * quant_num;
    console.log(this.sumpriceTarget.value)
	}

  discount(){
    console.log(this.discountTarget.value)
  }
}