import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { communityId: Number, currentUserId: Number }
  static targets = ["messages"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "CommunityChannel", id: this.communityIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
    )
    console.log(`Subscribe to the community with the id ${this.communityIdValue}.`)
  }

  resetForm(event) {
    event.preventDefault()
    event.target.reset()
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  }

  #insertMessageAndScrollDown(data) {
    const currentUserIsSender = this.currentUserIdValue == data.sender_id
    const messageElement = this.buildMessageElement(currentUserIsSender, data.message, data.time, data.sender_name)

    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  buildMessageElement(currentUserIsSender, message, time, name) {
    const sender = currentUserIsSender ? "" : `<p><strong>${name}</strong></p>`
    return `
    <div class="message-block" style="${this.justifyClass(currentUserIsSender)}">
    <div class="message-container">
      <div class="message ${this.userStyleClass(currentUserIsSender)}">
        ${sender}
        ${message}
        <small>${time}</small>
      </div>
    </div>
    </div>
    `
  }

  justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content:flex-end;" : "justify-content:flex-start;"
  }

  userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "user-message" : "other-user-message"
  }
}
