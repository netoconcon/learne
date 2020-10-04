import { Controller } from "stimulus"
import $ from 'jquery';

require("select2/dist/css/select2")

import Select2 from "select2"


export default class extends Controller {
  static targets = [ "label", "filter" ]
	
	name(e) {
	  const x = e.currentTarget.value;
	  const y = x.split("-");
	  const bankNum = y[0];
	  const bankName = y[1];
	  this.labelTarget.value = parseInt(bankNum);
	}

	connect() {
    $(this.filterTarget).select2();
  }
}