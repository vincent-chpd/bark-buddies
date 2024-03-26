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


  //   if (data) {
  //     const unreadMessagesDisplay = data > 99 ? "99+" : data

  //     if (unreadMessagesDisplay > 0) {
  //       notificationDot.innerHTML += `<div class="notification-dot">${unreadMessagesDisplay}</div>`
  //       chatNotifications.innerHTML += `<div class="messages-dot">${unreadMessagesDisplay}</div>`
  //     } else {
  //       notificationDot.innerHTML = `
  //                                   <a href="/conversations" class="icon">
  //                                     <i class="fas fa-envelope"></i>
  //                                   </a>
  //                                   <small>CHATS</small>
  //                                   `
  //       chatNotifications.innerHTML = `<a href="/conversations">Messages</a>`
  //     }
  //   }
  // }
}
