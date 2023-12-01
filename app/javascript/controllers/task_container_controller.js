import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task-container"
export default class extends Controller {
  static targets = ["statusInput", "assignInput", "form", "content"]

  connect() {
  }

  reveal() {
    const url = `/tasks?my_params%5Bassigned_to%5D=${this.assignInputTarget.value}&my_params%5Bstatus%5D=${this.statusInputTarget.value}&commit=Save+My+params`
    // console.log(this.formTarget.action)
    // console.log(url)
    fetch(url, {headers: {"Accept": "text/plain"}})
    .then(response => response.text())
    .then((data) => {
      console.log(data)
      console.log(this.contentTarget)
      this.contentTarget.outerHTML = data
    })
  }
}
