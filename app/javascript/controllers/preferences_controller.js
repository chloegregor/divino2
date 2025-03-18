import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["address", "deliveryMethod"]
  connect() {
    console.log("Stimulus chargé pour les préférences");
    this.ToggleAddress();

  }


  ToggleAddress(event) {
    const SelectedValue = this.deliveryMethodTarget.value || event?.target?.value;

    if (SelectedValue === "pickup") {
      this.addressTarget.classList.add("hidden");
    }
    else {
      this.addressTarget.classList.remove("hidden");
    }
  }

  close() {
    this.element.style.display = "none"; // Cache la modale
  }
}
