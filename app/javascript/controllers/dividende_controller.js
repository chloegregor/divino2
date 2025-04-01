import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dividende"
export default class extends Controller {
  connect() {
  }

  close() {
    this.element.style.display = "none"; // Cache la modale
  }
}
