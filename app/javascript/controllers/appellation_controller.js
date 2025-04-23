import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="appellation"
export default class extends Controller {
  static targets = ["create", "button", "select"]

  connect() {
    this.check()
  }

  check() {
    if (this.selectTarget.value === 'new') {
      this.showForm()
    } else {
      this.hideForm()
    }
  }

  showForm() {
    this.createTarget.classList.remove("hidden")
    this.buttonTarget.classList.add("hidden")
  }

  hideForm() {
    this.createTarget.classList.add("hidden")
    this.buttonTarget.classList.remove("hidden")
  }

  close(){
    this.element.style.display = "none"; // Cache la modale
  }
}
