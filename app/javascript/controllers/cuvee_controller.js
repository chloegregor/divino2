import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cuvee"
export default class extends Controller {
  static targets = ["createCuvee","selector", "createCuveeColor"]
  connect() {

    this.check({target: {value: this.selectorTarget.value}})
  }

  check(event) {
    if (event.target.value === 'new') {
      this.showForm()
    } else {
      this.hideForm()
    }
  }

  showForm() {
    this.createCuveeTarget.classList.remove("hidden")
    this.createCuveeColorTarget.classList.add("hidden")
  }

  hideForm() {
    this.createCuveeTarget.classList.add("hidden")
    this.createCuveeColorTarget.classList.remove("hidden")
  }

  close() {
    this.element.style.display = "none"; // Cache la modale
  }
}
