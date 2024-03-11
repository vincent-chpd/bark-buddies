import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  connect() {
    this.subscription = consumer.subscriptions.create(
      { channel: "NotificationChannel" },
      { received: (data) => { console.log(data) }}
    )
  }
}
