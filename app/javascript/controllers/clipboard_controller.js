import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = ["token", "button"];
  static values = {
    feedbackText: String,
    token: String,
  };

  // connect() {
  // }

  copy() {
    const coupleToken = this.tokenTarget.innerText;
    navigator.clipboard.writeText(coupleToken);
    this.buttonTarget.innerText = this.feedbackTextValue;
    this.buttonTarget.disabled = true;
  }
}
