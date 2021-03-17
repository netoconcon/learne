import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "creditCard", "bankSlip", "slipBtn", "cardBtn", "input" ]

	bankSlip () {
  	this.slipBtnTarget.classList.add("active")
  	this.cardBtnTarget.classList.remove("active")
  	this.creditCardTarget.hidden = true
  	this.bankSlipTarget.hidden = false
	this.inputTarget.value = "bank_slip"
	}

	creditCard () {
		this.slipBtnTarget.classList.remove("active")
		this.cardBtnTarget.classList.add("active")
		this.creditCardTarget.hidden = false
		this.bankSlipTarget.hidden = true
		this.inputTarget.value = "credit_card"
	}
}
