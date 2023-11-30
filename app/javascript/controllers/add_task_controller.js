import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-task"
export default class extends Controller {
  static targets = ["firstTitle", "secondTitle", "description", "score"]

  connect() {
    console.log(this.element)
    console.log(this.firstTitleTarget)
  }

  toggle() {
    if (this.firstTitleTarget.value === "Other") {
      this.secondTitleTarget.classList.toggle("d-none")
      this.secondTitleTarget.classList.add("revealed")
    }
    }

  untoggle() {
      if (this.firstTitleTarget.value !== "Other" && this.secondTitleTarget.classList.contains("revealed")) {
        this.secondTitleTarget.classList.toggle("d-none")
        this.secondTitleTarget.classList.remove("revealed")
      }
    }


  }
