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
    this.buttonTarget.style.backgroundColor = "white";
    this.buttonTarget.style.border = "1px solid #E67E22";
    this.buttonTarget.style.color = '##E67E22';
    this.chatTarget.classList.remove("d-none");
  }

  leave() {
    this.buttonTarget.style.backgroundColor = '#E67E22';
    this.buttonTarget.textContent = "Join community";
    this.buttonTarget.style.color = "black";
    this.chatTarget.classList.add("d-none");
  }
}
