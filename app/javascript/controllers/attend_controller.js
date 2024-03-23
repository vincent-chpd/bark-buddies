import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="controller"
export default class extends Controller {
  static targets = ["button", "fakeAttendees"];

  toggle() {
    if (this.buttonTarget.textContent ==='attending'){
      this.unattend();
    } else {
      this.attend();
    }
  }

  attend() {
    // Change button appearance
    this.buttonTarget.textContent = "Attending Event";
    this.buttonTarget.style.backgroundColor = "green";
    this.buttonTarget.style.color = "black";
    this.buttonTarget.disabled = true;
    this.buttonTarget.classList.add('attending'); // Add attending class

    // Simulate generating fake attendees
    const fakeAttendees = [
      { name: 'John Doe'},
      { name: 'Jane Smith'},
    ];

    const firstAttendee = fakeAttendees[0];
    const otherAttendees = fakeAttendees.slice(1);

    // Clear existing fake attendees
    this.fakeAttendeesTarget.innerHTML = '';

    // Append first attendee
    if (firstAttendee) {
      const firstAttendeeElement = document.createElement('div');
      firstAttendeeElement.classList.add('fake-attendee');
      firstAttendeeElement.innerHTML = `
        <p>${firstAttendee.name}</p>
      `;
      this.fakeAttendeesTarget.appendChild(firstAttendeeElement);
    }

    // Append "others" group
    if (otherAttendees.length > 0) {
      const othersGroupElement = document.createElement('div');
      othersGroupElement.classList.add('fake-attendee');
      othersGroupElement.innerHTML = `
        <p>Others:</p>
      `;
      this.fakeAttendeesTarget.appendChild(othersGroupElement);

      // Append other attendees
      otherAttendees.forEach(attendee => {
        const attendeeElement = document.createElement('div');
        attendeeElement.innerHTML = `
          <p>${attendee.name}</p>
        `;
        othersGroupElement.appendChild(attendeeElement);
      });
    }
  }

  unattend() {
    // Reset button appearance
    this.buttonTarget.textContent = "Attend";
    this.buttonTarget.style.backgroundColor = "";
    this.buttonTarget.style.color = "red";
    this.buttonTarget.disabled = false;
    this.buttonTarget.classList.remove('attending');
    this.fakeAttendeesTarget.innerHTML = '';
  }
}
