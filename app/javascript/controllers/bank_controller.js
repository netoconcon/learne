import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "label" ]
	
	name(e) {
	  const x = e.currentTarget.value;
	  const y = x.split("-");
	  const bankNum = y[0];
	  const bankName = y[1];
	  this.labelTarget.value = bankName;
	}

	search() {

	}
}