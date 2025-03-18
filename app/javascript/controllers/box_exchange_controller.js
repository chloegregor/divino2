import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="box-exchange"
export default class extends Controller {
  connect() {
  }
  remove() {
    this.element.remove();
  }
}
