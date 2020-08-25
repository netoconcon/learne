import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "specs", "vurl"]

  selection(e) {
    const state = e.currentTarget.value;
    console.log(state)
		if (state == 'true') {
			this.specsTarget.style.display = "none";
			this.vurlTarget.style.display = "block";
		} else if (state == 'false') {
			this.vurlTarget.style.display = "none";
			this.specsTarget.style.display = "flex";
		}
		else {
			this.vurlTarget.style.display = "none";
			this.specsTarget.style.display = "none";
		}
  }
}