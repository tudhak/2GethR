import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";

export default class extends Controller {
  static values = { coupleId: Number, currentUserId: Number };
  static targets = ["messages","contentInput", "form"];

  connect() {
    console.log(this.currentUserIdValue)
    this.channel = createConsumer().subscriptions.create(
      { channel: "CoupleChannel", id: this.coupleIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
    );
  }

  #insertMessageAndScrollDown(data) {
    console.log(data)
    this._updateForm(data.form);

    if (data.message) {
      const currentUserIsSender = this.currentUserIdValue === data.sender_id;
      const messageElement = this.#buildMessageElement(currentUserIsSender, data.message);
      this.messagesTarget.insertAdjacentHTML("beforeend", messageElement);
      const messages = Array.from(document.querySelectorAll(".message-row"))
      const lastMessage = messages[messages.length - 1]
      lastMessage.scrollIntoView({ behavior: "smooth", block: "start", inline: "nearest" });
    }
  }

  _updateForm(form) {
    this.formTarget.innerHTML = form;
  }

  #buildMessageElement(currentUserIsSender, message) {
    return `
      <div class="message-row d-flex ${this.#justifyClass(currentUserIsSender)}">
        <div class="${this.#userStyleClass(currentUserIsSender)}">
          ${message}
        </div>
      </div>
    `;
  }

  #justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-end" : "justify-content-start";
  }

  #userStyleClass(currentUserIsSender) {
    return !currentUserIsSender ? "sender-style" : "receiver-style";
  }

  resetForm(event) {
    event.target.reset();
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom");
    this.channel.unsubscribe();
  }
}
