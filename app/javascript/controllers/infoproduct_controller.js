import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "specs", "vurl"]

  selection(e) {
    const state = e.currentTarget.value;
    console.log(state)
		if (state == 'false') {
			this.specsTarget.style.display = "block";
			this.vurlTarget.style.display = "none";
		} else if (state == 'true') {
			this.vurlTarget.style.display = "block";
			this.specsTarget.style.display = "none";
		}
		else {
			this.vurlTarget.style.display = "none";
			this.specsTarget.style.display = "none";
		}
  }
}