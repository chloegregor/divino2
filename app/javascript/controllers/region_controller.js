import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="region"
export default class extends Controller {
  static targets = ["select", "create"]
  connect() {
  }

  check() {
    if (this.selectTarget.value === 'new') {
      this.createTarget.classList.remove("hidden")
    } else {
      this.createTarget.classList.add("hidden")
    }
  }


}
