import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "fakeAttendees"];

  toggle(event) {
    const button = event.currentTarget;
    const fakeAttendees = this.fakeAttendeesTarget
    if (button.textContent === "Attend") {
      this.join(button, fakeAttendees);
    } else {
      this.leave(button, fakeAttendees);
    }
  }

  join(button, fakeAttendees) {
    button.textContent = "Attending";
    button.style.backgroundColor = "white";
    button.style.border = "1px solid #E67E22";
    button.style.color = "#E67E22";
    fakeAttendees.classList.remove("d-none");
    fakeAttendees.innerHTML = 'You and 26 others are going'
  }

  leave(button, fakeAttendees) {
    button.style.backgroundColor = "#E67E22";
    button.textContent = "Attend";
    button.style.color = "white";
  }
}
