import { Controller } from "stimulus"
import $ from 'jquery';

require("select2/dist/css/select2")

import Select2 from "select2"


export default class extends Controller {
  static targets = [ "bank" ]
	
	connect() {
    $(this.currentTarget).select2();
  }
}