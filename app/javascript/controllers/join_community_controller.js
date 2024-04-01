import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "chat"];

  connect() {
    this.loadState();
  }

  toggle(event) {
    const button = event.currentTarget;
    const chat = button.nextElementSibling;
    if (button.textContent === " Join community") {
      this.join(button, chat);
    } else {
      this.leave(button, chat);
    }
    this.saveState(button);
  }

  join(button, chat) {
    button.innerHTML = "<i class='fa-regular fa-circle-xmark'></i> Leave community";
    button.style.backgroundColor = "white";
    button.style.border = "1px solid #e99852";
    button.style.color = "#e99852";
    chat.classList.remove("d-none");
  }

  leave(button, chat) {
    button.style.backgroundColor = "#e99852";
    button.innerHTML = "<i class='fa-solid fa-arrow-right-to-bracket'></i> Join community";
    button.style.color = "white";
    chat.classList.add("d-none");
  }

  loadState() {
    const buttons = this.buttonTargets;
    buttons.forEach(button => {
      const chat = button.nextElementSibling;
      const id = button.dataset.communityId;
      const isJoined = localStorage.getItem(`communityJoined_${id}`) === "true";
      if (isJoined) {
        this.join(button, chat);
      } else {
        this.leave(button, chat);
      }
    });
  }

  saveState(button) {
    const id = button.dataset.communityId;
    const isJoined = button.textContent === " Leave community";
    localStorage.setItem(`communityJoined_${id}`, isJoined);
  }
}
