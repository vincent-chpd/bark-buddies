import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static targets = [ "notificationsDot", "chatNotifications", "envelope" ]
  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "NotificationChannel" },
      { received: data => this.handleNotification(data.data.unread_messages_number) }
      )
    this.updateNotificationsUI()
  }

  handleNotification(data) {
    this.storeNotificationData(data)
    this.updateNotificationsUI()
  }

  storeNotificationData(data = {}) {
    localStorage.setItem('notifications', JSON.stringify(data))
  }

  updateNotificationsUI() {
    this.renderRedDot(JSON.parse(localStorage.getItem('notifications')))
  }

  renderRedDot(data) {
    const notificationDot = this.notificationsDotTarget
    const chatNotifications = this.chatNotificationsTarget


    if (data) {
      const unreadMessagesDisplay = data > 99 ? "99+" : data
      const currentURL = window.location.href
      const orangeClass = currentURL.endsWith("conversations") ? "orange" : ""

      if (unreadMessagesDisplay > 0) {
        notificationDot.innerHTML += `<div class="notification-dot">${unreadMessagesDisplay}</div>`
        chatNotifications.innerHTML += `<div class="messages-dot">${unreadMessagesDisplay}</div>`
      } else {
        notificationDot.innerHTML = `
                                    <a href="/conversations" class="icon">
                                      <i class="fas fa-envelope ${orangeClass}"></i>
                                    </a>
                                    <small>MESSAGES</small>
                                    `

        chatNotifications.innerHTML = `<a href="/conversations">Messages</a>`
      }
      document.addEventListener('click', () => {
        if(currentURL.endsWith("conversations")) {
          document.querySelector('.fa-envelope').classList.add('orange')
        } else {
          document.querySelector('.fa-envelope').classList.remove('orange')
        }
      })
  }
}
}
