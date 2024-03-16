import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = [ "messages" ]
  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "NotificationChannel" },
      { received: data => this.renderRedDot(data) }
    )
  }

  renderRedDot(data) {
    const notificationsContainer = this.messagesTarget
    const redDot = `<span class="red-dot"></span>`
    notificationsContainer.insertAdjacentHTML('beforeend', redDot)
  }

}
