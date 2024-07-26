import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="rejected-partner"
export default class extends Controller {
  static values = {
    userRejectedCheck: Array,
    partnerCheck: Number,
  };

  connect() {
    let userRejectorsArray = this.userRejectedCheckValue;
    if (userRejectorsArray) {
      const partnerId = this.partnerCheckValue;
      // console.log(userRejectorsArray, partnerId);
      const rejectedModal = new bootstrap.Modal(
        document.getElementById("rejectedModal")
      );
      if (userRejectorsArray.includes(partnerId)) rejectedModal.show();
    }
  }
}
