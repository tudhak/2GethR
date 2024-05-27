import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="confirm-partner"
export default class extends Controller {
  static values = {
    partnerConfirmed: Boolean,
    partnerRejectedCheck: Array,
    userCheck: Number,
  };

  connect() {
    let partnerRejectorsArray = this.partnerRejectedCheckValue;
    const userId = this.userCheckValue;
    const confirmPartnerModal = new bootstrap.Modal(
      document.getElementById("confirmPartnerModal")
    );
    if (!this.partnerConfirmedValue && !partnerRejectorsArray.includes(userId))
      confirmPartnerModal.show();
  }
}
