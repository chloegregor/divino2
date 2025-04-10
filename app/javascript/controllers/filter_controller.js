import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"
export default class extends Controller {
  static targets = ["form", "appellation"]
  connect() {
  }

  submit() {
    this.formTarget.requestSubmit();
  }

  resetAppellation() {
    this.appellationTarget.value = "";
    this.formTarget.requestSubmit();
  }

}
