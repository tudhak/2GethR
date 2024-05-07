import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="rejected-partner"
export default class extends Controller {
  static values = {
    userRejectedCheck: Array,
    partnerCheck: Number,
  };

  connect() {
    const rejectorsArray = this.userRejectedCheckValue;
    const partnerId = this.partnerCheckValue;
    console.log(rejectorsArray, partnerId);
    const rejectedModal = new bootstrap.Modal(
      document.getElementById("rejectedModal")
    );
    if (rejectorsArray.includes(partnerId)) rejectedModal.show();
  }
}
