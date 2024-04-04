import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "fakeAttendees"];

  toggle(event) {
    const button = event.currentTarget;
    const fakeAttendees = this.fakeAttendeesTarget
    if (button.textContent === " Attend") {
      this.join(button, fakeAttendees);
    } else {
      this.leave(button, fakeAttendees);
    }
  }

  join(button, fakeAttendees) {
    button.innerHTML = "<i class='fa-regular fa-square-check'></i> Attending";
    button.style.backgroundColor = "white";
    button.style.border = "1px solid #e99852";
    button.style.color = "#e99852";
    fakeAttendees.classList.remove("d-none");
    fakeAttendees.innerHTML = 'You and 53 others are going'
  }

  leave(button, fakeAttendees) {
    button.style.backgroundColor = "#e99852";
    button.innerHTML = "<i class='fa-solid fa-bell-concierge'></i> Attend";
    button.style.color = "white";
    fakeAttendees.innerHTML = 'Tom and 52 others are going'
  }
}
