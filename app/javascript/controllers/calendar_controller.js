import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="calendar"
export default class extends Controller {
static targets = ["targetDate"]

  connect() {
  }

  showEvents(event) {
    console.log(event.currentTarget)
    // const url = `/calendars?assigned_to%=${this.element.datee}&my_params%5Bstatus%5D=${this.statusInputTarget.value}&commit=Save+My+params`
    // fetch(url, {headers: {"Accept": "text/plain"}})
    // .then(response => response.text())
    // .then((data) => {
    //   this.contentTarget.outerHTML = data
    // })
  }
}
