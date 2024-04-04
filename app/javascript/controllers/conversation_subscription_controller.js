import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="conversation-subscription"
export default class extends Controller {
  static values = { conversationId: Number, currentUserId: Number }
  static targets = ["messages"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ConversationChannel", id: this.conversationIdValue },
      { received: (data) => {
        this.insertMessageAndScrollDown(data)

      }}
    )
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  disconnect() {
    this.channel.unsubscribe()
  }


  resetForm(event) {
    event.preventDefault()
    event.target.reset()
}

  insertMessageAndScrollDown(data){
    const currentUserIsSender = this.currentUserIdValue == data.sender_id


    // Creating the whole message from the `data.message` String
    const messageElement = this.buildMessageElement(currentUserIsSender, data.message, data.time)

    // Inserting the `message` in the DOM
    this.messagesTarget.innerHTML += messageElement
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  buildMessageElement(currentUserIsSender, message, time) {
    return `
    <div class="message-block" style="${this.justifyClass(currentUserIsSender)}">
    <div class="message-container">
      <div class="message ${this.userStyleClass(currentUserIsSender)}">
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
