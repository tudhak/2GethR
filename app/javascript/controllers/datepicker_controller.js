import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

// Connects to data-controller="datepicker"
export default class extends Controller {
  // initialised targets to have different instances of flatpickr (one standard to select birthdate and one with minDate today)
  static targets = ["birthDate", "dateField"];

  connect() {
    // invoking the array of targets allows to avoid errors when the specified target does not appear on the page
    if (this.birthDateTargets[0]) {
      flatpickr(this.birthDateTargets[0], {
        disableMobile: "true",
      });
    }
    this.dateFieldTargets.forEach((dateFieldTarget) => {
      flatpickr(dateFieldTarget, {
        minDate: "today",
        disableMobile: "true",
      });
    });
  }
}
