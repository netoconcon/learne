import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "label" ]
	
	name(e) {
	  const x = e.currentTarget.value;
	  this.labelTarget.value = x;
	  console.log(x)
	}
}