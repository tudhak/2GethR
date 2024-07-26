import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";

export default class extends Controller {
  static values = { coupleId: Number, currentUserId: Number };
  static targets = ["messages", "form"];
  // Old version : static targets = ["messages","contentInput", "form"];



  connect() {
    console.log(this.currentUserIdValue)
    this.channel = createConsumer().subscriptions.create(
      { channel: "CoupleChannel", id: this.coupleIdValue },
      { received: data => {
        this.#insertMessageAndScrollDown(data);
        this.triggerAutopilot(data);
        }
      },
    );
  }

  #insertMessageAndScrollDown(data) {
    console.log(data)
    this._updateForm(data);

    if (data.message) {
      const currentUserIsSender = this.currentUserIdValue === data.sender_id;
      const messageElement = this.#buildMessageElement(currentUserIsSender, data.message);
      this.messagesTarget.insertAdjacentHTML("beforeend", messageElement);
      const messages = Array.from(document.querySelectorAll(".message-row"))
      const lastMessage = messages[messages.length - 1]
      lastMessage.scrollIntoView({ behavior: "smooth", block: "start", inline: "nearest" });
      // ajouter ici le déclenchement de la fonction autopilot

    }
  }

  triggerAutopilot(data) {
    // console.log(data.sender_id);
    // console.log(this.currentUserIdValue);
    if (data.sender_id !== this.currentUserIdValue) {
      console.log(this.coupleIdValue);
      console.log(document.querySelector('meta[name="csrf-token"]').getAttribute('content'));
      const url = `/couples/${this.coupleIdValue}/messages/trigger_autopilot`;
      const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
      fetch(url, {
          method : "POST",
          headers : {'X-CSRF-Token': csrfToken}
          });
    }
  }

  _updateForm(data) {
    // console.log("hello from update form");
    // console.log(data);
    // console.log(data.sender_id);
    // console.log(this.currentUserIdValue);
    if (data.sender_id == this.currentUserIdValue) {
      this.formTarget.innerHTML = data.form ;
      this.formTarget.querySelector('input[type="text"]').focus();
      }
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

  // resetForm(event) {
  //   event.target.reset();
  //   // Ajout JM :
  //   // const inputElement = event.target.querySelector('input[type="text"]');
  //   // inputElement.focus()

  // }

  disconnect() {
    console.log("Unsubscribed from the chatroom");
    this.channel.unsubscribe();
  }
}
