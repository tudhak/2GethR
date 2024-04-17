import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="confirm-partner"
export default class extends Controller {
  static values = {
    partnerConfirmed: Boolean,
  };

  connect() {
    const confirmPartnerModal = new bootstrap.Modal(
      document.getElementById("confirmPartnerModal")
    );
    if (!this.partnerConfirmedValue) confirmPartnerModal.show();
  }
}
