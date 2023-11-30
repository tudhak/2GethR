import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-task"
export default class extends Controller {
  static targets = ["firstTitle", "secondTitle", "description", "score"]

  connect() {
    console.log(this.element)
    console.log(this.firstTitleTarget)
  }

  react() {
    if (this.firstTitleTarget.value === "Other") {
      this.secondTitleTarget.classList.toggle("d-none")
    }
    if (this.secondTitleTarget.classList.includes("d-none")) {
        this.secondTitleTarget.classList.toggle("d-none")
      }
    }
  }
