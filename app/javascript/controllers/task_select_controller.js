import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task-select"
export default class extends Controller {
static targets = ["taskHole"]

  connect() {
  }

  reveal() {
    this.taskHoleTarget.classList.toggle("d-none")
  }
}
