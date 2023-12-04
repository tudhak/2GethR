import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-generic"
export default class extends Controller {
  static targets = ["button", "editForm"]

  connect() {
  }

  display() {
    this.editFormTarget.classList.toggle("edit-display");
  }
}
