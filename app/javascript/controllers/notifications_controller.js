import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = [ "notificationsDot", "chatNotifications" ]
  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "NotificationChannel" },
      { received: data => this.renderRedDot(data) }
    )
  }

  renderRedDot(data) {
    const notificationDot = this.notificationsDotTarget
    const chatNotifications = this.chatNotificationsTarget
    let unread_messages_number = data.data.unread_messages_number
    const unreadMessagesNumber = unread_messages_number > 99 ? "99+" : unread_messages_number
    if (unreadMessagesNumber) {
      if (unreadMessagesNumber > 0) {
        notificationDot.innerHTML += `<div class="notification-dot">${unreadMessagesNumber}</div>`
        chatNotifications.innerHTML += `<div class="messages-dot">${unreadMessagesNumber}</div>`
      }
    }
  }

}
