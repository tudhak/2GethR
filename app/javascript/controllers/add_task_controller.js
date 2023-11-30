import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-task"
export default class extends Controller {
  static targets = ["firstTitle", "secondTitle", "description", "score", "taskForm"]

  connect() {
    // console.log(this.element)
    // console.log(this.firstTitleTarget)
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

  update() {
    console.log("test")
    // this.descriptionTarget.value = this.firstTitleTarget.value
    // const url = `${this.formTarget.action}?other_params=${this.firstTitleTarget.value}`
    // console.log(url)
    // fetch(url, {headers: { "Accept": "text/plain" }})
    //     .then(response => response.text())
    //     .then((data) => {
    //       console.log(data)
    //     })
    }
  }
