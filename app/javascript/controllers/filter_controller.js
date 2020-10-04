import { Controller } from "stimulus"
import $ from 'jquery';



export default class extends Controller {
  static targets = [ "filter", "bcode" ]
  connect() {
    $(this.filterTarget).on('select2:select', function (e) {
      const aux = e.params.data.text.split("-");
      const bankNum = aux[0];
      const bankName = aux[1];
      this.bcodeTarget = parseInt(bankNum);
      console.log(this.bcodeTarget)
    });
  }
  teste() {
    console.log("aaa")
  }
}