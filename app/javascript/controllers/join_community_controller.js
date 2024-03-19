import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="join-community"
export default class extends Controller {
  static targets = ["button", "chat"];

  toggle() {
    if (this.buttonTarget.textContent === "Join community") {
      this.join();
    } else {
      this.leave();
    }
  }

  join() {
    this.buttonTarget.textContent = "Leave community";
    this.buttonTarget.style.backgroundColor = "red";
    this.buttonTarget.style.color = "white";
    this.chatTarget.classList.remove("d-none");
  }

  leave() {
    this.buttonTarget.textContent = "Join community";
    this.buttonTarget.style.backgroundColor = "#e27835";
    this.buttonTarget.style.color = "black";
    this.chatTarget.classList.add("d-none");
  }
}
