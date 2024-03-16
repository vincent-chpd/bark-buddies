import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = [ "notificationsDot" ]
  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "NotificationChannel" },
      { received: data => this.renderRedDot(data) }
    )
  }

  renderRedDot(data) {
    // const notificationDot = this.notificationsDotTarget
    const unreadMessagesNumber = data.data.unread_messages_number
    if (unreadMessagesNumber) {
      if (unreadMessagesNumber > 0) {
        this.notificationsDotTarget.innerHTML += `<span class="notification-dot">${unreadMessagesNumber}</span>`
      }
    }
    // const redDot = `<i class="fa-solid fa-circle"></i>`
    // notificationsContainer.insertAdjacentHTML('beforeend', redDot)
  }

}
