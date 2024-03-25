import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "fakeAttendees"];

  toggle() {
    if (this.buttonTarget.textContent === "Attend") {
      this.join();
    } else {
      this.leave();
    }
  }

  join() {
    this.buttonTarget.textContent = "Attending";
    this.buttonTarget.style.backgroundColor = "#e27c3d1c;";
    this.buttonTarget.style.color = "white";

    const fakeAttendeeNames = ["John", "Emily", "Alex", "Sophia", "Tom", "Isaac", "Luca", "Harry"];

    const randomNameIndex = Math.floor(Math.random() * fakeAttendeeNames.length);
    const randomName = fakeAttendeeNames[randomNameIndex];

    this.fakeAttendeesTarget.innerHTML = '';
    const fakeAttendeesContainer = document.createElement('div');
    fakeAttendeesContainer.classList.add('fake-attendees');

    const fakeAttendeeElement = document.createElement('div');
    fakeAttendeeElement.textContent = `${randomName} is going and others`;
    fakeAttendeeElement.classList.add('small-text');
    fakeAttendeesContainer.appendChild(fakeAttendeeElement);
    this.fakeAttendeesTarget.appendChild(fakeAttendeesContainer);
  }

  leave() {
    this.buttonTarget.textContent = "Attend";
    this.buttonTarget.style.backgroundColor = "#e27835";
    this.buttonTarget.style.color = "white";
    this.fakeAttendeesTarget.innerHTML = '';
  }
}
