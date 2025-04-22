import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"
export default class extends Controller {
static targets = ["form", "appellation", "region", "listAppellation"]
  connect() {
  }

  submit() {
    this.formTarget.requestSubmit();
  }

  resetAppellation() {
    this.appellationTarget.value = "";
    this.formTarget.requestSubmit();
  }

  toggleRegion(){
    this.regionTarget.classList.toggle("hidden");
  }

  toggleAppellation(){
    console.log("toggleAppellation");
    console.log(this.listAppellationTarget); // 👈
    this.listAppellationTarget.classList.toggle("hidden");
  }

}
