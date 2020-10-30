import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [  ]

  fields(e) {
    console.log(e)
  }
}