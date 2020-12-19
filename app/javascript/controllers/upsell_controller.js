import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "collection" ]

  upsell(e) {
    const state = e.currentTarget.value
    if (state == 'true') {
      console.log("teste")
      this.collectionTarget.style.display = "block";
    }
    else {
      this.collectionTarget.style.display  = "none";
    }
  }
}