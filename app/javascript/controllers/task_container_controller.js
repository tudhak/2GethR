import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task-container"
export default class extends Controller {
  static targets = ["statueInput", "assignInput", "form"]

  connect() {
    // console.log(this.element)
    // console.log(this.statueInputTarget)
    // console.log(this.assignInputTarget)
    // console.log(this.formTarget)
  }

  reveal(event) {
    event.preventDefault()
    console.log("coucou")
    const url = `/tasks?my_params%5Bassigned_to%5D=${this.assignInputTarget.value}&my_params%5Bstatue%5D=${this.statueInputTarget.value}&commit=Save+My+params`
    console.log(this.formTarget.action)
    console.log(url)
    fetch(url, {headers: {"Accept": "text/plain"}})
    .then(response => response.text())
    .then((data) => {
      console.log(data)
      console.log(this.contentTarget)
      this.contentTarget.outerHTML = data
    })
  }
}
