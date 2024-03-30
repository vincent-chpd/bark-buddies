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

  // join() {
  //   this.buttonTarget.textContent = "Attending";
  //   this.button.style.backgroundColor = "white";
  //   this.button.style.border = "1px solid #E67E22";
  //   this.button.style.color = "#E67E22";
  //   this.fakeAttendeesTarget.innerHTML = 'You and 25 others are going';

    // const fakeAttendeeNames = ["John", "Emily", "Alex", "Amy", "Tom", "Isaac", "Luca", "Harry"];

    // const randomNameIndex = Math.floor(Math.random() * fakeAttendeeNames.length);
    // const randomName = fakeAttendeeNames[randomNameIndex];

    // this.fakeAttendeesTarget.innerHTML = '';
    // const fakeAttendeesContainer = document.createElement('div');
    // fakeAttendeesContainer.classList.add('fake-attendees');

    // const fakeAttendeeElement = document.createElement('div');
    // fakeAttendeeElement.textContent = `${randomName} is going and others`;
    // fakeAttendeeElement.classList.add('small-text');
    // fakeAttendeesContainer.appendChild(fakeAttendeeElement);
    // this.fakeAttendeesTarget.appendChild(fakeAttendeesContainer);
//   }

//   leave() {
//     this.buttonTarget.textContent = "Attend";
//     this.buttonTarget.style.backgroundColor = "#E67E22";
//     this.buttonTarget.style.color = "white";
//   }
}
