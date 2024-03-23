import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static targets = [ "notificationsDot", "chatNotifications" ]
  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "NotificationChannel" },
      { received: data => console.log(data) }
      )

    // this.updateNotificationsUI()
  }

  // handleNotification(data) {
  //   this.storeNotificationData(data)
  //   this.updateNotificationsUI()
  // }

  // storeNotificationData(data) {
  //   localStorage.setItem('notifications', JSON.stringify(data))
  // }

  // updateNotificationsUI() {
  //   let data = JSON.parse(localStorage.getItem('notifications'))
  //   this.renderRedDot(data)
  // }

  // renderRedDot(data) {
  //   const notificationDot = this.notificationsDotTarget
  //   const chatNotifications = this.chatNotificationsTarget

  //   console.log(data.data.unread_messages_number)

  //   if (data && data.data.unread_messages_number) {
  //     const unreadMessagesNumber = data.data.unread_messages_number
  //     const unreadMessagesDisplay = unreadMessagesNumber > 99 ? "99+" : unreadMessagesNumber

  //     if (unreadMessagesNumber > 0) {
  //       notificationDot.innerHTML += `<div class="notification-dot">${unreadMessagesDisplay}</div>`
  //       chatNotifications.innerHTML += `<div class="messages-dot">${unreadMessagesDisplay}</div>`
  //     } else {
  //       notificationDot.innerHTML = '<%= link_to conversations_path, class: "icon" do %><i class="fas fa-envelope"></i><% end %>'
  //       chatNotifications.innerHTML = '<%= link_to "Messages", conversations_path, class: "" %>'
  //     }
  //   }
  // }
}
