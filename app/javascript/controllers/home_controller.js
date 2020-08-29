import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "date" ]

  datepick() {
  	console.log(this.dateTarget.value)
	}
}