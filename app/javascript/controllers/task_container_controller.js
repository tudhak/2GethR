import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task-container"
export default class extends Controller {
  static targets = ["content"]

  connect() {
  }

  reveal() {
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    fetch(url, {headers: {"Accept": "text/plain"}})
    .then(response => response.text())
    .then((data) => {
      this.contentTarget.outerHTML = data
    })
  }
}
