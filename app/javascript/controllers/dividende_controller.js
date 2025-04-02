import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dividende"
export default class extends Controller {
  static targets = ["cuveeColor"]
  connect() {
  }

  close() {
    this.element.style.display = "none"; // Cache la modale
  }

  remove() {
    this.cuveeColorTarget.style.display = "none"; // Cache la modale
  }
}
