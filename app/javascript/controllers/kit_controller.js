import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "plan", "installments" ]

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
