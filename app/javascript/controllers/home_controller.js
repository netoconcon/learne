import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "date" ]

  datepick() {
  	const dateselect = this.dateTarget.value;
  	Rails.ajax({
  		type: "POST",
  		url: "/pages/index",
  		data: dateselect,
  	})
  	console.log(this.dateTarget.value)
	}
}