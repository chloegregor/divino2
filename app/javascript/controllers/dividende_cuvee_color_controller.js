import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dividende-cuvee-color"
export default class extends Controller {
  static targets = ["template", "target"]
  connect() {

  }

  remove() {
    this.element.remove();
  }
}
