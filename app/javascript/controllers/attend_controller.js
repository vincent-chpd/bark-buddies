import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="controller"
export default class extends Controller {
  static targets = ["button"];

  attend() {
    this.buttonTarget.textContent = "Attending Event";
    this.buttonTarget.style.backgroundColor = "green";
    this.buttonTarget.style.color = "black";
    this.buttonTarget.disabled = true;
    }
}
