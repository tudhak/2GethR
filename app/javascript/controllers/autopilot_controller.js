import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  // connect() {
  //   console.log("hello from autopilot controller");
  // }

  toggle () {
    // console.log("hello from autopilot toggle method");

    const url = this.element.dataset.autopilotUrl;
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    // console.log(url);
    // console.log(csrfToken);

    fetch(url, {
      method : "POST",
      headers : {'X-CSRF-Token': csrfToken}
      });
  }
}
