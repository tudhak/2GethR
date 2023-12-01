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
      this.secondTitleTarget.value = ""
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

  fill() {
    if (this.firstTitleTarget.value !== "Other") {
      this.secondTitleTarget.value = this.firstTitleTarget.value
    }
  }

  autoComplete() {
    // event.preventDefault();
    // const url = this.taskFormTarget.action
    // const url = `${this.taskFormTarget.action}?other_params[title]=${this.firstTitleTarget.value}`
    // console.log(url)
    // fetch(url, {
      // method: "POST",
      // headers: { "Accept": "text/plain" },
      // body: new FormData(this.taskFormTarget)
    // })
    //   .then(response => response.text())
    //   .then((data) => {
    //     console.log(data)
        // this.descriptionTarget.value = data
        // })
    }
  }
